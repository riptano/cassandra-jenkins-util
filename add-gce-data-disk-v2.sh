#!/bin/sh -xe
PARTITION="sda2"
MOUNTPOINT="/mnt"
MOUNT_OPTIONS=" -o noatime,nodiratime"
if [ -n "$BARRIER" ]; then
    MOUNT_OPTIONS="$MOUNT_OPTIONS,barrier=$BARRIER ";
fi
if grep $PARTITION /proc/partitions; then
    sudo umount $MOUNTPOINT || /bin/true
    sudo mkfs.ext4 /dev/$PARTITION
    [ -d $MOUNTPOINT ] || sudo mkdir $MOUNTPOINT
    sudo mount $MOUNT_OPTIONS /dev/$PARTITION $MOUNTPOINT
    sudo mkdir $MOUNTPOINT/tmp
    sudo chmod 777 $MOUNTPOINT/tmp
    echo "Done Setting Up Data Disk."
else
    echo "Data Partition Not Found!"
    exit 1
fi
