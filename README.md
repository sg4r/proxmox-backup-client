# proxmox-backup-client
CentOS 7 or 8 cookbook for build Client for Proxmox Backup Server. the client is written in the Rust programming language.

## install rust
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```
## install depends
```
yum install systemd-devel clang-devel libzstd-devel libacl-devel pam-devel fuse3-devel libuuid-devel
yum groupinstall 'Development Tools'
yum install git
```
## clone proxmox-backup-client cookbook
```
git clone https://github.com/sg4r/proxmox-backup-client.git
cd proxmox-backup-client
```
## build
```
bash ./pbs.build.sh
```
## check
```
./proxmox-backup/target/release/proxmox-backup-client version
client version: 1.0.6
```
## generate-rpm
you can build a rpm package. for this read [rpmbuild.md](rpmbuild.md)
## install binaries
```
install -Dm755 "proxmox-backup/target/release/proxmox-backup-client" "/usr/local/sbin/proxmox-backup-client"
install -Dm755 "proxmox-backup/target/release/pxar" "/usr/local/sbin/pxar"
```
## make clean
```
cd ..
rm -fr ./proxmox-backup-client
```
