cmake_minimum_required(VERSION 3.14)
project(husarion_camera_msgs)

if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 17)
endif()

find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(std_msgs REQUIRED)
find_package(builtin_interfaces REQUIRED)

rosidl_generate_interfaces(${PROJECT_NAME}
  "msg/CameraResolution.msg"
  "msg/CameraFormat.msg"
  "msg/CameraCapabilities.msg"
  "msg/CameraMode.msg"
  "msg/CameraDevice.msg"
  "msg/CameraDeviceList.msg"
  "msg/AudioPacket.msg"
  "msg/AudioInfo.msg"
  "msg/PtzCapabilities.msg"
  "msg/PtzCapabilitiesList.msg"
  "msg/PtzState.msg"
  "msg/PtzVelocity.msg"
  "msg/PtzPreset.msg"
  "msg/PtzPresetList.msg"
  "msg/PtzPresetLists.msg"
  "srv/SetFloat64.srv"
  "srv/SetCameraFormat.srv"
  "srv/SetMmapBuffers.srv"
  "srv/SetCameraDevice.srv"
  "srv/SetCameraAlias.srv"
  "srv/PtzMoveTo.srv"
  "srv/PtzLookAt.srv"
  "srv/PtzFocus.srv"
  "srv/PtzPresetCommand.srv"
  "srv/PtzPresetThumbnail.srv"
  "srv/PtzStop.srv"
  DEPENDENCIES std_msgs builtin_interfaces
)

ament_export_dependencies(rosidl_default_runtime)
ament_package()
