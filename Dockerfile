FROM gijzelaerr/snap7
RUN apt-get update
RUN apt-get install -y libcurl4-gnutls-dev rapidjson-dev
COPY Release/plcwatchd /usr/local/bin/plcwatchd
RUN chmod +x /usr/local/bin/plcwatchd
COPY dockerrun /dockerrun
RUN chmod +x /dockerrun

CMD ["/dockerrun"]
