#!/bin/bash

# Clone the Fluent KDE repository
git clone https://github.com/vinceliuice/Fluent-kde.git

# Navigate into the cloned directory
cd Fluent-kde

# Make the install.sh script executable (in case it isn't)
chmod +x install.sh

# Run the install.sh script
./install.sh
