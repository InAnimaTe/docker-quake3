#!/usr/bin/env sh

if [ -f "/opt/quake3/baseq3/pak0.pk3" ]
then
  if [ -z "$CONFIG" ]; then
    su q3a -c "quake3ded +set fs_game ${FS_GAME} $@"
  else
    su q3a -c "quake3ded +set fs_game ${FS_GAME} +exec ${CONFIG} $@" 
  fi
else 
  echo "You need to provide a valid pak0.pk3 e.g. using:"
  echo '-v ${PAK0}:/opt/quake3/baseq3/pak0.pk3'
  exit 1
fi
