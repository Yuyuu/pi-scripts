#!/bin/sh
ROOT_DIR=/home/pi/dev/xdcc
LISTS_DIR=$ROOT_DIR/lists

if [ ! -e $LISTS_DIR ] || [ ! -d $LISTS_DIR ] ; then
	echo "Creating dir : $LISTS_DIR"
	mkdir -p $LISTS_DIR
else
	cp $ROOT_DIR/xdcc-pi.log $ROOT_DIR/`date "+%d_%m_%y"`.log
fi

if [ -e $ROOT_DIR/xdcc-pi.jar ] ; then
	echo "Executing jar file"
	java -jar $ROOT_DIR/xdcc-pi.jar 8089 &
fi
