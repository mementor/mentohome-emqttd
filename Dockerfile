FROM alpine:3.4
MAINTAINER Roman Kubar <a@mne.li>

ENV EMQTTD_VERSION=master

RUN apk --no-cache add \
        perl \
        git \
        make \
        bash \
        erlang \
        erlang-public-key \
        erlang-syntax-tools \
        erlang-erl-docgen \
        erlang-gs \
        erlang-observer \
        erlang-ssh \
        erlang-ose \
        erlang-cosfiletransfer \
        erlang-runtime-tools \
        erlang-os-mon \
        erlang-tools \
        erlang-cosproperty \
        erlang-common-test \
        erlang-dialyzer \
        erlang-edoc \
        erlang-otp-mibs \
        erlang-crypto \
        erlang-costransaction \
        erlang-odbc \
        erlang-inets \
        erlang-asn1 \
        erlang-snmp \
        erlang-erts \
        erlang-et \
        erlang-cosnotification \
        erlang-xmerl \
        erlang-typer \
        erlang-coseventdomain \
        erlang-stdlib \
        erlang-diameter \
        erlang-hipe \
        erlang-ic \
        erlang-eunit \
        erlang-webtool \
        erlang-mnesia \
        erlang-erl-interface \
        erlang-test-server \
        erlang-sasl \
        erlang-jinterface \
        erlang-kernel \
        erlang-orber \
        erlang-costime \
        erlang-percept \
        erlang-dev \
        erlang-eldap \
        erlang-reltool \
        erlang-debugger \
        erlang-ssl \
        erlang-megaco \
        erlang-parsetools \
        erlang-cosevent \
        erlang-compiler \
    && git clone -b ${EMQTTD_VERSION} https://github.com/emqtt/emqttd-relx.git /emqttd-relx \
    && cd /emqttd-relx \
    && make \
    && mv /emqttd-relx/_rel/emqttd /emqttd \
    && rm -rf /emqttd-relx \
    && apk remove make git perl \
    && rm -rf /var/cache/apk/*

WORKDIR /emqttd

ENV TINI_VERSION v0.10.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static /bin/tini
RUN chmod +x /bin/tini
ENTRYPOINT ["/bin/tini", "--"]

# start emqttd and initial environments
CMD ["/emqttd/bin/emqttd", "foreground"]

VOLUME ["/emqttd/etc", "/emqttd/data", "/emqttd/plugins"]

# emqttd will occupy 1883 port for MQTT, 8883 port for MQTT(SSL), 8083 for WebSocket/HTTP, 18083 for dashboard
EXPOSE 1883 8883 8083 18083

