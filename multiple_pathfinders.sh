#!/bin/bash
if [ -z "$2" ]; then 
  echo usage: $0 directory
  exit
fi

if [ $2 -lt 2 ]; then
  echo usage: $0 must have length greater than 2
  exit
fi

for (( i=2; i<=$2; i++ ))
do
  ruby pathfinder.rb -l $i -r -o "rpath$i.csv" $1
  ruby pathfinder.rb -l $i -o "path$i.csv" $1
done
