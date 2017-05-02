#!/bin/bash
adduser --disabled-password --gecos '' opendata
adduser opendata sudo
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
mkdir -p /home/opendata/app