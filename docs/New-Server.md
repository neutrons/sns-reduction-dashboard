Verify the System
=================

Sources:
* https://docs.docker.com/engine/installation/linux/centos/#/prerequisites

We're using an RHEL 7 server.

```console
$ uname -r
3.10.0-327.22.2.el7.x86_64
```

Install Docker Engine
=====================

Sources:
* https://docs.docker.com/engine/installation/linux/centos/#/prerequisites

To install this, we need to first update yum's packages, add the docker repo,
install docker-engine, and start the daemon:

``` console
$ sudo yum update
Loaded plugins: langpacks, product-id, rhnplugin, search-disabled-repos,
              : subscription-manager
This system is receiving updates from RHN Classic or Red Hat Satellite.
No packages marked for update
$ sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
$ sudo yum install docker-engine
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
$ sudo service docker start
Redirecting to /bin/systemctl start  docker.service
```
