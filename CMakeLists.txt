cmake_minimum_required(VERSION 3.16)
project(myproject VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Specify output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Enable Qt features
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Find required Qt packages
find_package(Qt6 REQUIRED COMPONENTS 
    Core 
    Gui 
    Quick 
    Qml 
    QuickControls2
)

# Set Qt policies after finding Qt
qt6_policy(SET QTP0001 NEW)
qt6_policy(SET QTP0004 NEW)

qt_add_executable(${PROJECT_NAME}
    src/main.cpp
    resources.qrc
)

target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::Qml
    Qt6::QuickControls2
)

qt_add_qml_module(${PROJECT_NAME}
    URI myproject
    VERSION 1.0
    QML_FILES
        qml/main.qml
    RESOURCE_PREFIX "/myproject"
)