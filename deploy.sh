#!/bin/bash


d=`date +%d_%m_%y`

git add .

git commit -m "update_"$d""

git push
