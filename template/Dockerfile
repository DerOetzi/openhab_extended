FROM openhab/openhab:%version%-%arch%-debian

## Where will we install jython inside container
ARG JYTHON_HOME="/opt/jython"
ARG JYTHON_VERSION="2.7.0"
ARG APPDIR="/openhab"

MAINTAINER Johannes Ott <info@johannes-ott.net>

ENV APPDIR="/openhab" \
    SIGNAL_DIR="/signal-cli" \
    SIGNAL_VERSION="%signal_version%" \
    CRYPTO_POLICY="unlimited" \
    JYTHON_HOME="${JYTHON_HOME}" \
    JYTHON_JAVA_OPTS="-Xbootclasspath/a:${JYTHON_HOME}/jython.jar -Dpython.home=${JYTHON_HOME} -Dpython.path=${JYTHON_HOME}/lib:${APPDIR}/conf/automation/lib/python"

RUN wget -q -O /tmp/signal-cli-${SIGNAL_VERSION}.tar.gz https://github.com/AsamK/signal-cli/releases/download/v${SIGNAL_VERSION}/signal-cli-${SIGNAL_VERSION}.tar.gz && \
    tar xvzf /tmp/signal-cli-${SIGNAL_VERSION}.tar.gz -C /tmp && \
    mkdir -p ${SIGNAL_DIR}/data && \
    cp -rv /tmp/signal-cli-${SIGNAL_VERSION}/* ${SIGNAL_DIR}/ && \
    rm -rf /tmp/signal* && \
    ln -s ${SIGNAL_DIR}/bin/signal-cli /usr/local/bin && \
    echo "#!/bin/bash -x\n${SIGNAL_DIR}/bin/signal-cli --config ${SIGNAL_DIR} -u \${SIGNAL_NUMBER} \$@" >> /usr/local/bin/signal && \
    chmod +x /usr/local/bin/signal && \
    mkdir -p ${JYTHON_HOME} && \
    wget https://search.maven.org/remotecontent?filepath=org/python/jython-standalone/${JYTHON_VERSION}/jython-standalone-${JYTHON_VERSION}.jar -O ${JYTHON_HOME}/jython.jar && \
    chmod -R o+w ${JYTHON_HOME} && \
    mkdir ${JYTHON_HOME}/lib/ && \
    apt-get update && apt-get install --no-install-recommends -y python-pip && \
    cd /tmp && \
    PYTHONUSERBASE=. pip install --user influxdb && \
    PYTHONUSERBASE=. pip install --user astral && \
    cp -r /tmp/lib/python2.7/site-packages/* ${JYTHON_HOME}/lib/ && \
    rm -r /tmp/* && apt-get purge -y python-pip && apt autoremove -y && apt-get clean 
    
ADD cont-init.d/* /etc/cont-init.d/

VOLUME ${SIGNAL_DIR}/data

WORKDIR ${APPDIR}
ENTRYPOINT ["/entrypoint.sh"]
CMD ["gosu", "openhab", "tini", "-s", "./start.sh"]
