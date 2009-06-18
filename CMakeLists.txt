project(kdegraphics)

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules )

# search packages used by KDE
find_package(KDE4 REQUIRED)
find_package(Strigi REQUIRED)
include(KDE4Defaults)
include(MacroLibrary)
include(MacroOptionalAddSubdirectory)
if( WIN32 )
find_package( Expat )
endif( WIN32 )

#require by libs/libkdcraw, gwenview, and okular
find_package(JPEG REQUIRED)

macro_optional_find_package(QImageBlitz)
macro_log_feature(QIMAGEBLITZ_FOUND "QImageBlitz" "An image effects library" "http://sourceforge.net/projects/qimageblitz" FALSE "kdesupport" "Required to build kolourpaint and okular.")

macro_optional_find_package(Gphoto2)
macro_log_feature(GPHOTO2_FOUND "gphoto2" "A library and framework that lets you download images from several different digital camera models" "http://heanet.dl.sourceforge.net/sourceforge/gphoto" FALSE "" "Required to build the kamera project.")

macro_optional_find_package(Sane)
macro_log_feature(SANE_FOUND "SANE" "SANE libraries which are needed by applications that want to access scanners." "http://www.sane-project.org" FALSE "" "Provides scanning support for libksane and ksaneplugin.")

if(X11_FOUND)
  #X11_xf86vmode discovery is done by FindX11
  macro_log_feature(X11_xf86vmode_FOUND "X11 Video Mode Extension (xf86vm)" "An X11 extension providing access to detailed timings of video modes currently in use, and a means to modify them" "http://www.x.org" FALSE "" "X11 xvidmode extensions are needed to build kgamma.")
endif(X11_FOUND)

set(EXIV2_MIN_VERSION "0.17") # std::string Metadatum::print(const ExifData* pMetadata) const  was added in 0.18
macro_optional_find_package(Exiv2)
macro_log_feature(EXIV2_FOUND "Exiv2" "A library to access image metadata" "http://www.exiv2.org" FALSE ${EXIV2_MIN_VERSION} "Required to build libkexiv2 and gwenview.")

macro_optional_find_package(JPEG)
macro_log_feature(JPEG_FOUND "JPEG" "A library for reading and writing JPEG image files" "http://www.ijg.org" FALSE "" "Required to build gwenview and also provides support fof PalmDB documents in okular.")

macro_optional_find_package(Kipi)
macro_log_feature(KIPI_FOUND "KIPI" "A library for adding kipi support" "http://www.kipi-plugins.org" FALSE "" "Required to build gwenview with kipi support.")

macro_optional_find_package(Kdcraw)
#do not macro_log_feature() Kdcraw
macro_optional_find_package(Kexiv2)
#do not macro_log_feature() Kexiv2

add_definitions (${QT_DEFINITIONS} ${QT_QTDBUS_DEFINITIONS} ${KDE4_DEFINITIONS})
include_directories (${QDBUS_INCLUDE_DIRS} ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR} ${KDE4_INCLUDES})


add_subdirectory(cmake)
add_subdirectory(libs)
macro_optional_add_subdirectory(doc)
macro_optional_add_subdirectory(strigi-analyzer)
macro_optional_add_subdirectory(thumbnailers)
macro_optional_add_subdirectory(kcolorchooser)
macro_optional_add_subdirectory(kruler)
macro_optional_add_subdirectory(svgpart)
if(QIMAGEBLITZ_FOUND)
  macro_optional_add_subdirectory(kolourpaint)
  macro_optional_add_subdirectory(okular)
endif(QIMAGEBLITZ_FOUND)

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
   macro_optional_add_subdirectory(ksaneplugin)
endif (SANE_FOUND)

if (EXIV2_FOUND)
   macro_optional_add_subdirectory(gwenview)
endif (EXIV2_FOUND)

macro_display_feature_log()
