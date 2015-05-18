#!/bin/sh -xe
PARTITION="xvdb"
MOUNTPOINT="/mnt"
if grep $PARTITION /proc/partitions; then
    sudo mkfs.ext4 -F /dev/$PARTITION
    [ -d $MOUNTPOINT ] || sudo mkdir $MOUNTPOINT
    sudo mount /dev/$PARTITION -o noatime,nodiratime,barrier=0 $MOUNTPOINT
    sudo mkdir -m 1777 $MOUNTPOINT/tmp
    sudo sh -c "echo \"export TMPDIR=$MOUNTPOINT/tmp\" >> /etc/profile"
    . /etc/profile
    echo "Done Setting Up Data Disk."
    sudo mount /dev/xvda1 -o remount,noatime,nodiratime,barrier=0 /
    echo "Remounted / with noatime,nodiratime,barrier=0"
else
    echo "Data Partition Not Found!"
    exit 1
fi
