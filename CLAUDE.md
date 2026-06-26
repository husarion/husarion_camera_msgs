# husarion_camera_msgs — AI context

ROS 2 **message + service definitions** for the Husarion camera node: video
formats/devices, Opus audio, and runtime camera control. A pure interface
package (ament/colcon, no code) — `msg/` (AudioInfo, AudioPacket,
CameraCapabilities, CameraDevice, CameraDeviceList, CameraFormat, CameraMode,
CameraResolution) + `srv/` (SetCameraAlias, SetCameraDevice, SetCameraFormat,
SetFloat64, SetMmapBuffers).

## Load-bearing invariants

- **This is an ABI shared by THREE artifacts** — the camera node, the web bridge
  (`husarion_rosbridge`, which binds these types to relay them to the browser),
  and any tool that introspects them. A field change rebuilds the RIHS type hash.
- **Release in lockstep with the camera node AND the bridge.** Changing a type
  and releasing only one consumer makes a latched topic (e.g. `~/devices`)
  silently fail to deliver across the type-hash skew — the symptom is a web UI
  camera picker stuck "Waiting…" while video still flows (RMW-independent). Bump
  every consumer's pin together.
- **Versioned conservatively** — it's the wire ABI everyone depends on. Additive
  changes (new optional fields at the end) are far safer than reshuffles.

## How it's consumed

Pulled by every consumer as a **git-URL build context** at build time
(`--build-context husarion_camera_msgs=https://github.com/husarion/husarion_camera_msgs.git#main`),
not a local copy — so this repo must stay **public** (CI buildkit git fetches are
unauthenticated; a private repo 401s). Verify a change builds with
`colcon build --packages-select husarion_camera_msgs` in a sourced ROS 2 env.

## Conventions

Commit as the operator with **no `Co-Authored-By` Claude trailer** (this is a
`husarion/*` repo). Never push (the operator pushes).
