project(kdegraphics)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules )

# search packages used by KDE
find_package(KDE4 REQUIRED)
find_package(Strigi REQUIRED)
include(KDE4Defaults)
include(MacroLibrary)
include(MacroOptionalAddSubdirectory)

macro_optional_find_package(Blitz)
macro_log_feature(BLITZ_FOUND "Blitz" "A a graphical effect and filter library for KDE4" "http://sourceforge.net/projects/qimageblitz" FALSE "kdesupport" "Required to build kolourpaint.")

macro_optional_find_package(Gphoto2)
macro_log_feature(GPHOTO2_FOUND "gphoto2" "A library and framework that lets you download images from several different digital camera models" "http://heanet.dl.sourceforge.net/sourceforge/gphoto" FALSE "" "Required to build the kamera project.")

macro_optional_find_package(Sane)
macro_log_feature(SANE_FOUND "SANE" "SANE libraries which are needed by applications that want to access scanners." "http://www.sane-project.org" FALSE "" "Provides scanning support for libksane and ksaneplugin.")

#X11_xf86vmode discovery is done by FindX11
macro_log_feature(X11_xf86vmode_FOUND "X11 Video Mode Extension" "An X11 extension providing access to detailed timings of video modes currently in use, and a means to modify them" "http://www.x.org" FALSE "" "X11 xvidmode extensions are needed to build kgamma.")

macro_optional_find_package(Exiv2)
macro_log_feature(EXIV2_FOUND "Exiv2" "A library to access image metadata" "http://www.exiv2.org" FALSE "" "Required to build gwenview.")

macro_optional_find_package(JPEG)
macro_log_feature(JPEG_FOUND "JPEG" "A library for reading and writing JPEG image files." "http://www.ijg.org" FALSE "" "Required to build gwenview and also provides support fof PalmDB documents in okular.")

macro_optional_find_package(Kipi)
macro_log_feature(KIPI_FOUND "KIPI" "A library for adding kipi support" "http://www.kipi-plugins.org" FALSE "" "Required to build gwenview with kipi support.")

# is this really required ?
if (APPLE)
   find_package(Carbon REQUIRED)
endif (APPLE)

add_definitions (${QT_DEFINITIONS} ${QT_QTDBUS_DEFINITIONS} ${KDE4_DEFINITIONS})
include_directories (${QDBUS_INCLUDE_DIRS} ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR} ${KDE4_INCLUDES})


add_subdirectory(cmake)
macro_optional_add_subdirectory(doc)
macro_optional_add_subdirectory(strigi-analyzer)
macro_optional_add_subdirectory(kcolorchooser)
macro_optional_add_subdirectory(kruler)
macro_optional_add_subdirectory(svgpart)
if(BLITZ_FOUND)
  macro_optional_add_subdirectory(kolourpaint)
  macro_optional_add_subdirectory(okular)
endif(BLITZ_FOUND)

if(Q_WS_X11)
    macro_optional_add_subdirectory(ksnapshot)
    if (X11_xf86vmode_FOUND)
       macro_optional_add_subdirectory(kgamma)
    endif (X11_xf86vmode_FOUND)
endif(Q_WS_X11)

if(KDE4_GPHOTO2 AND GPHOTO2_FOUND)
   macro_optional_add_subdirectory(kamera)
endif(KDE4_GPHOTO2 AND GPHOTO2_FOUND)

if (SANE_FOUND)
   add_subdirectory(libksane)
   macro_optional_add_subdirectory(ksaneplugin)
endif (SANE_FOUND)

if (EXIV2_FOUND AND JPEG_FOUND)
   macro_optional_add_subdirectory(gwenview)
endif (EXIV2_FOUND AND JPEG_FOUND)

macro_display_feature_log()
