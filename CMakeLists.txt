cmake_minimum_required(VERSION 3.16)
project(myproject VERSION 1.0.0 LANGUAGES CXX)

# -----------------------------------------------------------------------------
# Set C++ standard and enable compile commands export for tooling support
# -----------------------------------------------------------------------------
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# -----------------------------------------------------------------------------
# Specify output directories
# -----------------------------------------------------------------------------
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")

# -----------------------------------------------------------------------------
# Enable Qt features: automoc, autorcc, and autouic for automatic code generation
# -----------------------------------------------------------------------------
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# -----------------------------------------------------------------------------
# Ensure CMake finds Qt modules by adding QTDIR (if defined) to CMAKE_PREFIX_PATH
# -----------------------------------------------------------------------------
if(DEFINED ENV{QTDIR})
  message(STATUS "Using Qt installation from: $ENV{QTDIR}")
  set(CMAKE_PREFIX_PATH $ENV{QTDIR})
endif()

# -----------------------------------------------------------------------------
# Find required Qt6 packages
# -----------------------------------------------------------------------------
find_package(Qt6 REQUIRED COMPONENTS 
    Core 
    Gui 
    Quick 
    Qml 
    QuickControls2
)

# -----------------------------------------------------------------------------
# Set Qt policies to ensure new behavior for certain Qt features
# -----------------------------------------------------------------------------
qt6_policy(SET QTP0001 NEW)
qt6_policy(SET QTP0004 NEW)

# -----------------------------------------------------------------------------
# Define the executable target and add the source file(s)
# -----------------------------------------------------------------------------
qt_add_executable(${PROJECT_NAME}
    src/main.cpp
)

# Link the necessary Qt libraries to the executable
target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::Qml
    Qt6::QuickControls2
)

# -----------------------------------------------------------------------------
# Specify the QML module
#
# The following configuration embeds your QML files and resource files into the
# Qt resource system. The module is given the URI "myproject" with version 1.0,
# and the RESOURCE_PREFIX controls the top-level path within the resource file.
#
# NOTE: If your QML files are stored in a subdirectory (e.g., "qml/"), the module
# system may preserve that subfolder in the resource path. Adjust your QML load
# paths in your code accordingly.
# -----------------------------------------------------------------------------
set(MYPROJECT_QML_FILES
    qml/main.qml
    qml/Header.qml
    qml/TitleSection.qml
    qml/InfoBanner.qml
    qml/DeviceList.qml
    qml/EmptyState.qml
    qml/DeviceDelegate.qml
)

qt_add_qml_module(${PROJECT_NAME}
    URI myproject
    VERSION 1.0
    RESOURCE_PREFIX "/myproject"
    QML_FILES ${MYPROJECT_QML_FILES}
    RESOURCES
        assets/icons/theme.svg
        assets/icons/circle-user.svg
        assets/icons/info.svg
        assets/icons/plus-circle.svg
        assets/icons/settings.svg
)
