# Latched audio-stream description (TRANSIENT_LOCAL + RELIABLE +
# keep-last-1) so a late subscriber can configure its decoder without
# any per-packet handshake.
#
# Mirrors `audio_common_msgs/AudioInfo` in spirit (we'd use that
# directly but it isn't in apt for jazzy at the time of writing).
string  coding_format    # "opus"
uint32  channels         # 1 = mono, 2 = stereo
uint32  sample_rate      # samples per channel per second (e.g. 48000)
string  sample_format    # PCM sample-format hint (e.g. "S16LE")
uint32  bitrate          # encoder bitrate, in bits per second
