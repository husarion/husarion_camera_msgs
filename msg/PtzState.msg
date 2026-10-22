# ~/ptz/state, one message per device (SPEC-PTZ-CAMERA-2026-10 §4.2).
# At the driver's native rate while moving (<= 25 Hz), 1 Hz idle;
# best-effort. Units REP-103; unknown values are 0.0 with their flag false.

# stamp = robot time the pose was read (or modelled); frame_id = frame_base
std_msgs/Header header
string device_id
bool connected
# rad; normalised -1..1 when angles_calibrated is false
float64 pan
float64 tilt
# rad, valid when fov_known
float64 hfov
float64 vfov
# tan(hfov_wide/2)/tan(hfov/2), or 1.0 when unknown
float64 zoom_factor
# 0 = wide .. 1 = tele, always valid when has_zoom
float64 zoom_position
# false until the pose is read (or, for a modelled pose, first commanded)
bool pose_known
# true when the pose comes from the node's motion model, not the camera
bool pose_estimated
bool moving
bool has_target
float64 target_pan
float64 target_tilt
float64 target_hfov
float64 target_zoom_position
# auto | manual
string focus_mode
bool focus_position_known
# 0..1 near..far
float64 focus_position
# client of the last command; "external" = the camera's own UI / RC
string controller
# "" when healthy
string last_error
