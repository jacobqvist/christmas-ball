// Copyright (C) 2021 Toitware ApS. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be found
// in the LICENSE file.

import .light as light
import gpio
import i2c
import .scd30

co2_level := 0.0

main:
  bus := i2c.Bus
    --sda=gpio.Pin 21
    --scl=gpio.Pin 22

  device := bus.device Scd30.I2C_ADDRESS
  scd30 := Scd30 device

  while true:
    co2_level = scd30.read.co2
    if co2_level > 2000:
      light.main "red"
    else:
      light.main "green"
    sleep --ms=500
