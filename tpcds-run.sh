#!/bin/bash

# DEBUG_SCRIPT=1

function usage {
	echo "Usage: tpcds-run.sh database config"
	exit 1
}

which hive > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "Script must be run where Hive is installed"
	exit 1
fi

DB=$1
CONFIG_FILE=$2

if [ "X$DEBUG_SCRIPT" != "X" ]; then
	set -x
fi

# Sanity checking.
if [ X"$DB" = "X" ]; then
	usage
fi
if [ X"$CONFIG_FILE" = "X" ]; then
	CONFIG_FILE=load-partitioned.sql
fi

echo "Start running TPC-DS queries:"

HIVE="beeline -u 'jdbc:hive2://localhost:2181/${DB};serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2?tez.queue.name=default' "

for i in `seq 1 99`
do
	echo "Start trying query${i}"
        CMD="$HIVE -i settings/${CONFIG_FILE} -f sample-queries-tpcds/query${i}.sql"
	echo "Runing query$i as : "$CMD
        time $CMD
	echo "Query$i completed as $?"
done

echo "All queries completed."
