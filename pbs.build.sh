git clone git://git.proxmox.com/git/proxmox
git clone git://git.proxmox.com/git/proxmox-backup.git

cd proxmox
git checkout 4dec479d2c46bd8cec28c1faa17aa013307de764
patch -p1 <../proxmox.patch

cd ../proxmox-backup
git checkout 2d87f2fb73b9629abdfac18aefac213b9130a609
patch -p1 <../pbs.patch
cargo vendor

cargo build --release --bin pxar
cargo build --release --bin proxmox-backup-client
