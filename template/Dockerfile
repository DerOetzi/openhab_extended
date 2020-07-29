FROM openhab/openhab:%version%-debian

MAINTAINER Johannes Ott <info@johannes-ott.net>

ARG JYTHON_HOME="/opt/jython"
ARG APPDIR="/openhab"

ENV APPDIR="${APPDIR}" \
    SIGNAL_DIR="/signal-cli" \
    SIGNAL_VERSION="%signal_version%" \
    CRYPTO_POLICY="unlimited" \
    JYTHON_HOME="${JYTHON_HOME}" \
    JYTHON_VERSION="2.7.2" \
    JYTHON_JAVA_OPTS="-Xbootclasspath/a:${JYTHON_HOME}/jython.jar -Dpython.home=${JYTHON_HOME} -Dpython.path=${JYTHON_HOME}/Lib:${APPDIR}/conf/automation/lib/python"

RUN wget -q -O /tmp/signal-cli-${SIGNAL_VERSION}.tar.gz https://github.com/AsamK/signal-cli/releases/download/v${SIGNAL_VERSION}/signal-cli-${SIGNAL_VERSION}.tar.gz && \
    tar xvzf /tmp/signal-cli-${SIGNAL_VERSION}.tar.gz -C /tmp && \
    mkdir -p ${SIGNAL_DIR}/data && \
    cp -rv /tmp/signal-cli-${SIGNAL_VERSION}/* ${SIGNAL_DIR}/ && \
    rm -rf /tmp/signal* && \
    ln -s ${SIGNAL_DIR}/bin/signal-cli /usr/local/bin && \
    echo "#!/bin/bash -x\n${SIGNAL_DIR}/bin/signal-cli --config ${SIGNAL_DIR} -u \${SIGNAL_NUMBER} \$@" >> /usr/local/bin/signal && \
    chmod +x /usr/local/bin/signal && \
    mkdir -p ${JYTHON_HOME} && \
    wget https://search.maven.org/remotecontent?filepath=org/python/jython-installer/${JYTHON_VERSION}/jython-installer-${JYTHON_VERSION}.jar -O /tmp/jython-installer.jar && \
    java -jar /tmp/jython-installer.jar -s -d ${JYTHON_HOME}/ -t standard -i mod -i ensurepip -e demo doc src && \
    rm /tmp/jython-installer.jar && \
    chmod -R o+w ${JYTHON_HOME} && \
    java -jar ${JYTHON_HOME}/jython.jar -m pip install astral icalendar requests
    
ADD cont-init.d/* /etc/cont-init.d/

VOLUME ${SIGNAL_DIR}/data
