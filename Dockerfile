FROM archlinux:latest

RUN pacman -Syu base-devel --noconfirm --needed --noprogressbar

# Create non-root user for makepkg
RUN useradd builduser -m \
    && passwd -d builduser \
    && echo 'builduser ALL=(ALL) ALL' >> /etc/sudoers \
    && su - builduser

COPY . /home/builduser

USER builduser
# Install aurutils
RUN curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/aurutils.tar.gz \
    && tar -xf aurutils.tar.gz \
    && pushd aurutils \
    && makepkg -sci \
    && popd

# Setup build environment
RUN cat pacman.conf | sudo tee -a /etc/pacman.conf \
    && mkdir localrepo \
    && repo-add localrepo/est.db.tar.zst \
    && sudo pacman -Syu

CMD ["/bin/bash"]