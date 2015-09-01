
![Quake 3](https://raw.githubusercontent.com/InAnimaTe/docker-quake3/master/quake_logo.jpg)


### Quake 3 Dedicated Server Image

A fancy containerized [quake3](https://en.wikipedia.org/wiki/Quake_III_Arena) dedicated server container. Get playing in no time!

The config I have here is fairly generic but somewhat specific to the overall stock way I play this game with my friends. Either way, it's a great example to get going with if you'd like. If not, read below for more on configuration.

Ideally, you would setup the config how you want, build, launch, and play. I sourced the `Dockerfile` and `bootstrap.sh` originally from the excellent [jberrenberg/quake3](https://hub.docker.com/r/jberrenberg/quake3) image. That image now doesn't build and so I've tagged and moved on creating my own debian based ioquake3 engine image.

I wanted to thank the Debian Games Team for [this](https://packages.debian.org/stable/games/quake3-server) excellent package :)

#### Launching

##### The `server.cfg` way

There is an included `docker-compose.yml.example` that shows the best way to launch this container and how to take care of the core dependencies: the retail `pak0.pk3`, the port forward for `27960/udp`, and optionally, your own `server.cfg`.

> Note that the server.cfg must exist in the `/usr/share/games/quake3/baseq3` directory!

If you decide to build and incorporate your own `server.cfg`, as is recommended, make sure you modify the `image` source or just use `build: .` in your `docker-compose.yml` :)

You could also just `-v ./server.cfg:/use/share/games/quake3/baseq3/server.cfg` on the command line.

##### The command way

You can also pass in configuration options via passing them as docker commands either on the command line or in your `docker-compose.yml`. 

```
docker run -d -v ./pak0.pk3:/usr/share/games/quake3/baseq3/pak0.pk3 inanimate/quake3 +fraglimit 150
```

A comprehensive list of possibilities can be found [here](http://www.joz3d.net/html/q3console.html).

#### Maps

I've set a default launch map of q3dm17, which is *The Longest Yard*, one of the more popular deathmatch maps. **This means you can just run the container straight off with no options and be playing instantly.**

Ideally, we like to cycle through maps, starting from the first. It would be even better if we could set random for all *minus* a few we don't like (q3dm19 is not favorable to my tastes). See my included example `server.cfg` for how I cycle through maps.

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
