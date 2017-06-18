#!/bin/bash
if [ ! -d ../local_scripts/fileshare/testcases ]; then
  mkdir ../local_scripts/fileshare/testcases
fi

rsync -avp * ../local_scripts/fileshare/testcases
