#!/bin/sh

# MIT License
#
# Copyright (c) 2023 Kazuhito Suda
#
# This file is part of Let's FIWARE M5Stack
#
# https://github.com/lets-fiware/lets-fiware.m5stack
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -eu

if [ ! -e .env ]; then
  echo ".env file not fuond"
  exit 1
fi

. ./.env

if [ -z "${IOTAGENT_UL}" ]; then
  echo "IoT Agent for UltraLight 2.0 not found"
  exit 1
fi

ngsi devices --host "${IOTAGENT_UL}" create --data '{
 "devices": [
   {
     "device_id":   "actuator001",
     "entity_name": "urn:ngsi-ld:Atuator:actuator001",
     "entity_type": "Thing",
     "timezone":    "Asia/Tokyo",
     "protocol":    "PDI-IoTA-UltraLight",
     "transport":   "MQTT",
     "commands": [
        {"name": "led", "type": "command"}
     ],
     "static_attributes": [
       { "name":"location", "type": "geo:json", "value" : { "type": "Point", "coordinates" : [ 139.7671, 35.68117 ] } }
     ]
   }
 ]
}'

ngsi devices --host "${IOTAGENT_UL}" list -P
