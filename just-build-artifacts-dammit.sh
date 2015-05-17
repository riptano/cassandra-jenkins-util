#!/bin/sh -x
for x in $(seq 1 3); do
    ant clean artifacts
    RETURN=$?
    if [ "${RETURN}" -eq "0" ]; then
        break
    fi
done
exit ${RETURN}
