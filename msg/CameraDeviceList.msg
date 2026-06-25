# Snapshot of every UVC camera the husarion_camera node has detected,
# plus the composite id of the camera currently driving the stream.
# Published latched on the ~/devices topic — re-published on every
# enumeration change (boot + hot-plug) AND on every successful
# ~/set_device.

# Composite id of the currently-active camera. Empty when no camera
# is currently open (boot before first successful open, or persisted
# device is missing).
string active_device_id

CameraDevice[] devices
