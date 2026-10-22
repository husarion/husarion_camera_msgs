# husarion_camera_msgs

ROS 2 message and service definitions for the [Husarion camera node](https://github.com/husarion/husarion-cockpit) — video formats and devices, Opus audio, and runtime camera control.

A standard `ament_cmake` + `rosidl` interface package. It is consumed by:

- **the camera node** (`husarion/camera`) — publishes `CameraMode`, `CameraCapabilities`, `CameraDeviceList`, `AudioInfo` / `AudioPacket`, and serves the camera-control services below;
- **`husarion_rosbridge`** (and the legacy foxglove-bridge image) — binds these types so they can be advertised + called over the WebSocket;
- the `husarion-camera` / `husarion-webui` snaps.

## Interfaces

PTZ units are REP-103 (radians, rad/s, horizontal FOV in radians; pan positive left, tilt positive up). No NaN goes on the wire: optional request values carry presence bits (`axes`, `has_position`) and unknown message values are `0.0` with a `*_known` flag. The PTZ types depend on `std_msgs` and `builtin_interfaces`.

**Messages** (`msg/`) — latched on the camera node's topics:

| Message                      | Topic / purpose                                                              |
| ---------------------------- | --------------------------------------------------------------------------- |
| `CameraMode`                 | Currently-active capture mode (format / w / h / fps) — `~/active_mode`       |
| `CameraCapabilities`         | Discovered V4L2 fmt-tree (`CameraFormat` / `CameraResolution`) — `~/capabilities` |
| `CameraDeviceList`           | Enumerated cameras (`CameraDevice[]`) + active id — `~/devices`             |
| `AudioInfo` / `AudioPacket`  | Opus stream parameters (`~/audio_info`) + packets (`~/audio`)               |
| `PtzCapabilitiesList`        | Every PTZ device the node drives (`PtzCapabilities[]`) — `~/ptz/capabilities` (latched) |
| `PtzState`                   | Pose, target, zoom and controller of one PTZ device — `~/ptz/state`          |
| `PtzVelocity`                | Stamped hold-to-move velocity (dead-man) — `~/ptz/velocity`                  |
| `PtzPresetLists`             | Saved views of every device (`PtzPresetList` / `PtzPreset`) — `~/ptz/presets` (latched) |

**Services** (`srv/`):

| Service            | Topic / purpose                                                          |
| ------------------ | ----------------------------------------------------------------------- |
| `SetCameraFormat`  | Switch capture mode at runtime (atomic V4L2 + encoder restart) — `~/set_format` |
| `SetCameraDevice`  | Swap the active camera / ingest a ROS-topic source — `~/set_device`     |
| `SetCameraAlias`   | Persist an operator-friendly name per camera — `~/set_alias`            |
| `SetMmapBuffers`   | Tune the V4L2 mmap buffer count — `~/set_mmap_buffers`                  |
| `SetFloat64`       | Legacy PTZ setpoints (deprecated shims) — `~/pan\|tilt\|zoom/set`       |
| `PtzMoveTo`        | Absolute / relative move, per-axis presence bits — `~/ptz/move_to`      |
| `PtzLookAt`        | Centre a point (and zoom to a box) of the displayed frame — `~/ptz/look_at` |
| `PtzStop`          | Stop one device, or every device this client controls — `~/ptz/stop`   |
| `PtzFocus`         | Focus mode / nudge / position — `~/ptz/focus`                           |
| `PtzPresetCommand` / `PtzPresetThumbnail` | Saved views and their thumbnails — `~/ptz/preset`, `~/ptz/preset_thumbnail` |

## Build

```bash
colcon build --packages-select husarion_camera_msgs
```

Consumers that build from source pull this in as a named Docker build context
(Compose `additional_contexts:` / `docker build --build-context`) straight from
this public git repo — no local copy, e.g.:

```yaml
build:
  additional_contexts:
    husarion_camera_msgs: "https://github.com/husarion/husarion_camera_msgs.git#main"
```

## License

Apache-2.0.
