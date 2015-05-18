#!/bin/sh -xe
PARTITION="xvdb"
MOUNTPOINT="/mnt"
MOUNT_OPTIONS=" -o noatime,nodiratime"
if [ -n "$BARRIER" ]; then
    MOUNT_OPTIONS="$MOUNT_OPTIONS,barrier=$BARRIER ";
fi
if [ -z "$BARRIER" ]
if grep $PARTITION /proc/partitions; then
    sudo mkfs.ext4 -F /dev/$PARTITION
    [ -d $MOUNTPOINT ] || sudo mkdir $MOUNTPOINT
    sudo mount $MOUNT_OPTIONS /dev/$PARTITION $MOUNTPOINT
    sudo mkdir -m 1777 $MOUNTPOINT/tmp
    sudo sh -c "echo \"export TMPDIR=$MOUNTPOINT/tmp\" >> /etc/profile"
    echo "Done Setting Up Data Disk."
else
    echo "Data Partition Not Found!"
    exit 1
fi
