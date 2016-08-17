Verify the System
=================

**Sources**
* https://docs.docker.com/engine/installation/linux/centos/#/prerequisites

We're using an RHEL 7 server.

**Short**

``` shell
uname -r
```

**Long**

```console
$ uname -r
3.10.0-327.22.2.el7.x86_64
```

Install Docker Engine
=====================

**Sources**
* https://docs.docker.com/engine/installation/linux/centos/#/install-with-yum

**Short**

``` shell
sudo yum update
sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
sudo yum -y install docker-engine
sudo service docker start
sudo groupadd docker
sudo usermod -aG docker $USER
sudo chkconfig docker on
# log out now
```

**Long**

``` console
$ # Update yum packages
$ sudo yum update
Loaded plugins: langpacks, product-id, rhnplugin, search-disabled-repos,
              : subscription-manager
This system is receiving updates from RHN Classic or Red Hat Satellite.
No packages marked for update
```

``` console
$ # Add docker's repository
$ sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
```

``` console
$ # Actually install docker-engine
$ sudo yum -y install docker-engine
Loaded plugins: langpacks, product-id, rhnplugin, search-disabled-repos,
              : subscription-manager
This system is receiving updates from RHN Classic or Red Hat Satellite.
Resolving Dependencies
--> Running transaction check
---> Package docker-engine.x86_64 0:1.11.2-1.el7.centos will be installed
--> Processing Dependency: docker-engine-selinux >= 1.11.2-1.el7.centos for package: docker-engine-1.11.2-1.el7.centos.x86_64
--> Running transaction check
---> Package docker-engine-selinux.noarch 0:1.11.2-1.el7.centos will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================
 Package                  Arch      Version                 Repository     Size
================================================================================
Installing:
 docker-engine            x86_64    1.11.2-1.el7.centos     dockerrepo     13 M
Installing for dependencies:
 docker-engine-selinux    noarch    1.11.2-1.el7.centos     dockerrepo     28 k

Transaction Summary
================================================================================
Install  1 Package (+1 Dependent package)

Total download size: 13 M
Installed size: 54 M
Is this ok [y/d/N]: y
Downloading packages:
warning: /var/cache/yum/x86_64/7Workstation/dockerrepo/packages/docker-engine-selinux-1.11.2-1.el7.centos.noarch.rpm: Header V4 RSA/SHA512 Signature, key ID 2c52609d: NOKEY
Public key for docker-engine-selinux-1.11.2-1.el7.centos.noarch.rpm is not installed
(1/2): docker-engine-selinux-1.11.2-1.el7.centos.noarch.rp |  28 kB   00:00
(2/2): docker-engine-1.11.2-1.el7.centos.x86_64.rpm        |  13 MB   00:04
--------------------------------------------------------------------------------
Total                                              3.1 MB/s |  13 MB  00:04
Retrieving key from https://yum.dockerproject.org/gpg
Importing GPG key 0x2C52609D:
 Userid     : "Docker Release Tool (releasedocker) <docker@docker.com>"
 Fingerprint: 5811 8e89 f3a9 1289 7c07 0adb f762 2157 2c52 609d
 From       : https://yum.dockerproject.org/gpg
Is this ok [y/N]: y
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : docker-engine-selinux-1.11.2-1.el7.centos.noarch             1/2
restorecon:  lstat(/var/lib/docker) failed:  No such file or directory
warning: %post(docker-engine-selinux-1.11.2-1.el7.centos.noarch) scriptlet failed, exit status 255
Non-fatal POSTIN scriptlet failure in rpm package docker-engine-selinux-1.11.2-1.el7.centos.noarch
  Installing : docker-engine-1.11.2-1.el7.centos.x86_64                     2/2
  Verifying  : docker-engine-selinux-1.11.2-1.el7.centos.noarch             1/2
  Verifying  : docker-engine-1.11.2-1.el7.centos.x86_64                     2/2

Installed:
  docker-engine.x86_64 0:1.11.2-1.el7.centos

Dependency Installed:
  docker-engine-selinux.noarch 0:1.11.2-1.el7.centos

Complete!
```

``` console
$ # Start the docker daemon
$ sudo service docker start
Redirecting to /bin/systemctl start  docker.service

```

``` console
$ # Create the docker group so we don't have to sudo all the time to use docker
$ sudo groupadd docker
$ sudo usermod -aG docker $USER
$ # log out now
```

``` console
$ # Start Docker on boot
$ sudo chkconfig docker on
Note: Forwarding request to 'systemctl enable docker.service'.
Created symlink from /etc/systemd/system/multi-user.target.wants/docker.service to /usr/lib/systemd/system/docker.service.
```

```
$ # Test that we can use it. You logged out, right?
$ docker run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker Hub account:
 https://hub.docker.com

For more examples and ideas, visit:
 https://docs.docker.com/engine/userguide/
```

Install Docker Compose
======================

**Sources**
* http://developers.redhat.com/products/softwarecollections/get-started-rhel7-python/
* http://stackoverflow.com/questions/32618686/how-to-install-pip-in-centos-7

**Short**

``` shell
sudo yum -y install python34
curl https://bootstrap.pypa.io/get-pip.py | sudo python3.4
python3 -m pip install -y docker-compose
```

**Long**

```
$ # Find and install Python 3
$ yum search python | grep -I "Python 3000"
python34.x86_64 : Version 3 of the Python programming language aka Python 3000
$ sudo yum -y install python34
Loaded plugins: langpacks, product-id, rhnplugin, search-disabled-repos,
              : subscription-manager
This system is receiving updates from RHN Classic or Red Hat Satellite.
Resolving Dependencies
--> Running transaction check
---> Package python34.x86_64 0:3.4.3-4.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

=================================================================================
 Package            Arch             Version                Repository      Size
=================================================================================
Installing:
 python34           x86_64           3.4.3-4.el7            epel            49 k

Transaction Summary
=================================================================================
Install  1 Package

Total download size: 49 k
Installed size: 36 k
Downloading packages:
python34-3.4.3-4.el7.x86_64.rpm                           |  49 kB  00:00:00
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : python34-3.4.3-4.el7.x86_64                                   1/1
  Verifying  : python34-3.4.3-4.el7.x86_64                                   1/1

Installed:
  python34.x86_64 0:3.4.3-4.el7

Complete!
```

``` console
$ # Install pip3
$ curl https://bootstrap.pypa.io/get-pip.py | sudo python3.4
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 1488k  100 1488k    0     0  3178k      0 --:--:-- --:--:-- --:--:-- 3188k
Collecting pip
  Using cached pip-8.1.2-py2.py3-none-any.whl
Installing collected packages: pip
Successfully installed pip-8.1.2
```

``` console
$ # Install docker-compose
$ python3 -m pip install -y docker-compose
Collecting docker-compose
Requirement already satisfied (use --upgrade to upgrade): requests<2.8,>=2.6.1 in /usr/lib/python3.4/site-packages (from docker-compose)
Requirement already satisfied (use --upgrade to upgrade): jsonschema<3,>=2.5.1 in /usr/lib/python3.4/site-packages (from docker-compose)
Requirement already satisfied (use --upgrade to upgrade): cached-property<2,>=1.2.0 in /usr/lib/python3.4/site-packages (from docker-compose)
Requirement already satisfied (use --upgrade to upgrade): PyYAML<4,>=3.10 in /usr/lib64/python3.4/site-packages (from docker-compose)
Requirement already satisfied (use --upgrade to upgrade): texttable<0.9,>=0.8.1 in /usr/lib/python3.4/site-packages (from docker-compose)
Requirement already satisfied (use --upgrade to upgrade): docker-py<2.0,>=1.9.0 in /usr/lib/python3.4/site-packages (from docker-compose)
Requirement already satisfied (use --upgrade to upgrade): docopt<0.7,>=0.6.1 in /usr/lib/python3.4/site-packages (from docker-compose)
Requirement already satisfied (use --upgrade to upgrade): six<2,>=1.3.0 in /usr/lib/python3.4/site-packages (from docker-compose)
Requirement already satisfied (use --upgrade to upgrade): websocket-client<1.0,>=0.32.0 in /usr/lib/python3.4/site-packages (from docker-compose)
Requirement already satisfied (use --upgrade to upgrade): dockerpty<0.5,>=0.4.1 in /usr/lib/python3.4/site-packages (from docker-compose)
Requirement already satisfied (use --upgrade to upgrade): backports.ssl-match-hostname>=3.5; python_version < "3.5" in /usr/lib/python3.4/site-packages (from docker-py<2.0,>=1.9.0->docker-compose)
Installing collected packages: docker-compose
Successfully installed docker-compose-1.8.0
```

``` console
$ # Test docker-compose
$ tee test.yml <<-'EOF'
version: '2'
services:
  hello-world:
    image: hello-world
EOF
version: '2'
services:
  hello-world:
    image: hello-world
$ docker-compose -f test.yml build up
Creating snscatalogdashboard_hello-world_1
Attaching to snscatalogdashboard_hello-world_1
hello-world_1  |
hello-world_1  | Hello from Docker!
hello-world_1  | This message shows that your installation appears to be working correctly.
hello-world_1  |
hello-world_1  | To generate this message, Docker took the following steps:
hello-world_1  |  1. The Docker client contacted the Docker daemon.
hello-world_1  |  2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
hello-world_1  |  3. The Docker daemon created a new container from that image which runs the
hello-world_1  |     executable that produces the output you are currently reading.
hello-world_1  |  4. The Docker daemon streamed that output to the Docker client, which sent it
hello-world_1  |     to your terminal.
hello-world_1  |
hello-world_1  | To try something more ambitious, you can run an Ubuntu container with:
hello-world_1  |  $ docker run -it ubuntu bash
hello-world_1  |
hello-world_1  | Share images, automate workflows, and more with a free Docker Hub account:
hello-world_1  |  https://hub.docker.com
hello-world_1  |
hello-world_1  | For more examples and ideas, visit:
hello-world_1  |  https://docs.docker.com/engine/userguide/
hello-world_1  |
snscatalogdashboard_hello-world_1 exited with code 0
$ rm test.yml
```

Run the Servers
===============

**Sources**
* [README.md](/README.md)

**Short**

``` shell
git clone https://github.com/player1537/SNS-catalog-dashboard.git
cd SNS-catalog-dashboard
export ENV=local
make noop
vi .env
make down build up logs
# Ctrl-C when you're done
```

**Long**

``` console
$ # Clone the repository
$ git clone https://github.com/player1537/SNS-catalog-dashboard.git
Cloning into 'SNS-catalog-dashboard'...
remote: Counting objects: 704, done.
remote: Compressing objects: 100% (128/128), done.
remote: Total 704 (delta 53), reused 0 (delta 0), pack-reused 572
Receiving objects: 100% (704/704), 143.41 KiB | 0 bytes/s, done.
Resolving deltas: 100% (353/353), done.
$ # Change to that directory
$ cd SNS-catalog-dashboard
```

``` console
$ # Export the environment we want to use
$ export ENV=local
$ # Copy the base env file to the current one
$ make noop
$ # Edit the environment
$ vi .env
```

``` console
$ # Run everything (this will take some time)
$ make down build up logs
Lots of output...
...
...
app_1       | your server socket listen backlog is limited to 100 connections
app_1       | your mercy for graceful operations on workers is 60 seconds
app_1       | mapped 145536 bytes (142 KB) for 1 cores
app_1       | *** Operational MODE: single process ***
app_1       | WSGI app 0 (mountpoint='') ready in 0 seconds on interpreter 0x564975476c40 pid: 1 (default app)
app_1       | *** uWSGI is running in multiple interpreter mode ***
app_1       | spawned uWSGI master process (pid: 1)
app_1       | spawned uWSGI worker 1 (pid: 48, cores: 1)
app_1       | >>> >>> ... ... ... ... Listening at 0.0.0.0:3000
C-c
$ # You can now stop it with
$ make down
```

Troubleshooting: DNS Problems (wip)
===================================

**Sources**
* https://github.com/gliderlabs/docker-alpine/issues/15
* http://stackoverflow.com/questions/24832972/docker-apt-get-update-fails
* http://stackoverflow.com/questions/26166550/set-docker-opts-in-centos
* http://unix.stackexchange.com/questions/28941/what-dns-servers-am-i-using

**Problem**

Trying to build the images fails with an error like:

``` console
WARNING: Ignoring http://dl-cdn.alpinelinux.org/alpine/edge/main/x86_64/APKINDEX.tar.gz: temporary error (try again later)
fetch http://dl-cdn.alpinelinux.org/alpine/edge/community/x86_64/APKINDEX.tar.gz
WARNING: Ignoring http://dl-cdn.alpinelinux.org/alpine/edge/community/x86_64/APKINDEX.tar.gz: temporary error (try again later)
ERROR: unsatisfiable constraints:
  nodejs (missing):
    required by: world[nodejs]
ERROR: Service 'app' failed to build: The command '/bin/sh -c true     && apk add --no-cache            nodejs     && npm install' returned a non-zero code: 1
Makefile:123: recipe for target 'build' failed
make: *** [build] Error 1
```

**Short**

``` shell
# WIP
```

**Long**

``` console
$ # Get your DNS servers
$ cat /etc/resolv.conf
# Generated by NetworkManager
search ornl.gov
nameserver [redacted]
nameserver [redacted]
```

``` console
$ # Change ExecStart line in docker.service and restart
$ grep ExecStart /usr/lib/systemd/system/docker.service
ExecStart=/usr/bin/docker daemon -H fd://
$ sudo sed -i -e 's!\(ExecStart=/usr/bin/docker\) \(daemon..*\)!\1 --dns [redacted] --dns [redacted] \2!' /usr/lib/systemd/system/docker.service
$ grep ExecStart /usr/lib/systemd/system/docker.service
ExecStart=/usr/bin/docker --dns [redacted] --dns [redacted] daemon -H fd://
$ sudo service docker restart
```

``` console
$ # If it still doesn't work, we can try adding more repositories
$ tee repositories <<-'EOF'
http://nl.alpinelinux.org/alpine/edge/main
http://nl.alpinelinux.org/alpine/edge/main
http://dl-2.alpinelinux.org/alpine/edge/main
http://dl-3.alpinelinux.org/alpine/edge/main
http://dl-4.alpinelinux.org/alpine/edge/main
http://dl-5.alpinelinux.org/alpine/edge/main
EOF
http://nl.alpinelinux.org/alpine/edge/main
http://nl.alpinelinux.org/alpine/edge/main
http://dl-2.alpinelinux.org/alpine/edge/main
http://dl-3.alpinelinux.org/alpine/edge/main
http://dl-4.alpinelinux.org/alpine/edge/main
http://dl-5.alpinelinux.org/alpine/edge/main
```

``` console
$ # Copy these to the folders of the services that need it
$ for f in {redis,app}; do cp -v repositories $f/; done
‘repositories’ -> ‘redis/repositories’
‘repositories’ -> ‘app/repositories’
$ head -n 3 {redis,app}/Dockerfile
==> redis/Dockerfile <==
FROM redis:alpine

COPY redis.conf /usr/local/etc/redis/redis.conf

==> app/Dockerfile <==
FROM alpine:edge

COPY package.json /

$ for f in {redis,app}; do sed -i -e $'/^FROM/ aCOPY repositories /etc/apk/repositories\\\n' $f/Dockerfile; done
$ head -n 3 {redis,app}/Dockerfile
==> redis/Dockerfile <==
FROM redis:alpine
COPY repositories /etc/apk/repositories


==> app/Dockerfile <==
FROM alpine:edge
COPY repositories /etc/apk/repositories

$ # Try again now...
$ make build
```

# Ubuntu 16.04:

DNS Problems...

See:
- http://stackoverflow.com/questions/33784295/setting-dns-for-docker-daemon-on-os-with-systemd
- https://docs.docker.com/engine/admin/systemd/#custom-docker-daemon-options

Create `/etc/systemd/system/docker.service` :
```
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network.target docker.socket
Requires=docker.socket

[Service]
Type=notify
ExecStart=/usr/bin/docker daemon -H fd://
LimitNOFILE=1048576
LimitNPROC=1048576
TasksMax=1048576

[Install]
Also=docker.socket
```

create `/etc/systemd/system/docker.service.d/dns.conf`:
```
[Service]
ExecStart=
ExecStart=/usr/bin/docker daemon --dns 160.91.126.23 --dns 160.91.126.28 -H fd://
```

Restart Docker:
```
sudo systemctl status docker.service
# sudo systemctl restart docker
sudo systemctl daemon-reload
sudo systemctl restart docker
```

## NGINX

If already installed... There's a portt conflict.

```
sudo systemctl status nginx
sudo systemctl disable nginx
sudo systemctl stop  nginx
sudo systemctl status nginx
```

