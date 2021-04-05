git clone --branch v1.0.11 git://git.proxmox.com/git/proxmox-backup.git
git clone git://git.proxmox.com/git/proxmox

cd proxmox
git checkout 1fce0ff41ddeb177f92874bf4e95a775cfd99c69
patch -p1 <../proxmox.patch

cd ../proxmox-backup
patch --forward --strip=1 --input=../pbs.patch
patch --forward --strip=1 --input=../fix-map_err.patch

cargo build --release --bin proxmox-backup-client --bin pxar --bin dump-catalog-shell-cli
