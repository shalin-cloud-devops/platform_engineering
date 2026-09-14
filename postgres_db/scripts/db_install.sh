#!/bin/bash

set -e

LOG_FILE="/var/log/postgresql-user-data.log"

exec > >(tee -a "$LOG_FILE") 2>&1

echo "Starting PostgreSQL installation..."

# Update package repository
apt-get update -y

# Upgrade installed packages
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Install PostgreSQL
DEBIAN_FRONTEND=noninteractive apt-get install -y \
    postgresql \
    postgresql-contrib

# Enable PostgreSQL at boot
systemctl enable postgresql

# Start PostgreSQL
systemctl start postgresql

# Verify PostgreSQL
if systemctl is-active --quiet postgresql; then
    echo "PostgreSQL is running successfully."
else
    echo "ERROR: PostgreSQL failed to start."
    systemctl status postgresql --no-pager
    exit 1
fi

# Show installed version
sudo -u postgres psql -c "SELECT version();"

echo "PostgreSQL installation completed."