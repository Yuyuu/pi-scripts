#!/bin/sh
ROOT_DIR=/home/pi/prod/xdcc
LISTS_DIR=$ROOT_DIR/lists
LOGS_DIR=$ROOT_DIR/logs

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

if [ -e $ROOT_DIR/xdcc-pi.jar ] ; then
	echo "Executing jar file"
	java -jar $ROOT_DIR/xdcc-pi.jar 8089 &
fi
