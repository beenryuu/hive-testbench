#!/bin/bash

DEBUG_SCRIPT=1

function usage {
	echo "Usage: tpcds-run.sh database log_dir"
	exit 1
}

function runcommand {
	if [ "X$DEBUG_SCRIPT" != "X" ]; then
		$1
	else
		$1 2>/dev/null
	fi
}

if [ ! -f tpcds-gen/target/tpcds-gen-1.0-SNAPSHOT.jar ]; then
	echo "Please build the data generator with ./tpcds-build.sh first"
	exit 1
fi

which hive > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "Script must be run where Hive is installed"
	exit 1
fi

# Tables in the TPC-DS schema.
DIMS="date_dim time_dim item customer customer_demographics household_demographics customer_address store promotion warehouse ship_mode reason income_band call_center web_page catalog_page web_site"
FACTS="store_sales store_returns web_sales web_returns catalog_sales catalog_returns inventory"

# Get the parameters.
DB=$1
LOG_DIR=$2
REDUCERS=2500

if [ "X$DEBUG_SCRIPT" != "X" ]; then
	set -x
fi

# Sanity checking.
if [ X"$DB" = "X" ]; then
	usage
fi
if [ X"$LOG_DIR" = "X" ]; then
	DIR=/tmp/tpcds-run
fi

# Do the actual data load.
mkdir -p ${LOG_DIR}
if [ $? -ne 0 ]; then
	echo "Failed to create log directory: $LOG_DIR"
	exit 1
fi

echo "Start running TPC-DS queries:"

HIVE="beeline -u 'jdbc:hive2://localhost:2181/${DB};serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2?tez.queue.name=default' "

for i in `seq 1 99`
do
    runcommand "$HIVE -i settings/load-partitioned.sql -f sample-queries-tpcds/query${i}.sql --hivevar REDUCERS=${REDUCERS} > ${LOG_DIR}/query${i}_result.txt"
done

echo "Query run completed."
