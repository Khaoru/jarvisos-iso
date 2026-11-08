#!/bin/bash
set -e

echo "=== JarvisOS ISO Builder ==="
echo "Starting build process..."

# Create build directory
mkdir -p /home/builder/build
cd /home/builder/build

# Copy archiso profile
echo "[1/7] Setting up archiso profile..."
cp -r /usr/share/archiso/configs/releng archlive
cd archlive

# Customize for JarvisOS
echo "[2/7] Customizing profile..."
cat >> packages.x86_64 << 'EOF'
# JarvisOS dependencies
plasma-desktop
plasma-workspace
sddm
konsole
dolphin
kate
firefox
git
base-devel
EOF

# Create JarvisOS installation script
echo "[3/7] Creating installation hooks..."
mkdir -p airootfs/root
cat > airootfs/root/install-jarvis.sh << 'EOFSCRIPT'
#!/bin/bash
cd /root
git clone https://github.com/JARVISOS/JARVIS.git
cd JARVIS
chmod +x install.sh
./install.sh
EOFSCRIPT
chmod +x airootfs/root/install-jarvis.sh

# Add to profiledef
echo "[4/7] Configuring profile..."
sed -i 's/iso_name="archlinux"/iso_name="jarvisos"/' profiledef.sh
sed -i 's/iso_label="ARCH_.*"/iso_label="JARVISOS"/' profiledef.sh

# Build ISO
echo "[5/7] Building ISO (this takes 30-60 minutes)..."
sudo mkarchiso -v -w /tmp/archiso-tmp .

# Move ISO to output
echo "[6/7] Finalizing..."
mkdir -p /home/builder/output
sudo mv /tmp/archiso-tmp/out/*.iso /home/builder/output/jarvisos.iso
sudo chown builder:builder /home/builder/output/jarvisos.iso

# Verify
echo "[7/7] Verifying ISO..."
ls -lh /home/builder/output/jarvisos.iso
sha256sum /home/builder/output/jarvisos.iso

echo "=== Build Complete! ==="
echo "ISO located at: /home/builder/output/jarvisos.iso"
