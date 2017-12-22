#!/bin/bash

##############################
# Authors: Sir Geladin & Squire Mullen
# Purpose: to search a dir structure and replace text
# Created: Aug 2017
# History:
# Notes: 
# - To use a var as a parameter pass "{$variable_name}"
##############################

# gather parameters from stdin
FIND=$1
REPLACE=$2
DIR=$3
NUM=0

if [ -z "$DIR" ]; then
  echo "Usage: recursive_find_replace.sh <search_string> <replace_string> <directory_path>"
  exit
fi

if [ "$1" = "$2" ]; then
  echo "ID10T ERROR: Why would you ever want to search and replace the same thing....."
  exit
fi

# verify DIR is an existing DIR
if [ ! -d "$DIR" ]; then
  echo "ERROR: $DIR is not a directory"
  exit
fi

FILES=`find $DIR -type f | xargs grep -l $FIND 2> /dev/null`

for f in $FILES; do
  NUM=$((NUM+1))
  sed -i "s/$FIND/$REPLACE/g" $f
done

if [ $NUM == "0" ]; then
  echo "WARNING: Did not find any files to modify with search string."
  exit
fi

echo ""
echo "Number of files edited: $NUM"
echo "Complete."
