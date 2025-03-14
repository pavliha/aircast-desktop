cmake_minimum_required(VERSION 3.16)
project(AircastDesktop VERSION 1.0.0 LANGUAGES CXX)

# -----------------------------------------------------------------------------
# Set C++ standard and enable compile commands export for tooling support
# -----------------------------------------------------------------------------
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# -----------------------------------------------------------------------------
# macOS specific settings
# -----------------------------------------------------------------------------
if(APPLE)
    set(MACOSX_BUNDLE_ICON_FILE "AppIcon.icns")
    set(MACOSX_BUNDLE_GUI_IDENTIFIER "one.aircast.desktop")
    set(MACOSX_BUNDLE_BUNDLE_NAME "Aircast")
    set(MACOSX_BUNDLE_BUNDLE_VERSION "${PROJECT_VERSION}")
    set(MACOSX_BUNDLE_SHORT_VERSION_STRING "${PROJECT_VERSION}")
    set(MACOSX_BUNDLE_COPYRIGHT "Copyright © 2025 Aircast")
    set(MACOSX_BUNDLE_INFO_STRING "AircastDesktop - Connect to your devices")
endif()

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
# Find required Qt6 packages (note: 'ShaderTools' provides shader support)
# -----------------------------------------------------------------------------
find_package(Qt6 REQUIRED COMPONENTS 
    Core 
    Gui 
    Quick 
    Qml 
    QuickControls2
    ShaderTools
    Core5Compat
)

# -----------------------------------------------------------------------------
# Set Qt policies to ensure new behavior for certain Qt features
# -----------------------------------------------------------------------------
qt6_policy(SET QTP0001 NEW)
qt6_policy(SET QTP0004 NEW)

# -----------------------------------------------------------------------------
# Define the executable target and add the source file(s)
# -----------------------------------------------------------------------------
if(APPLE)
    # For macOS, create a bundle
    qt_add_executable(${PROJECT_NAME} MACOSX_BUNDLE
        src/main.cpp
        src/AuthManager.h
        src/AuthManager.cpp
        src/DeviceManager.h
        src/DeviceManager.cpp
        src/ThemeManager.h
        src/ThemeManager.cpp
    )
    
    # Set app icon for macOS
    set(APP_ICON_MACOS "${CMAKE_CURRENT_SOURCE_DIR}/assets/AppIcon.icns")
    if(EXISTS "${APP_ICON_MACOS}")
        target_sources(${PROJECT_NAME} PRIVATE "${APP_ICON_MACOS}")
        set_source_files_properties("${APP_ICON_MACOS}" PROPERTIES
            MACOSX_PACKAGE_LOCATION "Resources"
        )
    else()
        message(WARNING "App icon not found at: ${APP_ICON_MACOS}")
    endif()
else()
    # For non-macOS platforms, create a regular executable
    qt_add_executable(${PROJECT_NAME}
        src/main.cpp
        src/AuthManager.h
        src/AuthManager.cpp
        src/DeviceManager.h
        src/DeviceManager.cpp
        src/ThemeManager.h
        src/ThemeManager.cpp
    )
endif()

# Include the build directory to find generated config header
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_BINARY_DIR})

message(STATUS "Current source dir: ${CMAKE_CURRENT_SOURCE_DIR}")
message(STATUS "Looking for shader in: ${CMAKE_CURRENT_SOURCE_DIR}/shaders/icon.frag")


# -----------------------------------------------------------------------------
# Use Qt6 shader tools to compile and embed the shader.
# -----------------------------------------------------------------------------

message(STATUS "Shader source path: ${CMAKE_CURRENT_SOURCE_DIR}/shaders/icon.frag")
file(GLOB SHADER_SOURCE "${CMAKE_CURRENT_SOURCE_DIR}/shaders/icon.frag")
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/shaders/icon.frag")
    message(STATUS "Shader file exists")
else()
    message(STATUS "Shader file NOT found")
endif()

qt6_add_shaders(${PROJECT_NAME} 
    PREFIX "/"
    FILES
        "${CMAKE_CURRENT_SOURCE_DIR}/shaders/icon.frag"
    OUTPUTS
        "shaders/icon.frag.qsb"
    OPTIMIZED
)

get_target_property(SHADER_FILES ${PROJECT_NAME} QT_SHADER_FILES)
message(STATUS "Shader files: ${SHADER_FILES}")

# -----------------------------------------------------------------------------
# Link Qt libraries and set compile definitions
# -----------------------------------------------------------------------------
target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::Qml
    Qt6::QuickControls2
    Qt6::ShaderTools
    Qt6::Core5Compat  
)
target_compile_definitions(${PROJECT_NAME} PRIVATE QT_QML_DEBUG)

# -----------------------------------------------------------------------------
# Retrieve Qt QML import directories automatically (if available)
# -----------------------------------------------------------------------------
get_target_property(QtQmlImportDirs Qt6::Qml IMPORT_DIRS)
message(STATUS "Qt QML import dirs: ${QtQmlImportDirs}")

# -----------------------------------------------------------------------------
# Define QML files for the project
# -----------------------------------------------------------------------------
set(MYPROJECT_QML_FILES
    qml/main.qml
    # MainPage Components
    qml/MainPage/Header.qml
    qml/MainPage/TitleSection.qml
    qml/MainPage/InfoBanner.qml
    qml/MainPage/DeviceList.qml
    qml/MainPage/EmptyState.qml
    qml/MainPage/DeviceListItem.qml
    qml/MainPage/MainPage.qml
    qml/MainPage/UserMenuDropdown.qml
    qml/MainPage/ThemeToggleDropdown.qml
    qml/MainPage/StatusBadge.qml
    # SignInPage Components
    qml/SignInPage/SignInPage.qml
    qml/SignInPage/ProtectedByAirCast.qml
    qml/SignInPage/SignInCard.qml
    qml/SignInPage/BrandSection.qml
    qml/SignInPage/SupportSection.qml
    qml/SignInPage/SignInWithGoogleButton.qml
    qml/Link.qml
    qml/Separator.qml
     # DevicePage Components
     qml/DevicePage/DevicePage.qml
    # UI Components
    qml/ui/Button.qml
    qml/ui/Icon.qml
    qml/ui/DropShadow.qml
    qml/ui/ThemeItemDelegate.qml
    qml/ui/Badge.qml
    # Card Components
    qml/ui/card/Card.qml
    qml/ui/card/CardContent.qml
    qml/ui/card/CardDescription.qml
    qml/ui/card/CardFooter.qml
    qml/ui/card/CardHeader.qml
    qml/ui/card/CardTitle.qml
    # Base Components
    qml/PageBackground.qml
)

# Define singleton QML files separately
set(MYPROJECT_QML_SINGLETON_FILES
    qml/ui/Theme.qml
)
set_source_files_properties(${MYPROJECT_QML_SINGLETON_FILES} 
    PROPERTIES 
    QT_QML_SINGLETON_TYPE TRUE
)

# -----------------------------------------------------------------------------
# Enable the generation of the QMLLS config file
# -----------------------------------------------------------------------------
set(QT_QML_GENERATE_QMLLS_INI ON)

# -----------------------------------------------------------------------------
# Configure QML module with linting and type checking enabled
# -----------------------------------------------------------------------------
qt_add_qml_module(${PROJECT_NAME}
    URI AircastDesktop
    VERSION 1.0
    RESOURCE_PREFIX "/"
    QML_FILES 
        ${MYPROJECT_QML_FILES}
        ${MYPROJECT_QML_SINGLETON_FILES}
    RESOURCES
        assets/icons/circle-user.svg
        assets/icons/info.svg
        assets/icons/plus-circle.svg
        assets/icons/settings.svg
        assets/icons/google.svg
        assets/icons/arrow-right.svg
        assets/icons/log-out.svg
        assets/icons/sun.svg
        assets/icons/moon.svg
        assets/icons/monitor.svg
        assets/icons/cable.svg
    IMPORTS
        QtQuick
        QtQuick.Controls
        QtQuick.Layouts
        QtQuick.Effects
        Qt5Compat.GraphicalEffects 
)

# -----------------------------------------------------------------------------
# Create custom targets for running with different environments
# -----------------------------------------------------------------------------
add_custom_target(run_dev
    COMMAND ${CMAKE_COMMAND} -E env "AIRCAST_API_URL=http://localhost:3333" $<TARGET_FILE:${PROJECT_NAME}>
    DEPENDS ${PROJECT_NAME}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin
    COMMENT "Running with development environment"
    VERBATIM
)

add_custom_target(run_staging
    COMMAND ${CMAKE_COMMAND} -E env "AIRCAST_API_URL=https://api.dev.aircast.one" $<TARGET_FILE:${PROJECT_NAME}>
    DEPENDS ${PROJECT_NAME}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin
    COMMENT "Running with staging environment"
    VERBATIM
)

add_custom_target(run_prod
    COMMAND ${CMAKE_COMMAND} -E env "AIRCAST_API_URL=https://api.aircast.one" $<TARGET_FILE:${PROJECT_NAME}>
    DEPENDS ${PROJECT_NAME}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin
    COMMENT "Running with production environment"
    VERBATIM
)

# -----------------------------------------------------------------------------
# macOS specific configuration
# -----------------------------------------------------------------------------
if(APPLE)
    # Set additional properties for the macOS bundle
    set_target_properties(${PROJECT_NAME} PROPERTIES
        MACOSX_BUNDLE TRUE
        MACOSX_BUNDLE_INFO_PLIST "${CMAKE_CURRENT_SOURCE_DIR}/macos/Info.plist.in"
    )
    
    # Add deployment step for macOS
    # This uses macdeployqt to include all necessary Qt libraries in the bundle
    if(CMAKE_BUILD_TYPE STREQUAL "Release" OR CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
        # Find macdeployqt
        get_target_property(_qmake_executable Qt6::qmake IMPORTED_LOCATION)
        get_filename_component(_qt_bin_dir "${_qmake_executable}" DIRECTORY)
        find_program(MACDEPLOYQT_EXECUTABLE macdeployqt HINTS "${_qt_bin_dir}")
        
        if(MACDEPLOYQT_EXECUTABLE)
            add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
                COMMAND ${MACDEPLOYQT_EXECUTABLE}
                "$<TARGET_FILE_DIR:${PROJECT_NAME}>/../.."
                -qmldir=${CMAKE_CURRENT_SOURCE_DIR}/qml
                -verbose=1
                COMMENT "Running macdeployqt to deploy Qt dependencies..."
            )
        else()
            message(WARNING "macdeployqt not found, deployment will not be performed")
        endif()
    endif()
endif()