project(kdegraphics)

# where to look first for cmake modules, before ${CMAKE_ROOT}/Modules/ is checked
# Perhaps define share/apps as ${DATA_INSTALL_DIR}
#set(CMAKE_MODULE_PATH "${KDEDIR}/share/apps/cmake/modules/ ${CMAKE_SOURCE_DIR}/cmake/modules")

set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules )

# support for Dart: http://public.kitware.com/dashboard.php?name=kde
enable_testing()
include(CTest)

# generate non-quiet makefiles
set(CMAKE_VERBOSE_MAKEFILE ON)

# search packages used by KDE
find_package(KDE4 REQUIRED)
find_package(Perl REQUIRED)
find_package(ZLIB REQUIRED)

macro_optional_find_package(KPDF)
macro_optional_find_package(Gphoto2)
if (APPLE)
   find_package(Carbon REQUIRED)
endif (APPLE)


add_definitions(${QT_DEFINITIONS} ${KDE4_DEFINITIONS} -DHAVE_CONFIG_H=1)
link_directories(${KDE4_LIB_DIR})


include (MacroAdditionalCleanFiles)
include (MacroAddFileDependencies)
include (ConfigureChecks.cmake)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h )

macro_additional_clean_files( ${CMAKE_CURRENT_BINARY_DIR}/config.h )

include_directories(
  ${KDE4_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR}
)

set(libdscparse_SRCS 
	${CMAKE_SOURCE_DIR}/kghostview/dscparse.cpp 
	${CMAKE_SOURCE_DIR}/kghostview/dscparse_adapter.cpp 
)

add_subdirectory(doc)

if(KDE4_GPHOTO2)
	add_subdirectory(kamera)
endif(KDE4_GPHOTO2)

add_subdirectory(kcoloredit)
add_subdirectory(kfax)
add_subdirectory(kfile-plugins)
add_subdirectory(kgamma)
add_subdirectory(kghostview)
add_subdirectory(kiconedit)
add_subdirectory(kmrml)
add_subdirectory(kolourpaint)
add_subdirectory(kooka)
add_subdirectory(kpdf)
add_subdirectory(kpovmodeler)
add_subdirectory(kruler)
add_subdirectory(ksnapshot)
add_subdirectory(kuickshow)
#add_subdirectory(kviewshell)
add_subdirectory(libkscan)

MESSAGE(STATUS "Perhaps not install FindKDE4. It will conflict when we install with rpm/deb package")
add_subdirectory( cmake )

kde4_create_doxygen_docs(  )

