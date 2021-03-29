git clone --branch v1.0.11 git://git.proxmox.com/git/proxmox-backup.git

cd proxmox-backup
patch --forward --strip=1 --input=../pbs.patch
patch --forward --strip=1 --input=../fix-map_err.patch

cargo build --release --bin proxmox-backup-client --bin pxar --bin dump-catalog-shell-cli
