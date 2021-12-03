import bitmap show bytemap_zap
import pixel_strip show UartPixelStrip

PIXELS ::= 8  // Number of pixels on the strip.
pixels := UartPixelStrip PIXELS --pin=27  // Output pin - this is the normal pin for UART 2.
r := ByteArray PIXELS
g := ByteArray PIXELS
b := ByteArray PIXELS

main color:
  if color == "green":
    64.repeat:
      r.fill 0x00
      g.fill 192 + it
      b.fill 32 + it/2
      pixels.output r g b
      sleep --ms=2
    64.repeat:
      r.fill 0x00
      g.fill 256 - it
      b.fill 64 - it/2
      pixels.output r g b
      sleep --ms=2

  if color == "red":
    64.repeat:
      r.fill 192 + it
      g.fill 0x00
      b.fill 0
      pixels.output r g b
      sleep --ms=2
    64.repeat:
      r.fill 256 - it
      g.fill 0x00
      b.fill 0
      pixels.output r g b
      sleep --ms=2
