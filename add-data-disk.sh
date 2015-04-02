#!/bin/sh -xe
PARTITION="sda2"
MOUNTPOINT="/mnt"
if grep $PARTITION /proc/partitions; then
    sudo mkfs.ext4 /dev/$PARTITION
    sudo mount /dev/$PARTITION $MOUNTPOINT
    sudo rsync -a /tmp $MOUNTPOINT/
    sudo rsync -a /home/$USER $MOUNTPOINT/
    sudo rm -r /tmp
    sudo ln -s $MOUNTPOINT/tmp /tmp
    sudo rm -r /home/$USER
    sudo ln -s $MOUNTPOINT/$USER /home/$USER
    echo "Done Setting Up Data Disk."
    ls -l /tmp
    ls -l /home/$USER
    df -h
else
    echo "Data Partition Not Found!"
    exit 1
fi
