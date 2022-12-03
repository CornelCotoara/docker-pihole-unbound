#On demand build comm
FROM pihole/pihole:latest
RUN apt update && apt install -y unbound wget

COPY one-container/pihole-unbound/lighttpd-external.conf /etc/lighttpd/external.conf 
COPY one-container/pihole-unbound/unbound-pihole.conf /etc/unbound/unbound.conf.d/pi-hole.conf
COPY one-container/pihole-unbound/99-edns.conf /etc/dnsmasq.d/99-edns.conf
RUN mkdir -p /etc/services.d/unbound
COPY one-container/pihole-unbound/unbound-run /etc/services.d/unbound/run
RUN wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
ENTRYPOINT ./s6-init
