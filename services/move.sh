#!/bin/bash

# Copies service files to the appropriate location

# Ensure proper permissions
sudo chmod 644 *.service

# Service-specific amendments
sed -ri "s/^(User=).*$/\1$USER/; s/^(Group=).*$/\1$USER/" rando_updatecount.service

# Copy everything to the systemd dir
sudo cp *.service /lib/systemd/system/
