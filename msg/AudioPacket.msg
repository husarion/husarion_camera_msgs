# One audio packet from the camera node.
#
# Carries a single Opus packet. Exact frame size is determined by the
# encoder configuration on the publisher side and surfaced via
# AudioInfo (the latched companion topic).
#
# Published at the encoder's frame rate, e.g. ~50 Hz at 20 ms frames.
uint8[] data
