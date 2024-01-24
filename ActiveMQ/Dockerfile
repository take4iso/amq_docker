FROM apache/activemq-artemis:latest-alpine

ARG CONFIG

# クラスターを構成するために、broker.xmlを上書きする
COPY $CONFIG /var/lib/artemis-instance/etc/broker.xml

