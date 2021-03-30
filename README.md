# proxmox-backup-client
CentOS 7 or 8 cookbook for build Client for Proxmox Backup Server. the client is written in the Rust programming language.

## install rust
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```
## install depends
```
yum install systemd-devel clang-devel libzstd-devel libacl-devel pam-devel fuse3-devel libuuid-devel openssl-devel
yum groupinstall 'Development Tools'
yum install git
ln -s /lib64/libsgutils2.so.2.0.0 /lib64/libsgutils2.so
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
build a rpm package with the executable files
```
cd proxmox-backup/
cargo generate-rpm
ll target/generate-rpm/
total 10876
-rw-r--r--. 1 root root 11134754 17 févr. 21:21 proxmox-backup-1.0.6-1.x86_64.rpm
cd ..
```
to build a package with dependency support, read this [rpmbuild.md](rpmbuild.md)
## install binaries
if you prefer to locally install the binaries, carry out these commands
```
install -Dm755 "proxmox-backup/target/release/proxmox-backup-client" "/usr/local/sbin/proxmox-backup-client"
install -Dm755 "proxmox-backup/target/release/pxar" "/usr/local/sbin/pxar"
```
## make clean
```
cd ..
rm -fr ./proxmox-backup-client
```
