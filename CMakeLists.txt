project(kdegraphics)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake/modules )

OPTION(BUILD_LIBS "build kdegraphics library" ON)
# search packages used by KDE
find_package(KDE4 REQUIRED)
include(KDE4Defaults)
include(MacroLibrary)
include(MacroOptionalAddSubdirectory)
if( WIN32 )
find_package( Expat )
endif( WIN32 )

#required by okular
find_package(JPEG REQUIRED)

macro_optional_find_package(QImageBlitz)
macro_log_feature(QIMAGEBLITZ_FOUND "QImageBlitz" "An image effects library" "http://sourceforge.net/projects/qimageblitz" FALSE "kdesupport" "Required to build kolourpaint and okular.")

macro_optional_find_package(JPEG)
macro_log_feature(JPEG_FOUND "JPEG" "A library for reading and writing JPEG image files" "http://www.ijg.org" FALSE "" "Required to build gwenview and also provides support fof PalmDB documents in okular.")

macro_optional_find_package(Kdcraw)
#do not macro_log_feature() Kdcraw
macro_optional_find_package(Kexiv2)
#do not macro_log_feature() Kexiv2

add_definitions (${QT_DEFINITIONS} ${QT_QTDBUS_DEFINITIONS} ${KDE4_DEFINITIONS} )
include_directories (${QDBUS_INCLUDE_DIRS} ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR} ${KDE4_INCLUDES})


add_subdirectory(cmake)
if (BUILD_LIBS)
    add_subdirectory(libs)
endif(BUILD_LIBS)
if(QIMAGEBLITZ_FOUND)
  macro_optional_add_subdirectory(okular)
endif(QIMAGEBLITZ_FOUND)

macro_optional_add_subdirectory(doc)
macro_display_feature_log()
