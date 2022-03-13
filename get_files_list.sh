#!/bin/sh

# Выгрузить в один файл список каталогов, в другой - список файлов на компьютере 
# исключая некоторые каталогн, изменения в которых не отслеживать, например, /proc,
# чтобы потом сравнить изменения после установки какой-либо программы.

DATE=$(date '+%Y%m%d_%H%M%S'); export DATE
PREFIX=$DATE; export PREFIX

if [ "$1" != "" ]
then
  PREFIX=`echo ${PREFIX}_$1`; export PREFIX
fi
echo PREFIX: $PREFIX

# dirs
find / \
  -path /proc -prune -o \
  -path /sys -prune -o \
  -path /var/log -prune -o \
  -path /run -prune -o \
  -path /var/run -prune -o \
  -path /var/lib/docker -prune -o \
  -path /containers_prj -prune -o \
  -path /usr/share -prune -o \
  -path /home -prune -o \
  -path /usr/src -prune -o \
  -path /mnt -prune -o \
  -path /media -prune -o \
  -type d \
  -print > ${PREFIX}_dirs.txt

# files
find / \
  -path /proc -prune -o \
  -path /sys -prune -o \
  -path /var/log -prune -o \
  -path /run -prune -o \
  -path /var/run -prune -o \
  -path /var/lib/docker -prune -o \
  -path /containers_prj -prune -o \
  -path /usr/share -prune -o \
  -path /home -prune -o \
  -path /usr/src -prune -o \
  -path /mnt -prune -o \
  -path /media -prune -o \
  -type f \
  -exec ls -l --time-style=long-iso {} \; > ${PREFIX}_files.txt
