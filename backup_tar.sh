#!/bin/bash
###################################
# Backup to mount directory

# What to backup.
backup_files="/home /var/spool/mail /etc /root /boot /opt"

# Where to backup to.
dest="/mnt/backup"

# Create archive filename.
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Print start status.
echo "Backing up $backup_files to $dest/$archive_file"
date

# Backup the files using tar.
tar czf $dest/$archive_file $backup_files

# Print end status message.
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest

###################
# Restore backup to directory
# Example
# tar -xzvf /mnt/backup/host-Monday.tgz -C /tmp etc/hosts
