string device
string card
string bus_info
CameraFormat[] formats
# Resolved name of the in-process H.264 encoder used for `~/image_raw/ffmpeg`
# in raw mode (e.g. `h264_vaapi`, `h264_v4l2m2m`, `h264_nvenc`, `libx264`).
# Empty when the encoder hasn't been resolved yet. The UI uses this to tell
# the user whether raw → H.264 re-encoding is hardware-accelerated.
string encoder
# Resolved name of the in-process MJPEG encoder used for raw mode's
# `~/image_raw/compressed` topic (`mjpeg_vaapi`, `mjpeg_qsv`,
# `mjpeg_v4l2m2m`, or libav software `mjpeg`). Empty when not resolved.
string mjpeg_encoder
# V4L2 mmap buffer count currently configured (`mmap_buffers` ROS param).
# Floor 2; bumping past that trades pipeline latency for jitter tolerance.
uint32 mmap_buffers
