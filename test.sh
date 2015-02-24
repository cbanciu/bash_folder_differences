#!/bin/bash

file1=du_1.txt
file2=du_2.txt
l1=1
l2=1
f1_lines=$[$(wc -l $file1| awk '{print $1}')+1]
f2_lines=$[$(wc -l $file2 | awk '{print $1}')+1]

while [ "$f1_lines" -gt $l1 ] || [ "$f2_lines" -gt $l2 ]
do
 if [ "$f2_lines" -gt $l2 ]
 then
  folder2=$(sed -n $l2"p" $file2 | awk '{print $2}')
 else folder2='zzzzzzz'
 fi

if [ "$f1_lines" -gt $l1 ]
 then
 folder1=$(sed -n $l1"p" $file1 | awk '{print $2}')
fi

 if [ $folder1 = $folder2 ]
  then
   echo "$[$(sed -n $l2"p" $file2 | awk '{print $1}')-$(sed -n $l1"p" $file1 | awk '{print $1}')] $folder2"
   l1=$[$l1+1]
   l2=$[$l2+1]
  else
   if [ "$l1" -eq "$f1_lines" ] || [[ "$folder2" < "$folder1" ]]
   then
    sed -n $l2"p" $file2
    l2=$[$l2+1]
   else
    sed -n $l1"p" $file1
    l1=$[$l1+1]
   fi
 fi
done
