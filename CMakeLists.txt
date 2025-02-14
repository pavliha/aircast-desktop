cmake_minimum_required(VERSION 3.16)
project(myproject VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Enable Qt features
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Find required Qt packages
find_package(Qt6 REQUIRED COMPONENTS Core Gui Widgets)

qt_add_executable(myproject
    src/main.cpp
    src/widget.cpp
    src/widget.h
)

target_link_libraries(myproject PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
)