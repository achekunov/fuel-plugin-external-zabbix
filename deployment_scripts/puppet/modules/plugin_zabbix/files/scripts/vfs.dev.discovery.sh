#!/bin/bash
#
#    Copyright 2015 Mirantis, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
#Zabbix vfs.dev.discovery implementation
#Send beer to <admin@fluda.net>
DEVS=`grep -v "major\|^$\|dm-\|[0-9]$" /proc/partitions | awk '{print $4}'`
POSITION=1
echo "{"
echo " \"data\":["
for DEV in $DEVS
do
    if [ $POSITION -gt 1 ]
    then
        echo ","
    fi
    echo -n " { \"{#DEVNAME}\": \"$DEV\"}"
    POSITION=$[POSITION+1]
done
echo ""
echo " ]"
echo "}"