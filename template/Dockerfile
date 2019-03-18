FROM openhab/openhab:%version%-%arch%-debian

MAINTAINER Johannes Ott <info@johannes-ott.net>

ENV APPDIR="/openhab" \
    SIGNAL_DIR="/signal-cli" \
    SIGNAL_VERSION="0.6.2" \
    CRYPTO_POLICY="unlimited"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        python-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

RUN pip install speedtest-cli

RUN wget -O /tmp/signal-cli-${SIGNAL_VERSION}.tar.gz https://github.com/AsamK/signal-cli/releases/download/v${SIGNAL_VERSION}/signal-cli-${SIGNAL_VERSION}.tar.gz && \
    tar xvzf /tmp/signal-cli-${SIGNAL_VERSION}.tar.gz -C /tmp && \
    mkdir -p ${SIGNAL_DIR}/data && \
    cp -rv /tmp/signal-cli-${SIGNAL_VERSION}/* ${SIGNAL_DIR}/ && \
    rm -rf /tmp/signal* && \
    ln -s ${SIGNAL_DIR}/bin/signal-cli /usr/local/bin && \
    echo "#!/bin/bash -x\n${SIGNAL_DIR}/bin/signal-cli --config ${SIGNAL_DIR} -u \${SIGNAL_NUMBER} \$@" >> /usr/local/bin/signal && \
    chmod +x /usr/local/bin/signal

VOLUME ${SIGNAL_DIR}/data

WORKDIR ${APPDIR}
ENTRYPOINT ["/entrypoint.sh"]
CMD ["gosu", "openhab", "tini", "-s", "./start.sh"]
