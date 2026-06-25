# A single detected V4L2 camera, with stable identifiers and (when
# discoverable) its USB-sibling audio device + per-camera calibration
# file. Published as an element of CameraDeviceList.devices on the
# camera node's ~/devices topic.

# Composite stable key. Equals the by-id symlink path when the camera
# has a unique iSerial; falls back to the by-path symlink path when the
# iSerial collides with another attached camera (e.g. two GUV3100s).
# This is what the operator stores as "preferred camera" and what
# ~/set_device's request uses to identify the target.
string id

# /dev/videoN of the capture (index0) node. The metadata (index1) node
# is hidden from this list.
string node

# /dev/v4l/by-id/usb-... symlink. Empty when the camera's iSerial
# collides with another attached camera's iSerial (the kernel only
# creates one symlink per iSerial).
string by_id

# /dev/v4l/by-path/platform-... symlink. Always present.
string by_path

# Human-readable model name from VIDIOC_QUERYCAP (e.g. "GRANDSTREAM
# GUV3100", "Logitech Webcam C930e").
string card

# V4L2 bus_info string from VIDIOC_QUERYCAP. Used to disambiguate
# duplicate-model cameras in the WebUI dropdown
# (e.g. "usb-fd500000.usb-1.2.1.1").
string bus_info

# V4L2 driver name from VIDIOC_QUERYCAP (e.g. "uvcvideo").
string driver

# ALSA capture spec for the audio device sharing this camera's USB
# parent (e.g. "plughw:CARD=GUV3100,DEV=0"). Empty when no audio
# sibling was found under /sys/bus/usb/devices/. The audio thread
# routes here automatically when this camera becomes active.
string inferred_audio_device

# Resolved camera_info_url for this device. Convention:
#   <calibration_dir>/<basename(id)>.yaml
# (defaulting to /etc/husarion-camera/calibrations/<basename(id)>.yaml,
# overridable via the calibration_dir ROS param). Empty when no
# calibration file exists AND the legacy global CAMERA_INFO_URL doesn't
# apply. Returned as a file://... URL ready for camera_info.rs.
string camera_info_url

# All advertised (format, resolution, fps) tuples this source can
# drive. Same schema as ~/capabilities' formats[]. For a V4L2 camera
# these come from the device's eager enumeration. For a ros_topic
# source they are the OUTPUT options the node can PRODUCE (h264 / mjpeg
# / raw) at the input resolution plus the downscale ladder.
CameraFormat[] formats

# --- ROS-topic source fields (SPEC-ros-topic-source.md) ---
# Empty / "v4l2" for a local UVC camera; "ros_topic" when this entry is
# an external sensor_msgs/Image topic the node can ingest + hardware
# re-encode. The device fields above (node/by_id/by_path/bus_info/
# driver/inferred_audio_device) are empty for a ros_topic source.
string source_kind

# For source_kind == "ros_topic": the external topic this entry ingests
# (e.g. "/oak/rgb/image_raw"). Empty for a V4L2 camera. For a topic
# source `id` equals this topic name.
string source_topic

# Live-probed properties of the incoming stream (ros_topic only; 0 /
# empty for V4L2). The operator picks an OUTPUT format + optional
# downscale; the input geometry itself is fixed by the upstream node.
string input_encoding
uint32 input_width
uint32 input_height
uint32 input_fps

# Operator-assigned friendly name. Set/cleared via the SetCameraAlias
# service and persisted to <calibration_dir>/aliases.yaml (keyed by
# `id`). Empty when none assigned. Lets the WebUI tell otherwise-
# identical cameras apart (e.g. two GUV3100s keyed by by-path) and
# survives reboots + browser resets. Display preference: alias || card.
string alias
