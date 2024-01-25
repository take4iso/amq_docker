FROM apache/activemq-artemis:latest-alpine

ARG CONFIGFILE

#オーバーライド用フォルダを作成し、設定ファイルをコピー
RUN mkdir -p /var/lib/artemis-instance/etc-override
COPY ${CONFIGFILE} /var/lib/artemis-instance/etc-override/broker.xml

