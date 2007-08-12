project(kdegraphics)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules )

# search packages used by KDE
find_package(KDE4 REQUIRED)
find_package(Strigi REQUIRED)
include (KDE4Defaults)
include (MacroLibrary)
include(MacroOptionalAddSubdirectory)

macro_optional_find_package(Blitz)
macro_optional_find_package(Gphoto2)
macro_optional_find_package(Sane)
macro_optional_find_package(Exiv2)
macro_optional_find_package(JPEG)

MACRO_LOG_FEATURE(BLITZ_FOUND "Blitz" "Required to build kolourpaint" "http://sourceforge.net/projects/qimageblitz/" FALSE "0.0.3" "Provided with kdesupport")
MACRO_LOG_FEATURE(GPHOTO2_FOUND "libgphoto2" "Required to build kamera project" "http://heanet.dl.sourceforge.net/sourceforge/gphoto/" FALSE "" "")
MACRO_LOG_FEATURE(SANE_FOUND "libsane" "Sane lib is needed to build libkscan" "http://www.sane-project.org/" FALSE "" "")
MACRO_LOG_FEATURE(X11_xf86vmode_FOUND "xf86vmode.h" "xvidmode extensions are needed to build kgamma" "http://www.x.org/" FALSE "" "")
MACRO_LOG_FEATURE(EXIV2_FOUND "Exiv2 library" "The exiv2 library is needed to build gwenview. Gwenview will not be built without it." "http://www.exiv2.org/" FALSE "" "")

# are these two really required ?
find_package(ZLIB REQUIRED)
if (APPLE)
   find_package(Carbon REQUIRED)
endif (APPLE)

add_definitions (${QT_DEFINITIONS} ${QT_QTDBUS_DEFINITIONS} ${KDE4_DEFINITIONS})
include_directories (${QDBUS_INCLUDE_DIRS} ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR} ${KDE4_INCLUDES})



set(libdscparse_SRCS 
      ${CMAKE_SOURCE_DIR}/kghostview/dscparse.cpp 
      ${CMAKE_SOURCE_DIR}/kghostview/dscparse_adapter.cpp 
   )


add_subdirectory(cmake)
macro_optional_add_subdirectory(doc)
macro_optional_add_subdirectory(strigi-analyzer)
macro_optional_add_subdirectory(kcolorchooser)
macro_optional_add_subdirectory(kruler)
if(BLITZ_FOUND)
  macro_optional_add_subdirectory(kolourpaint)
endif(BLITZ_FOUND)

if(Q_WS_X11)
    macro_optional_add_subdirectory(ksnapshot)
    macro_optional_add_subdirectory(kghostview)
endif(Q_WS_X11)

if(KDE4_GPHOTO2 AND GPHOTO2_FOUND)
   macro_optional_add_subdirectory(kamera)
endif(KDE4_GPHOTO2 AND GPHOTO2_FOUND)

if (SANE_FOUND)
   macro_optional_add_subdirectory(libkscan)
endif (SANE_FOUND)

if (XVIDMODEEXTENSIONS_FOUND)
   macro_optional_add_subdirectory(kgamma)
endif (XVIDMODEEXTENSIONS_FOUND)

if (EXIV2_FOUND AND JPEG_FOUND)
   macro_optional_add_subdirectory(gwenview)
endif (EXIV2_FOUND AND JPEG_FOUND)

macro_optional_add_subdirectory(okular)

macro_display_feature_log()
