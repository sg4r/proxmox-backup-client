git clone --branch v1.0.11 git://git.proxmox.com/git/proxmox-backup.git

cd proxmox
patch -p1 <../proxmox.patch

cargo build --release --bin proxmox-backup-client --bin pxar --bin dump-catalog-shell-cli
