#!/usr/bin/bash

set -eoux pipefail

# Use this for build steps that are unique to this particular image

# Adwaita Mono is not available in AlmaLinux 10.1, since it was added to EPEL
# after 10.1 was released.
# Remove when Alma goes to 10.2

for j in /etc/dconf/db/distro.d/08-tr-ui-fixes \
         /usr/share/glib-2.0/schemas/zz1-10-tr-ui.gschema.override; do
    sed -i 's/Adwaita Mono 13/Red Hat Mono 13/g' "$j"
done

dnf install -y just