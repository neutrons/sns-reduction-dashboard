# Setting up a Virtual Machine for Testing

Here's some notes on setting up a virtual machine for testing the code and
making sure it works correctly. Some specs:

* Host: Mac OS X 10.10.5 on a MacBook Pro (15-Inc, Mid 2010)
* VirtualBox: Version 5.1.6 r110634 (Qt5.5.1)
* Guest: CentOS 7

# Getting networking to work correctly

Adapter 1 should be set to NAT.

We need to make sure the adapter is enabled on boot by going to `/etc/sysconfig/network-scripts/ifcfg-*`, where `*` is whichever interface is shown for `ip addr`:

```console
$ ip addr
1: lo
...
2: enp0s3
...
$ sudo vi /etc/sysconfig/network-scripts/ifcfg-enp0s3
$ sudo shutdown -r now
```

We just need to change it so that instead of `ONBOOT=no` it says `ONBOOT=yes`.
