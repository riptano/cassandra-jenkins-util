#!/bin/sh -xe
PARTITION="sda2"
MOUNTPOINT="/mnt"
MOUNT_OPTIONS=" -o noatime,nodiratime"
if [ -n "$BARRIER" ]; then
    MOUNT_OPTIONS="$MOUNT_OPTIONS,barrier=$BARRIER ";
fi
if grep $PARTITION /proc/partitions; then
    sudo mkfs.ext4 /dev/$PARTITION
    [ -d $MOUNTPOINT ] || sudo mkdir $MOUNTPOINT
    sudo mount $MOUNT_OPTIONS /dev/$PARTITION $MOUNTPOINT
    sudo rsync -a /tmp $MOUNTPOINT/
    sudo rm -r /tmp
    sudo ln -s $MOUNTPOINT/tmp /tmp
    echo "Done Setting Up Data Disk."
else
    echo "Data Partition Not Found!"
    exit 1
fi
