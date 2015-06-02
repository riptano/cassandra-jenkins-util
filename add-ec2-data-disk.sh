#!/bin/sh -xe
PARTITION="xvdb"
MOUNTPOINT="/mnt"
if grep $PARTITION /proc/partitions; then
    sudo umount $MOUNTPOINT || /bin/true
    sudo mkfs.ext4 -F /dev/$PARTITION
    [ -d $MOUNTPOINT ] || sudo mkdir $MOUNTPOINT
    sudo mount -o noatime,nodiratime,barrier=0 /dev/$PARTITION $MOUNTPOINT
    sudo mkdir -m 1777 $MOUNTPOINT/tmp
    sudo sh -c "echo \"export TMPDIR=$MOUNTPOINT/tmp\" >> /etc/profile"
    export TMPDIR=$MOUNTPOINT/tmp
    echo "Done Setting Up Data Disk."
    sudo mount -o remount,noatime,nodiratime,barrier=0 /dev/xvda1 /
    echo "Remounted / with noatime,nodiratime,barrier=0"
else
    echo "Data Partition Not Found!"
    exit 1
fi
