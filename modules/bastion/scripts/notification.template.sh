#!/bin/bash

# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

if [ ${notification_enabled} ]; then
  sudo al-config -T ${topic_id}
else
  echo 'ONS notification not enabled'
fi