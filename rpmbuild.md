
<link href="https://unpkg.com/@primer/css/dist/primer.css" rel="stylesheet" />
# Build rpm package for proxmox-backup-client
A litel guide for build a rpm package for proxmox-backup-client

## Install cargo-generate-rpm
After you have build and check the proxmox-backup-client with version option, install cargo-generate-rpm tools
```
cargo install cargo-generate-rpm
```
## Add  metadata for build package
Edit Cargo.toml and add at the end metadata info
```
# tail Cargo.toml 
default = []
#valgrind = ["valgrind_request"]

[package.metadata.generate-rpm]
assets = [
  { source = "target/release/pxar", dest = "/usr/local/sbin/pxar", mode = "0755" },
  { source = "target/release/proxmox-backup-client", dest = "/usr/local/sbin/proxmox-backup-client", mode = "0755" }
]
```
## Generate rpm
```
cargo generate-rpm
ll target/generate-rpm/
rpm -qlp target/generate-rpm/proxmox-backup-1.0.6-1.x86_64.rpm
rpm -qip target/generate-rpm/proxmox-backup-1.0.6-1.x86_64.rpm
```
I have not found how to define the list of dependencies with rpm-generate. it is possible to use rpmrebuild to add dependencies.
## rpmrebuild
```
# Install GetPageSpeed repository:
dnf install https://extras.getpagespeed.com/release-el8-latest.rpm
# Install rpmrebuild rpm package:
dnf install rpmrebuild
```
## modification
Edit the spec file with the rpmrebuild command
```
rpmrebuild -enp target/generate-rpm/proxmox-backup-1.0.6-1.x86_64.rpm
```
add 2 lines 
```
Requires:      libfuse3.so.3()(64bit)
Requires:      libzstd.so.1()(64bit)
``` 
after ```Requires:      /bin/sh``` and before ```#suggest```
```
Provides:      proxmox-backup = 1.0.6
Provides:      proxmox-backup(x86_64) = 1.0.6
Requires:      /bin/sh
<div class="text-green mb-2">
Requires:      libfuse3.so.3()(64bit)
Requires:      libzstd.so.1()(64bit)
</div>
#suggest
```
change Release from 1 to 1.2
```
Version:       1.0.6
Release:       1.2
License:       AGPL-3
```
save the temporary file and answer y to build the new package
```
"~/.tmp/rpmrebuild.62512/work/spec.2" 60L, 1144C written
Do you want to continue ? (y/N) y
result: /root/rpmbuild/RPMS/x86_64/proxmox-backup-1.0.6-1.2.x86_64.rpm
```
## Install the package on a new host
```
[centos@pbscl82 ~]$ sudo yum install ./proxmox-backup-1.0.6-1.2.x86_64.rpm
Last metadata expiration check: 0:02:46 ago on mar. 05 janv. 2021 08:18:34 UTC.
Dependencies resolved.
=====================================================================================================
 Package                   Architecture      Version                   Repository               Size
=====================================================================================================
Installing:
 proxmox-backup            x86_64            1.0.6-1.2                 @commandline            6.0 M
Installing dependencies:
 fuse3-libs                x86_64            3.2.1-12.el8              BaseOS                   94 k
 libzstd                   x86_64            1.4.4-1.el8               BaseOS                  266 k

Transaction Summary
=====================================================================================================
Install  3 Packages

Total size: 6.3 M
Total download size: 360 k
Installed size: 21 M
Is this ok [y/N]: y
Downloading Packages:
(1/2): fuse3-libs-3.2.1-12.el8.x86_64.rpm                             17 kB/s |  94 kB     00:05
(2/2): libzstd-1.4.4-1.el8.x86_64.rpm                                 47 kB/s | 266 kB     00:05
-----------------------------------------------------------------------------------------------------
Total                                                                 62 kB/s | 360 kB     00:05
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                             1/1
  Installing       : libzstd-1.4.4-1.el8.x86_64                                                  1/3
  Installing       : fuse3-libs-3.2.1-12.el8.x86_64                                              2/3
  Running scriptlet: fuse3-libs-3.2.1-12.el8.x86_64                                              2/3
  Installing       : proxmox-backup-1.0.6-1.2.x86_64                                             3/3
  Running scriptlet: proxmox-backup-1.0.6-1.2.x86_64                                             3/3
  Verifying        : fuse3-libs-3.2.1-12.el8.x86_64                                              1/3
  Verifying        : libzstd-1.4.4-1.el8.x86_64                                                  2/3
  Verifying        : proxmox-backup-1.0.6-1.2.x86_64                                             3/3

Installed:
  proxmox-backup-1.0.6-1.2.x86_64    fuse3-libs-3.2.1-12.el8.x86_64    libzstd-1.4.4-1.el8.x86_64

Complete!
[centos@pbscl82 ~]$
[centos@pbscl82 ~]$ proxmox-backup-client version
client version: 1.0.6
```
