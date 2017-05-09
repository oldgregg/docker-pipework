# docker-pipework

A modification of [@dreamcat4](https://github.com/dreamcat4/docker-images)'s docker container for pipework networking. More documentation is available there.

Modifications are meant to be minimal, and better support openvswitch networking.

### Usage
Run the below command once. If you're running something like swarm, run it once per node.
```bash
docker build -t pipework .
docker run -d --restart=always --name=pipework \
    -v /var/run/docker.sock:/docker.sock \
    -v /var/run/openvswitch/db.sock:/var/run/openvswitch/db.sock \
    --privileged --pid=host --net=host -e run_mode=batch,daemon pipework
```

The below is an example of a container with two interfaces. 
 - eth0 is connected to vlan 5 using the bridge ovs0 on the host and is configured with dhcp.
 - eth1 is connected to vlan 10 using the bridge ovs0 on the host and is configured with the IP address 192.168.10.2/24 using gateway 192.168.10.1.
```bash
docker run --net=none \
    -e 'pipework_cmd_000=ovs0 -i eth0 @CONTAINER_NAME@ dhcp @5' \
    -e 'pipework_cmd_001=ovs0 -i eth1 @CONTAINER_NAME@ 192.168.10.2/24@192.168.10.1 @10' \
    -it debian bash
```

## Credit
Based on original work from [jpetazzo](https://github.com/jpetazzo) and [dreamcat4](https://github.com/dreamcat4).


