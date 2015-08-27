
![Quake 3](https://raw.githubusercontent.com/InAnimaTe/docker-quake3/master/quake_logo.jpg)


### Quake 3 Dedicated Server Image

A fancy containerized [quake3](https://en.wikipedia.org/wiki/Quake_III_Arena) dedicated server container. Get playing in no time!

The config I have here is fairly generic but somewhat specific to the overall stock way I play this game with my friends. 

Ideally, you would setup the config how you want, build, launch, and play. I source from the excellent [jberrenberg/quake3](https://hub.docker.com/r/jberrenberg/quake3) image.

#### Launching

There is an included `docker-compose.yml` that shows the best way to launch this container and how to take care of the core dependencies: the retail `pak0.pk3` and the port forward for `27960/udp`. 

> Note that the server.cfg must be added to the `/opt/quake3/baseq3` directory and then passed to `q3ded` simply as `server.cfg`. You **cannot** just pass a full path to the file.

If you decide to build and incorporate your own `server.cfg`, as is recommended, make sure you modify the `image` source or just use `build: .` in your `docker-compose.yml` :)

#### Maps

Ideally, we like to cycle through maps, starting from the first. It would be even better if we could set random for all *minus* a few we don't like (q3dm19 is not favorable to my tastes).

A great map breakdown can be seen [here](http://www.bosskey.net/q3a/maps/standard.html).

#### Bots

Please see [this](http://www.3dgw.com/guides/q3a/index.php3?page=configs.htm#serverbots) page for info on how to setup bots. 

Basically, you need `seta bot_enable 1` at the top of your config. After you define and start a map, you can then:

```
botadd Major 3
botadd Sorlag 2
```

> Bot names must be one of the supported character names! They **cannot** be custom!

#### Troubleshooting

```
docker logs quake3
```

Yep, the server logs to stdout/stderr!

#### Linkage

Here are some really helpful links for setting up the `server.cfg` and utilizing rcon. 

http://it.rcmd.org/networks/q3_install/q3_linux_server_howto.php#step9

http://www.tldp.org/HOWTO/archived/Game-Server-HOWTO/quake3.html

http://gaming.stackexchange.com/questions/46735/quake-3-private-server-with-bots

http://notes.splitbrain.org/q3aserver

http://www.katsbits.com/articles/quake-3/add-remove-bots.php
