## Kamailio's `worker_sockets` does not impact interface name listners

The `worker_socket` command works if the Interface is using an IP address,
but not if the interface name is used.

For example, the following will create four workers for `udp:0.0.0.0:5060`
```
#!define INTERFACE 0.0.0.0

children       = 2
socket_workers = 4
listen         = udp:INTERFACE:5060
```


However if the `eth0` is used in place of `0.0.0.0`, only two socket workers
will be crated:
```
#!define INTERFACE eth0

children       = 2
socket_workers = 4
listen         = udp:INTERFACE:5060
```

I've created a contianer to easily identify this. After starting the rpc command
`core.psx` is called and it's output printed. 

By default `eth0` will be used:
```
docker run --rm -it --name kamsocket whosgonna/kamsockets
```


To use a specific address (and `0.0.0.0` is the easiest), pass it as an
environmental variable:
```
docker run --rm -it --name kamsocket -e INTERFACE=0.0.0.0 whosgonna/kamsockets
```

