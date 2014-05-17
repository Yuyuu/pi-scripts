#!/bin/sh
ROOT_DIR=/home/pi/prod/xdcc
LISTS_DIR=$ROOT_DIR/lists
LOGS_DIR=$ROOT_DIR/logs
VERSION_DIR=$ROOT_DIR/xdcc-api-xdcc-api-$1

if [ -z $1 ] ; then
	echo "No version specified"
	exit
fi

if [ ! -e $LISTS_DIR ] || [ ! -d $LISTS_DIR ] ; then
	echo "Creating dir : $LISTS_DIR"
	mkdir -p $LISTS_DIR
fi

if [ ! -e $VERSION_DIR ] || [ ! -d $VERSION_DIR ] ; then
	echo "Downloading api version $1"
	wget --directory-prefix=$ROOT_DIR https://github.com/Yuyuu/xdcc-api/archive/xdcc-api-$1.zip
	unzip -d $ROOT_DIR xdcc-api-$1.zip
	rm -f $ROOT_DIR/xdcc-api-$1.zip
fi

if [ ! -e $LOGS_DIR ] || [ ! -d $LOGS_DIR ] ; then
        echo "Creating dir : $LOG_DIR"
        mkdir -p $LOGS_DIR
fi

if [ -f $VERSION_DIR/xdcc-pi.log ] ; then
	echo "Archiving $VERSION_DIR/xdcc-pi.log to $LOGS_DIR"
	mv $VERSION_DIR/xdcc-pi.log $LOGS_DIR/`date "+%d_%m_%y_%H_%M_%S"`.log
fi

if [ -f $VERSION_DIR/access.log ] ; then
	echo "Archiving $VERSION_DIR/access.log to $LOGS_DIR"
	mv $VERSION_DIR/access.log $LOGS_DIR/access_`date "+%d_%m_%y_%H_%M_%S"`.log
fi

if [ -e $VERSION_DIR/gradlew ] && [ -x $VERSION_DIR/gradlew ] ; then
	echo "Starting API version $1"
	(cd $VERSION_DIR; ./gradlew clean stage; foreman start &)
else
	echo "gradlew file is missing or is not executable"
fi


# TODO Force delete and redownload version