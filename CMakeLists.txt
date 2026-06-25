cmake_minimum_required(VERSION 3.14)
project(husarion_camera_msgs)

if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 17)
endif()

find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)

rosidl_generate_interfaces(${PROJECT_NAME}
  "msg/CameraResolution.msg"
  "msg/CameraFormat.msg"
  "msg/CameraCapabilities.msg"
  "msg/CameraMode.msg"
  "msg/CameraDevice.msg"
  "msg/CameraDeviceList.msg"
  "msg/AudioPacket.msg"
  "msg/AudioInfo.msg"
  "srv/SetFloat64.srv"
  "srv/SetCameraFormat.srv"
  "srv/SetMmapBuffers.srv"
  "srv/SetCameraDevice.srv"
  "srv/SetCameraAlias.srv"
)

ament_export_dependencies(rosidl_default_runtime)
ament_package()
