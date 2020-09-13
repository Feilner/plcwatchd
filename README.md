# plcwatchd

* Observe plc state of a simatic plc using [snap7](http://snap7.sourceforge.net/).
* Send push notifications via pushover-api in case of plc left RUN state.
* Run as a linux-daemon process

## build and install

### precondition
* sudo add-apt-repository ppa:gijzelaar/snap7
* sudo apt-get update
* sudo apt-get install libsnap7-dev libsnap7-1
* sudo apt-get install libcurl4-gnutls-dev
* sudo apt-get install rapidjson-dev

### build
* cd Release
* make clean all
* cd ..

### install
* sudo cp Release/plcwatchd /usr/local/bin/
* cp plcwatchd.service.draft ../plcwatchd.service
* vi plcwatchd.service
* sudo cp plcwatchd.service /etc/systemd/system
* sudo systemctl enable plcwatchd

## Service

### start
* sudo systemctl start plcwatchd

### stop
* sudo systemctl stop plcwatchd

### status
* sudo systemctl status plcwatchd
or
* ps aux | grep plcwatchd



## Docker

There is also a docker image avaiable with the follwing environment variables:

* `PUSHOVER_KEY` pushover.net user key
* `PUSHOVER_TOKEN` pushover.net appliacation token
* `PUSHOVER_DEVICE` pushover.net device list e.g. dev1,dev2
* `PLC_IP` address of the plc

Run from command line:
```
docker run -it --rm -e PUSHOVER_KEY=xxxxxxxx -e PUSHOVER_TOKEN=xxxxxxxx -e PUSHOVER_DEVICE=xxxxxxxx -e PLC_IP=192.168.178.105  feilner/plcwatchd
```

Example docker-compose.yml:
```
  plcwatchd: 
    image: feilner/plcwatchd
    container_name: plcwatchd
    restart: always
    environment:
    - PUSHOVER_KEY=xxxxxxxx
    - PUSHOVER_TOKEN=xxxxxxxx
    - PUSHOVER_DEVICE=xxxxxxxx
    - PLC_IP=xxxxxxxx
```
