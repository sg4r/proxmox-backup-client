git clone git://git.proxmox.com/git/proxmox-backup.git
cd proxmox-backup
git checkout 519ca9d01057991aaed4ab2bfd28c6e403eba869
cd ..
git clone git://git.proxmox.com/git/proxmox.git
cd proxmox
git checkout 7667e549a539edff6f33cbf35d0f880383ebec61
cd ..
git clone git://git.proxmox.com/git/proxmox-fuse.git
git clone git://git.proxmox.com/git/pxar.git

patch --forward --strip=1 --input=pbs.patch

cd proxmox-backup
cargo fetch --target x86_64-unknown-linux-gnu
cargo build --release --package proxmox-backup-client --bin proxmox-backup-client --bin dump-catalog-shell-cli --package pxar-bin --bin pxar

