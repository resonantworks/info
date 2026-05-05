set(CMAKE_C_COMPILER "gcc")
set(CMAKE_CXX_COMPILER "g++")
set(CMAKE_LINKER "ld")

set(CMAKE_C_FLAGS_INIT "-m32")
set(CMAKE_CXX_FLAGS_INIT "-m32")

# Workaround for Fedora missing 32-bit headers issue
if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux" AND EXISTS "/usr/include/c++/15/i686-redhat-linux")
  string(APPEND CMAKE_C_FLAGS_INIT " -isystem /usr/include/c++/15/i686-redhat-linux")
  string(APPEND CMAKE_CXX_FLAGS_INIT " -isystem /usr/include/c++/15/i686-redhat-linux")
endif()
