FROM jberrenberg/quake3

## Lets copy in our own config
COPY server.cfg /opt/quake3/baseq3/server.cfg

## Lets set the config variable so the bootstrap script will tell q3ded to use our config
ENV CONFIG server.cfg
