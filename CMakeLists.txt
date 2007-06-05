project(kdegraphics)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules )

# search packages used by KDE
find_package(KDE4 REQUIRED)
find_package(Strigi REQUIRED)
include (KDE4Defaults)
include (MacroLibrary)
include(MacroOptionalAddSubdirectory)

macro_optional_find_package(Gphoto2)
macro_optional_find_package(Sane)
macro_optional_find_package(OpenGL)
macro_optional_find_package(IMLIB)
macro_optional_find_package(Kadmos)
macro_optional_find_package(Freetype)
macro_optional_find_package(Exiv2)
macro_optional_find_package(JPEG)

MACRO_LOG_FEATURE(GPHOTO2_FOUND "libgphoto2" "Required to build kamera project" "http://heanet.dl.sourceforge.net/sourceforge/gphoto/" FALSE "" "")
MACRO_LOG_FEATURE(SANE_FOUND "libsane" "Sane lib is needed to build kooka project" "http://www.sane-project.org/" FALSE "" "")
MACRO_LOG_FEATURE(OPENGL_FOUND "libopengl" "OpenGL lib is needed to build kpovmodeler project" "http://www.X.org/" FALSE "" "")
MACRO_LOG_FEATURE(IMLIB_FOUND "imlib" "imlib is needed to build kuickshow project" "http://freshmeat.net/projects/imlib/" FALSE "" "")
MACRO_LOG_FEATURE(X11_xf86vmode_FOUND "xf86vmode.h" "xvidmode extensions are needed to build kgamma" "http://www.x.org/" FALSE "" "")

# are these two really required ?
find_package(ZLIB REQUIRED)
if (APPLE)
   find_package(Carbon REQUIRED)
endif (APPLE)

add_definitions (${QT_DEFINITIONS} ${QT_QTDBUS_DEFINITIONS} ${KDE4_DEFINITIONS} -DHAVE_CONFIG_H=1)
include_directories (${QDBUS_INCLUDE_DIRS} ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR} ${KDE4_INCLUDES})


include (ConfigureChecks.cmake)
configure_file (config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h )


set(libdscparse_SRCS 
      ${CMAKE_SOURCE_DIR}/kghostview/dscparse.cpp 
      ${CMAKE_SOURCE_DIR}/kghostview/dscparse_adapter.cpp 
   )


add_subdirectory(cmake)
macro_optional_add_subdirectory(doc)
macro_optional_add_subdirectory(kfile-plugins)
macro_optional_add_subdirectory(kcoloredit)
macro_optional_add_subdirectory(kiconedit)
macro_optional_add_subdirectory(kruler)
macro_optional_add_subdirectory(kolourpaint)
macro_optional_add_subdirectory(ligature)
message(STATUS "disable kmrml")
#macro_optional_add_subdirectory(kmrml)

if(Q_WS_X11)
    macro_optional_add_subdirectory(kfax)
    macro_optional_add_subdirectory(ksnapshot)
    macro_optional_add_subdirectory(kghostview)
endif(Q_WS_X11)

if(KDE4_GPHOTO2 AND GPHOTO2_FOUND)
   macro_optional_add_subdirectory(kamera)
endif(KDE4_GPHOTO2 AND GPHOTO2_FOUND)

if (SANE_FOUND)
   MESSAGE(STATUS "port Kooka!")
   macro_optional_add_subdirectory(libkscan)
   #macro_optional_add_subdirectory(kooka)
endif (SANE_FOUND)

if (XVIDMODEEXTENSIONS_FOUND)
   macro_optional_add_subdirectory(kgamma)
endif (XVIDMODEEXTENSIONS_FOUND)

if(OPENGL_FOUND AND OPENGL_GLU_FOUND AND FREETYPE_FOUND)
   macro_optional_add_subdirectory(kpovmodeler)
endif(OPENGL_FOUND AND OPENGL_GLU_FOUND AND FREETYPE_FOUND)

if (IMLIB_FOUND)
   macro_optional_add_subdirectory(kuickshow)
endif (IMLIB_FOUND)

if (EXIV2_FOUND AND JPEG_FOUND)
   macro_optional_add_subdirectory(gwenview)
endif (EXIV2_FOUND AND JPEG_FOUND)

macro_optional_add_subdirectory(okular)

macro_display_feature_log()
