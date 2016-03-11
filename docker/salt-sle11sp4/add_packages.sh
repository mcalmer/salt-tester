#!/bin/bash
set -e

# make sure the package repository is up to date
zypper --non-interactive --gpg-auto-import-keys ref

# Packages required to run salt-minion
zypper -n in  --no-recommends iproute2 \
                              python \
                              cron \
                              sysconfig \
                              python-pyOpenSSL \
                              postfix \
                              psmisc \
                              udev \
                              make \
                              python-mock \
                              python-pip \
                              python-salt-testing \
                              python-unittest2 \
                              net-tools \
                              bind-utils

# required for unit tests install with recommends
zypper -n in quilt
#zypper -n in quilt rpm-build

zypper -n in vim less
