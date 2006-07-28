project(kdegraphics)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules )

# search packages used by KDE
find_package(KDE4 REQUIRED)
include (KDE4Defaults)
include (MacroLibrary)
include (MacroLogFeature)

find_package(FreeType2 REQUIRED)
macro_optional_find_package(Gphoto2)
macro_optional_find_package(Sane)
macro_optional_find_package(OpenGL)
macro_optional_find_package(IMLIB)

MACRO_LOG_FEATURE(GPHOTO2_FOUND "libgphoto2" "Need to build kamera project" "http://heanet.dl.sourceforge.net/sourceforge/gphoto/" FALSE "" "")
MACRO_LOG_FEATURE(SANE_FOUND "libsane" "Sane lib is needed to build kooka project" "http://www.sane-project.org/" FALSE "" "")
MACRO_LOG_FEATURE(OPENGL_FOUND "libopengl" "OpenGL lib is need to build kpovmodeler project" "http://www.X.org/" FALSE "" "")
MACRO_LOG_FEATURE(IMLIB_FOUND "imlib" "imlib is need to build kuickshow project" "http://www.gnome.org/" FALSE "" "")

# are these two really required ?
find_package(ZLIB REQUIRED)
if (APPLE)
   find_package(Carbon REQUIRED)
endif (APPLE)


add_definitions (${QT_DEFINITIONS} ${QT_QTDBUS_DEFINITIONS} ${KDE4_DEFINITIONS} -DHAVE_CONFIG_H=1)
link_directories (${KDE4_LIB_DIR})
include_directories (${QDBUS_INCLUDE_DIRS} ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR} ${KDE4_INCLUDES})


include (ConfigureChecks.cmake)
configure_file (config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h )


set(libdscparse_SRCS 
	${CMAKE_SOURCE_DIR}/kghostview/dscparse.cpp 
	${CMAKE_SOURCE_DIR}/kghostview/dscparse_adapter.cpp 
)

add_subdirectory(doc)

if(KDE4_GPHOTO2 AND GPHOTO2_FOUND)
   add_subdirectory(kamera)
endif(KDE4_GPHOTO2 AND GPHOTO2_FOUND)


if (SANE_FOUND)
   MESSAGE(STATUS "port Kooka!")
   add_subdirectory(libkscan)
   #add_subdirectory(kooka)
endif (SANE_FOUND)

add_subdirectory(kcoloredit)
add_subdirectory(kfax)
add_subdirectory(kfile-plugins)
add_subdirectory(kgamma)
add_subdirectory(kghostview)
add_subdirectory(kiconedit)
MESSAGE(STATUS "disable kmrml")
#add_subdirectory(kmrml)
add_subdirectory(kolourpaint)
if(OPENGL_FOUND AND OPENGL_GLU_FOUND)
	add_subdirectory(kpovmodeler)
endif(OPENGL_FOUND AND OPENGL_GLU_FOUND)
add_subdirectory(kruler)
add_subdirectory(ksnapshot)
if (IMLIB_FOUND)
   MESSAGE(STATUS "port kuickshow!")
   #add_subdirectory(kuickshow)
endif (IMLIB_FOUND)
add_subdirectory(kviewshell)

add_subdirectory( cmake )

macro_display_feature_log()
