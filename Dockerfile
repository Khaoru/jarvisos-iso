FROM archlinux:latest

# Install build dependencies
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    base-devel \
    git \
    wget \
    archiso \
    squashfs-tools \
    libisoburn \
    dosfstools \
    e2fsprogs \
    grub \
    mkinitcpio \
    arch-install-scripts \
    sudo

# Create build user (archiso requires non-root)
RUN useradd -m -G wheel builder && \
    echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER builder
WORKDIR /home/builder

# Clone JarvisOS
RUN git clone https://github.com/JARVISOS/JARVIS.git jarvisos

COPY --chown=builder:builder build-iso.sh /home/builder/
RUN chmod +x /home/builder/build-iso.sh

CMD ["/home/builder/build-iso.sh"]
