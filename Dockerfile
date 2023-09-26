FROM archlinux:latest

WORKDIR /app

RUN pacman -Sy --noconfirm --needed glibc reflector
RUN reflector --country "United States, France, Germany,India, Norway, Australia, Sweden" \
      --verbose \
      --sort rate \
      --protocol https,http \
      --latest 20 \
      --save /etc/pacman.d/mirrorlist

RUN pacman -S --noconfirm --needed neovim
COPY . /app
RUN ./install2.sh
