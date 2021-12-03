// Copyright (C) 2021 Toitware ApS. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be found
// in the LICENSE file.

import .light as light
import gpio
import i2c
import .scd30.driver

co2_level := 0.0

main:
  bus := i2c.Bus
    --sda=gpio.Pin 21
    --scl=gpio.Pin 22

  device := bus.device SCD30.I2C_ADDRESS
  scd30 := SCD30 device

  while true:
    if scd30.is_ready:
      co2_level = scd30.read.co2_
    if co2_level > 2000:
      light.main "red"
    else:
      light.main "green"
    sleep --ms=20

  
