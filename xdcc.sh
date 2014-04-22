#!/bin/sh
ROOT_DIR=/home/pi/prod/xdcc
LISTS_DIR=$ROOT_DIR/lists
LOGS_DIR=$ROOT_DIR/logs

if [ -z $1 ] ; then
	echo "No version specified"
	exit
fi

if [ ! -e $LISTS_DIR ] || [ ! -d $LISTS_DIR ] ; then
	echo "Creating dir : $LISTS_DIR"
	mkdir -p $LISTS_DIR
fi

if [ ! -e $LOGS_DIR ] || [ ! -d $LOGS_DIR ] ; then
        echo "Creating dir : $LOG_DIR"
        mkdir -p $LOGS_DIR
fi

if [ -f $ROOT_DIR/xdcc-pi.log ] ; then
	echo "Archiving $ROOT_DIR/xdcc-pi.log to $LOGS_DIR"
	mv $ROOT_DIR/xdcc-pi.log $LOGS_DIR/`date "+%d_%m_%y_%H_%M_%S"`.log
fi

if [ -e $ROOT_DIR/xdcc-pi-$1.jar ] ; then
	echo "Starting API version $1"
	java -jar $ROOT_DIR/xdcc-pi-$1.jar 8089 &
else
	echo "API version $1 could no be found"
fi
