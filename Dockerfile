FROM debian:buster-slim

RUN groupadd -g 1000 boinc \
    && useradd -r -u 1000 -g boinc -s /usr/sbin/nologin -d /var/lib/boinc-client boinc \
    && apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install --no-install-recommends -y ca-certificates boinc-client tzdata \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /opt/boinc \
    && chown boinc:boinc -R /opt/boinc \
    && update-ca-certificates --fresh

COPY entrypoint.sh /entrypoint.sh
RUN chown boinc:boinc /entrypoint.sh && chmod +x /entrypoint.sh

USER boinc

WORKDIR "/opt/boinc"

COPY files/cc_config.xml /tmp/cc_config.xml
COPY files/global_prefs_override.xml /tmp/global_prefs_override.xml

VOLUME /opt/boinc

EXPOSE 31416

CMD ["/entrypoint.sh"]
