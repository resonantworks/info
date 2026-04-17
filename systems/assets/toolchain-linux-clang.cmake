set(CMAKE_C_COMPILER "clang")
set(CMAKE_CXX_COMPILER "clang++")
set(CMAKE_LINKER "lld")

set(CMAKE_C_FLAGS "-m32 --target=i686-redhat-linux -isystem /usr/include/c++/15/i686-redhat-linux")
set(CMAKE_CXX_FLAGS "-m32 --target=i686-redhat-linux -isystem /usr/include/c++/15/i686-redhat-linux")
