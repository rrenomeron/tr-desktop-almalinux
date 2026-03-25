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
# Apparently this needs to be done for non-RHEL EL in order to download images from Red Hat.
# See https://access.redhat.com/articles/3116561

# podman image trust set -f /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release registry.access.redhat.com
# podman image trust set -f /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release registry.redhat.io
cat << EOF > /etc/containers/registries.d/registry.access.redhat.com.yaml
docker:
     registry.access.redhat.com:
         sigstore: https://access.redhat.com/webassets/docker/content/sigstore
EOF
cat << EOF > /etc/containers/registries.d/registry.redhat.io.yaml
docker:
     registry.redhat.io:
         sigstore: https://registry.redhat.io/containers/sigstore
EOF
