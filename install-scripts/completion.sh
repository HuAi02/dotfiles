#!/bin/bash

echo "🔧 Enabling and starting SDDM service..."

sudo systemctl enable sddm.service
sudo systemctl start sddm.service
sudo systemctl status sddm.service
