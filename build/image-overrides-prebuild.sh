#!/usr/bin/bash

# Use this file for setps that need to happen before the 
# reusable scripts run.

# This fixes an issue with the Chrome icon not displaying properly
# in the dock.  It was fixed with the 1.2.0-4.el10 release
# of xdg-utils.  As of today, it's fixed in Bluefin LTS an
# CentOS Stream, but not AlmaLinux (and probably not RHEL)
# Remove when xdg-utils-1.2.0-4.el10 lands in Alma (prob at 10.2)

# The AlmaLinux atomic desktop doesn't include xdg-utils,
# but Chrome itself pulls it in.  Therefore we have to install
# it manually if it's not there and patch it before we try
# to install Chrome.

if [ ! -f /usr/bin/xdg-icon-resource ]; then
    dnf install -y patch xdg-utils
fi

patch /usr/bin/xdg-icon-resource << "END_PATCH"
981c981
<   path="$(xdg_realpath "$1")" 2> /dev/null` # Normalize path
---
>   path="$(xdg_realpath "$1")" 2> /dev/null # Normalize path
END_PATCH
