ARG VERSION

FROM openhab/openhab:${VERSION}-debian

MAINTAINER Johannes Ott <info@johannes-ott.net>

ARG JYTHON_HOME="/opt/jython"
ARG APPDIR="/openhab"
ARG SIGNAL_VERSION

ENV APPDIR="${APPDIR}" \
    SIGNAL_DIR="/signal-cli" \
    CRYPTO_POLICY="unlimited" 

RUN echo "Installing Signal ${SIGNAL_VERSION}" && \
    wget -O /tmp/signal-cli-${SIGNAL_VERSION}.tar.gz https://github.com/AsamK/signal-cli/releases/download/v${SIGNAL_VERSION}/signal-cli-${SIGNAL_VERSION}.tar.gz && \
    tar xvzf /tmp/signal-cli-${SIGNAL_VERSION}.tar.gz -C /tmp && \
    mkdir -p ${SIGNAL_DIR}/data && \
    cp -rv /tmp/signal-cli-${SIGNAL_VERSION}/* ${SIGNAL_DIR}/ && \
    rm -rf /tmp/signal* && \
    ln -s ${SIGNAL_DIR}/bin/signal-cli /usr/local/bin && \
    echo "#!/bin/bash -x\n${SIGNAL_DIR}/bin/signal-cli --config ${SIGNAL_DIR} -u \${SIGNAL_NUMBER} \$@" >> /usr/local/bin/signal && \
    chmod +x /usr/local/bin/signal

VOLUME ${SIGNAL_DIR}/data
