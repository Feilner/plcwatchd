FROM ubuntu:18.04
RUN apt-get update && apt-get install -y --no-install-recommends software-properties-common
RUN add-apt-repository ppa:gijzelaar/snap7 && apt-get update && apt-get install -y --no-install-recommends libsnap7-1 libcurl3-gnutls

COPY Release/plcwatchd /usr/local/bin/plcwatchd
RUN chmod +x /usr/local/bin/plcwatchd
COPY dockerrun /dockerrun
RUN chmod +x /dockerrun

CMD ["/dockerrun"]
