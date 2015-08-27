FROM base/archlinux

# enable multilib and update base system
RUN \
  pacman -Sy --noconfirm reflector && \
  reflector --verbose -l 5 --sort rate --save /etc/pacman.d/mirrorlist && \
  echo "[multilib]" >> /etc/pacman.conf && \
  echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf && \
  pacman -Syu --noconfirm && \
  pacman-db-upgrade 

# install dependencies
RUN pacman -S --noconfirm  \
  binutils \
  fakeroot \
  unzip \
  lib32-libgl \
  lib32-libxext 

# install quake 3
RUN useradd -m q3a && \
  curl -O https://aur.archlinux.org/packages/qu/quake3/quake3.tar.gz && \
  tar xfz quake3.tar.gz -C /home/q3a/ && \
  chown -R q3a /home/q3a/ && \
  su q3a -c 'cd /home/q3a/quake3 && makepkg -f' && \
  pacman --noconfirm -U /home/q3a/quake3/quake3-1.32c-2-x86_64.pkg.tar.xz && \
  rm quake3.tar.gz 
  
# bootstraping 
COPY bootstrap.sh /usr/bin/
RUN chmod +x /usr/bin/bootstrap.sh 

# environment variables
ENV FS_GAME='baseq3'

EXPOSE 27960/udp
ENTRYPOINT  ["bootstrap.sh"]

## Lets copy in our own config
COPY server.cfg /opt/quake3/baseq3/server.cfg

## Lets set the config variable so the bootstrap script will tell q3ded to use our config
ENV CONFIG server.cfg
