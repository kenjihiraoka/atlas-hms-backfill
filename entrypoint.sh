#!/bin/bash

if [ -z "$1" ]
  then
    echo "Import all entities from HMS to Apache Atlas"
    source /opt/atlas/hook/hive/import-hive.sh
elif [[ "$1" = "-d" || "$1" = "--database" ]]
  then
    echo "Import data from database regex: " $2
    source /opt/atlas/hook/hive/import-hive.sh $1 $2
elif [[ "$1" = "-t" || "$1" = "--table" ]]
  then
    echo "Import data from table: " $2
    source /opt/atlas/hook/hive/import-hive.sh $1 $2
elif [[ "$1" = "-f" ]]
  then
    echo "Import entities from filename: " $2
    source /opt/atlas/hook/hive/import-hive.sh $1 $2
else
  echo "Parameter invalid"
fi
