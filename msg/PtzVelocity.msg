# ~/ptz/velocity (best-effort, volatile, depth 1). A hold stops
# ptz_velocity_timeout_ms after the last accepted message; a message is
# accepted only if header.stamp is at most ptz_velocity_max_age_ms old
# (a zero stamp is accepted on arrival).

# stamp from the robot clock; stale -> dropped
std_msgs/Header header
# "" = the active source if it has PTZ, else the only PTZ device
string device_id
# empty -> message ignored (the bridge's default-initialised dead-man zero)
string client
# -1..1; pan/tilt scaled by the current FOV (ptz_fov_speed)
uint8 UNITS_NORMALIZED=0
uint8 UNITS_RAD_PER_S=1
uint8 units
float64 pan
float64 tilt
# -1 wide .. 1 tele, always normalized
float64 zoom
