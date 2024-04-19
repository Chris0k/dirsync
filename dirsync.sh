#!/usr/bin/env bash

source=$1
destination=$2
verbose=${3:-false}

[ "$verbose" = true ] && inotify_params="-r" || inotify_params="-rqq"
[ "$verbose" = true ] && rsync_params="-avz" || rsync_params="-az"

while inotifywait "$inotify_params" -e modify,create,delete,move "$source"; do
    rsync "$rsync_params" --del "$source" "$destination"
done
