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
    src/devicemanager.h
    src/devicemanager.cpp
)

# -----------------------------------------------------------------------------
# Link Qt libraries and set compile definitions
# -----------------------------------------------------------------------------
target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::Qml
    Qt6::QuickControls2
)

target_compile_definitions(${PROJECT_NAME} PRIVATE
    QT_QML_DEBUG
    QML_IMPORT_PATH="${CMAKE_BINARY_DIR}"
)

# -----------------------------------------------------------------------------
# Define QML files for the project
# -----------------------------------------------------------------------------
set(MYPROJECT_QML_FILES
    qml/main.qml
    qml/Header.qml
    qml/MainPage/TitleSection.qml
    qml/MainPage/InfoBanner.qml
    qml/MainPage/DeviceList.qml
    qml/MainPage/EmptyState.qml
    qml/MainPage/DeviceDelegate.qml
    qml/MainPage/MainPage.qml
    qml/SignInPage/SignInPage.qml
    qml/SignInPage/ProtectedByAirCast.qml
    qml/SignInPage/SignInCard.qml
    qml/SignInPage/BrandSection.qml
    qml/SignInPage/SupportSection.qml
    qml/SignInPage/SignInWithGoogleButton.qml
    qml/LinkText.qml
    qml/Separator.qml

    # UI Components
    qml/ui/Button.qml

    # Card Components
    qml/ui/card/Card.qml
    qml/ui/card/CardContent.qml
    qml/ui/card/CardDescription.qml
    qml/ui/card/CardFooter.qml
    qml/ui/card/CardHeader.qml
    qml/ui/card/CardTitle.qml
)


# Define singleton QML files separately
set(MYPROJECT_QML_SINGLETON_FILES
    qml/ui/Theme.qml
)

# Set the singleton property for Theme.qml
set_source_files_properties(${MYPROJECT_QML_SINGLETON_FILES} 
    PROPERTIES 
    QT_QML_SINGLETON_TYPE TRUE
)


# Enable the generation of the QMLLS config file
set(QT_QML_GENERATE_QMLLS_INI ON)

# -----------------------------------------------------------------------------
# Configure QML module with linting and type checking enabled
# -----------------------------------------------------------------------------
qt_add_qml_module(${PROJECT_NAME}
    URI myproject
    VERSION 1.0
    RESOURCE_PREFIX "/"
    QML_FILES 
        ${MYPROJECT_QML_FILES}
        ${MYPROJECT_QML_SINGLETON_FILES}
    RESOURCES
        assets/icons/theme.svg
        assets/icons/circle-user.svg
        assets/icons/info.svg
        assets/icons/plus-circle.svg
        assets/icons/settings.svg
        assets/icons/google.svg
        assets/icons/arrow-right.svg
)


