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

There is also a docker image:
`docker pull feilner/plcwatchd`

### Environment variables
* `PUSHOVER_KEY` pushover.net user key (mandatory)
* `PUSHOVER_TOKEN` pushover.net appliacation token (mandatory)
* `PLC_IP` address of the plc (mandatory)
* `CLI_ARGS` optional command line interface args to plcwatchd (optional)

Optional arguments to plcwatchd can added by the optional CLI_ARGS
```
 -v    verbose
 -p    polling rate of the PLC state in seconds, default 10
 -c    retry - pushover.net retry parameter in seconds, default 60
 -e    expire - pushover.net expire parameter in seconds, default 600
 -u    user - pushover.net comma seprated device list e.g. "deviceOne,deviceTwo", default all devices
 -r    rack - rack of the plc, default 0
 -s    slot - slot of the plc, default 2
```

### Run from command line:
```
docker run -it --rm -e PUSHOVER_KEY=pushoverKey -e PUSHOVER_TOKEN=pushoverToken -e PLC_IP=plcIP -e CLI_ARGS "-u pushoverDeivce"  feilner/plcwatchd
```

### Example docker-compose.yml:
```
  plcwatchd:
    image: feilner/plcwatchd
    container_name: plcwatchd
    restart: always
    environment:
    - PUSHOVER_KEY=pushoverKey
    - PUSHOVER_TOKEN=pushoverToken
    - PLC_IP=plcIP
    - CLI_ARGS="-u pushoverDeivce"
```

