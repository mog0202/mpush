#!/bin/bash
set -e

echo "starting up mpush..."
${MPUSH_HOME}/bin/mp.sh start 
sleep 5

shutdown_mpush() {
    echo "Shutting down mpush..."
    ${MPUSH_HOME}/bin/mp.sh stop
}

trap shutdown_mpush SIGINT SIGTERM EXIT
tail -f ${MPUSH_HOME}/logs/mpush.out

