# proxmox-backup-client
CentOS 7 or 8 cookbook for build Client for Proxmox Backup Server. the client is written in the Rust programming language.

## rpm package
rpm package are available in assets of release [v2.1.2](https://github.com/sg4r/proxmox-backup-client/releases/tag/v2.1.2)

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
client version: 2.1.2
```
## generate-rpm
build a rpm package with the executable files
```
cd proxmox-backup/
cargo generate-rpm
[root@pbs proxmox-backup]# ll target/generate-rpm/
total 6104
-rw-r--r--. 1 root root 6248411 Dec 25 17:01 proxmox-backup-2.1.2-1.x86_64.rpm
cd ..
```
to build a package with dependency support, read this [rpmbuild.md](rpmbuild.md)
## install binaries
if you prefer to locally install the binaries, carry out these commands
```
install -Dm755 "proxmox-backup/target/release/proxmox-backup-client" "/usr/local/sbin/proxmox-backup-client"
install -Dm755 "proxmox-backup/target/release/dump-catalog-shell-cli" "/usr/local/sbin/dump-catalog-shell-cli"
install -Dm755 "proxmox-backup/target/release/pxar" "/usr/local/sbin/pxar"
```
## make clean
```
cd ..
rm -fr ./proxmox-backup-client
```
