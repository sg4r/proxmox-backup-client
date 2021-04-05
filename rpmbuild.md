
# Build rpm package for proxmox-backup-client
A short guide to creating an rpm package for proxmox-backup-client with the addition of dependencies

## Generate rpm
from the proxmox-backup directory use the ```cargo generate-rpm``` command to create an rpm package
```
cargo generate-rpm
ll target/generate-rpm/
rpm -qlp target/generate-rpm/proxmox-backup-1.0.11-1.x86_64.rpm
rpm -qip target/generate-rpm/proxmox-backup-1.0.11-1.x86_64.rpm
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
rpmrebuild -enp target/generate-rpm/proxmox-backup-1.0.11-1.x86_64.rpm
```
add 3 lines 
```
Requires:      libfuse3.so.3()(64bit)
Requires:      libzstd.so.1()(64bit)
Requires:      libssl.so.1.1()(64bit)
``` 
after ```Requires:      /bin/sh``` and before ```#suggest```
```
Provides:      proxmox-backup = 1.0.11
Provides:      proxmox-backup(x86_64) = 1.0.11
Requires:      /bin/sh
Requires:      libfuse3.so.3()(64bit)
Requires:      libzstd.so.1()(64bit)
Requires:      libssl.so.1.1()(64bit)
#suggest
```
change Release from 1 to 1.2
```
Version:       1.0.11
Release:       1.2
License:       AGPL-3
```
save the temporary file and answer y to build the new package
```
"~/.tmp/rpmrebuild.199172/work/spec.2" 61L, 1187C written
Do you want to continue ? (y/N) y
result: /root/rpmbuild/RPMS/x86_64/proxmox-backup-1.0.11-1.2.x86_64.rpm
```
## Install the package on a new host
```
[centos@pbscl82 ~]$ sudo dnf install ./proxmox-backup-1.0.11-1.2.x86_64.rpm
Failed to set locale, defaulting to C.UTF-8
Last metadata expiration check: 0:00:13 ago on Mon Apr  5 18:57:37 2021.
Dependencies resolved.
==========================================================================================================
 Package                    Architecture       Version                     Repository                Size
==========================================================================================================
Installing:
 proxmox-backup             x86_64             1.0.11-1.2                  @commandline             5.5 M
Installing dependencies:
 fuse3-libs                 x86_64             3.2.1-12.el8                baseos                    94 k

Transaction Summary
==========================================================================================================
Install  2 Packages

Total size: 5.6 M
Total download size: 94 k
Installed size: 22 M
Is this ok [y/N]: y
Downloading Packages:
fuse3-libs-3.2.1-12.el8.x86_64.rpm                                        1.1 MB/s |  94 kB     00:00    
----------------------------------------------------------------------------------------------------------
Total                                                                     1.0 MB/s |  94 kB     00:00     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                  1/1 
  Installing       : fuse3-libs-3.2.1-12.el8.x86_64                                                   1/2 
  Running scriptlet: fuse3-libs-3.2.1-12.el8.x86_64                                                   1/2 
  Installing       : proxmox-backup-1.0.11-1.2.x86_64                                                 2/2 
  Running scriptlet: proxmox-backup-1.0.11-1.2.x86_64                                                 2/2 
  Verifying        : fuse3-libs-3.2.1-12.el8.x86_64                                                   1/2 
  Verifying        : proxmox-backup-1.0.11-1.2.x86_64                                                 2/2 

Installed:
  fuse3-libs-3.2.1-12.el8.x86_64                     proxmox-backup-1.0.11-1.2.x86_64                    

Complete!
[centos@pbscl82 ~]$
[centos@pbscl82 ~]$ proxmox-backup-client version
client version: 1.0.11
```
