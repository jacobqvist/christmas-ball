import serial
import binary 
import .cth

class SCD30:
  static I2C_ADDRESS ::= 0x61

  // Available commands.
  static COMMAND_GET_DATA_READY ::= #[0x02, 0x02]
  static COMMAND_READ_MEASUREMENT ::= #[0x03, 0x00]

  device_/serial.Device ::= ? 

  constructor device/serial.Device:
    device_ = device

  // Returns true when data is ready.
  is_ready -> bool:
    device_.write COMMAND_GET_DATA_READY
    data := device_.read 3
    check_crc_ data
    value := binary.BIG_ENDIAN.int16 data 0
    return value == 1

  // Reads the measurements from the sensor and returns it as a CO2, temperature,
  // humidity object. 
  read -> CTH:
    device_.write COMMAND_READ_MEASUREMENT
    data := device_.read 18
    check_crc_ data[0..3]
    check_crc_ data[3..6]
    co2_data := data[0..2] + data[3..5]
    check_crc_ data[6..9]
    check_crc_ data[9..12]
    temperature_data := data[6..8] + data[9..11]
    check_crc_ data[12..15]
    check_crc_ data[15..18]
    humidity_data := data[12..14] + data[15..17]
    co2_ := binary.BIG_ENDIAN.float32 co2_data 0
    temperature_ := binary.BIG_ENDIAN.float32 temperature_data 0
    humidity_ := binary.BIG_ENDIAN.float32 humidity_data 0
    return CTH co2_ temperature_ humidity_
  
  // Checks checksum and throws error if wrong.
  check_crc_ data/ByteArray -> none:
    crc := compute_crc8_ data[..data.size - 1]
    if crc != data.last: throw "Bad CRC"

  // Computes checksum.
  compute_crc8_ data/ByteArray -> int:
    crc := 0xFF
    for x := 0; x < data.size; x++:
      crc ^= data[x]
      for i := 0; i < 8; i++:
        if (crc & 0x80) != 0:
          crc = (crc << 1) ^ 0x31
        else:
          crc <<= 1
        crc &= 0xFF

    return crc
