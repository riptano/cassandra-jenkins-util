#!/bin/sh -xe
for x in $(seq 1 3); do
    ant clean jar
    RETURN=$?
    if [ "${RETURN}" -eq "0" ]; then
        break
    fi
done
exit ${RETURN}
