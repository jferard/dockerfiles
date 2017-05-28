#!/bin/bash

# call the standard bootstrap to start hadoop fs
/etc/bootstrap.sh -ignore

# copy files from /usr/local/data to hadoop fs
/usr/local/hadoop/bin/hdfs dfsadmin -safemode wait
$HADOOP_CMD fs -mkdir /data
$HADOOP_CMD fs -copyFromLocal /usr/local/data/* /data

/bin/bash
