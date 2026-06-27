# husarion_camera_msgs

ROS 2 message and service definitions for the [Husarion camera node](https://github.com/husarion/husarion-cockpit) — video formats and devices, Opus audio, and runtime camera control.

A standard `ament_cmake` + `rosidl` interface package. It is consumed by:

- **the camera node** (`husarion/camera`) — publishes `CameraMode`, `CameraCapabilities`, `CameraDeviceList`, `AudioInfo` / `AudioPacket`, and serves the camera-control services below;
- **`husarion_rosbridge`** (and the legacy foxglove-bridge image) — binds these types so they can be advertised + called over the WebSocket;
- the `husarion-camera` / `husarion-webui` snaps.

## Interfaces

**Messages** (`msg/`) — latched on the camera node's topics:

| Message                      | Topic / purpose                                                              |
| ---------------------------- | --------------------------------------------------------------------------- |
| `CameraMode`                 | Currently-active capture mode (format / w / h / fps) — `~/active_mode`       |
| `CameraCapabilities`         | Discovered V4L2 fmt-tree (`CameraFormat` / `CameraResolution`) — `~/capabilities` |
| `CameraDeviceList`           | Enumerated cameras (`CameraDevice[]`) + active id — `~/devices`             |
| `AudioInfo` / `AudioPacket`  | Opus stream parameters (`~/audio_info`) + packets (`~/audio`)               |

**Services** (`srv/`):

| Service            | Topic / purpose                                                          |
| ------------------ | ----------------------------------------------------------------------- |
| `SetCameraFormat`  | Switch capture mode at runtime (atomic V4L2 + encoder restart) — `~/set_format` |
| `SetCameraDevice`  | Swap the active camera / ingest a ROS-topic source — `~/set_device`     |
| `SetCameraAlias`   | Persist an operator-friendly name per camera — `~/set_alias`            |
| `SetMmapBuffers`   | Tune the V4L2 mmap buffer count — `~/set_mmap_buffers`                  |
| `SetFloat64`       | PTZ setpoints — `~/pan\|tilt\|zoom/set` + `~/ptz/home` (UVC controls)   |

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
