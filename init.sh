#!/bin/bash

PARENT_DIR=$(cd $(dirname $0); cd ..;pwd)

if [$# -lt 1]; then
    echo "Usage init.sh -$repositoriesDirectory"
    exit 1
fi

# get password sudo
if [ "$(expr substr $(uname -s) 1 10)" != 'MINGW32_NT' ]; then
  echo "sudo password? : "
  read pw
fi

SCRIPT_DIR=$(cd $(dirname $0);pwd)

if [ "$(uname)" == 'Darwin' ]; then
  `$SCRIPT_DIR/osx/init.sh $1 $pw`
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  `$SCRIPT_DIR/linux/init.sh $1 $pw`
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
  `$SCRIPT_DIR/windows/init.sh $1`
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

exit 0
