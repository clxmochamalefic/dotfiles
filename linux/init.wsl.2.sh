#!/bin/bash

PARENT_DIR=$(cd "$(dirname "$0")"; cd ..;pwd)
sudo cp "${PARENT_DIR}/linux/wsl/resolv.conf" /etc/resolv.conf

echo 'this script has been finished'
echo 'PLZ => execute `sudo reboot` or `wsl --shutdown`, before exec next script ...'

# sudo reboot
