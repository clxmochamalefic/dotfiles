#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
DENO_PATH=$(which deno)

# write systemctl service file
cat $SCRIPT_DIR/denops.service | sed -e `s/{deno_path}/$DENO_PATH` -e `s/{HOME}/$HOME` > $HOME/.config/systemd/user/denops.service

systemctl --user daemon-reload
systemctl --user start denops.service
systemctl --user status denops.service
systemctl --user enable denops.service
