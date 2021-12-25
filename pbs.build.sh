git clone git://git.proxmox.com/git/proxmox-backup.git
cd proxmox-backup
git checkout bd00ff10e46f865d000f3162124009c7d8d13b6b
cd ..
git clone git://git.proxmox.com/git/proxmox.git
cd proxmox
git checkout c0312f3717bd00ace434929e7d3305b058f4aae9
cd ..
git clone git://git.proxmox.com/git/proxmox-fuse.git
git clone git://git.proxmox.com/git/pxar.git

patch --forward --strip=1 --input=pbs.patch

cd proxmox-backup
cargo fetch --target x86_64-unknown-linux-gnu
cargo build --release --package proxmox-backup-client --bin proxmox-backup-client --bin dump-catalog-shell-cli --package pxar-bin --bin pxar

