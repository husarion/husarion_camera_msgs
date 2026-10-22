# What one PTZ device can do (SPEC-PTZ-CAMERA-2026-10 §4.2). Units are
# REP-103: radians, rad/s, horizontal FOV in radians. pan is positive
# counter-clockwise (left), tilt positive up. No NaN on the wire: an
# unknown value is 0.0 with its *_known / *_calibrated flag false.

# = CameraDevice.id in ~/devices ("net:<id>" or the v4l2 composite id)
string device_id
# canon_xc | onvif | visca_ip | uvc
string driver
# e.g. "Canon CR-X300 1.5.0", "Insta360 Link"
string model
bool connected
# false: no auth on the control path (VISCA) -> UI / diagnostics warn
bool authenticated
# false: pan/tilt limits unknown; absolute pan/tilt and look_at disabled
bool angles_calibrated
# rad, valid when angles_calibrated
float64 pan_min
float64 pan_max
# rad; the UI never offers > +pi/2 unless allow_flip
float64 tilt_min
float64 tilt_max
# tilt beyond +90 deg inverts the image (Canon: -40..+215 deg)
bool allow_flip
# rad/s, valid when speed_known
float64 pan_speed_max
float64 tilt_speed_max
# the bounded-step guarantee holds (a dead node stops the head within one
# step horizon); false -> UI warns
bool velocity_bounded
# false: the pose is modelled from commands, not read back from the camera
bool live_position
# zoom only applies while this device is the streaming source
bool zoom_needs_stream
# pan_speed_max / tilt_speed_max valid
bool speed_known
# false: zoom only as zoom_position 0..1
bool fov_known
# rad, valid when fov_known
float64 hfov_wide
float64 hfov_tele
# sensor w/h of the current mode, for vfov; valid when fov_known
float64 aspect
# 1.0 = none / disabled
float64 digital_zoom_max
bool has_zoom
bool has_focus_auto
bool has_focus_one_shot
bool has_focus_manual
# 0 = no presets
uint16 preset_slots
# TF frames (§4.6)
string frame_base
string frame_optical
