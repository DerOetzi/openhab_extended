# openHAB Extended

![openHAB Logo](https://github.com/openhab/openhab-docker/raw/master/images/openhab.png)

These images extend the original [openHab images](https://hub.docker.com/r/openhab/openhab) by 
signal-cli for usage with the 
[openHAB Exec Binding](https://www.openhab.org/addons/bindings/exec/).
to send notifications to Signal Messenger users

## Usage

### Running docker image

For starting up the docker image read the original documentation 
of openHAB [here](https://hub.docker.com/r/openhab/openhab).

Replace the image name openhab/openhab by deroetzi/openhab_extended 
and use one of the following versions:

#### Version tags
- **latest**, 2.5.11
- 2.5.X (X <= 11)
- 3.0.0.RC1

All versions are although available for host-systems **-amd64**, 
**-armhf** and **-arm64**

#### Mount additional volume

For persistence of your signal userdata add volume **/signal-cli/data**.
Signal-cli will store its secrets to this directory if you use 
`--config /signal-cli/` parameter.
(example: `-v /save-directory/signal:/signal-cli/data`)

#### Additional enviroment parameter

**SIGNAL_NUMBER** will be used to as sender phone number. 
It starts with your country code and can be any number you
can receive incoming SMS or voice call 
(example: `-e SIGNAL_NUMBER="+49..."`).

### Signal-cli

For a list of all possible commands of the signal-cli you can 
read documentation [here](https://github.com/AsamK/signal-cli).

As a shortcut command for `signal-cli --config /signal-cli/ -u <SIGNAL_NUMBER> ...` 
you can just use the `signal ...` and it will automatically set
config-directory and your phone number set as SIGNAL_NUMBER enviroment
at docker run. This script is located at `/usr/local/bin/signal`

#### Register your number

For registration of your phone number via SMS or voice call 
connect to a bash inside your container and register and verify 
your number.

```bash
docker exec -it openhab /bin/bash
signal register
signal verify <VERIFY_CODE_6DIGITS>
```

#### Test to send a message

You can send a message to every registered signal user by using 
their phone number.

```bash
docker exec -it openhab /bin/bash
signal send -m "Test message" +49...
```
