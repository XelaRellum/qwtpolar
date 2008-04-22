# -*- mode: sh -*- ##############################################
# QwtPolar Widget Library
# Copyright (C) 2008   Uwe Rathmann
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GPL License, Version 2.0
#################################################################

include( ../qwtpolar.pri )

TARGET            = qwtpolar
TEMPLATE          = lib

MOC_DIR           = moc
OBJECTS_DIR       = obj
DESTDIR           = ../lib

contains(CONFIG, QwtPolarDll ) {
    CONFIG += dll
}
else {
    CONFIG += staticlib
}

INCLUDEPATH += $$QWT_INCLUDEPATH
DEPENDPATH  += $$QWT_INCLUDEPATH

HEADERS += \
    qwt_polar_global.h \
    qwt_polar.h \
    qwt_polar_point.h \
    qwt_polar_item.h \
    qwt_polar_panner.h \
    qwt_polar_magnifier.h \
    qwt_polar_grid.h \
    qwt_polar_curve.h \
    qwt_polar_marker.h \
    qwt_polar_itemdict.h \
    qwt_polar_canvas.h \
    qwt_polar_plot.h

SOURCES += \
    qwt_polar_point.cpp \
    qwt_polar_item.cpp \
    qwt_polar_panner.cpp \
    qwt_polar_magnifier.cpp \
    qwt_polar_grid.cpp \
    qwt_polar_curve.cpp \
    qwt_polar_marker.cpp \
    qwt_polar_itemdict.cpp \
    qwt_polar_canvas.cpp \
    qwt_polar_plot.cpp

# Install directives

headers.files  = $$HEADERS
doc.files      = ../doc/html
unix {
    doc.files      += ../doc/man
}

INSTALLS       = target headers doc

win32 {
    contains(CONFIG, QwtPolarDll) {
    	DEFINES    += QT_DLL QWT_DLL QWT_POLAR_DLL QWT_POLAR_MAKEDLL
		QWTLIB     = qwt$${QWT_VERSION_MAJ}
	}
	else {
		QWTLIB     = qwt
	}

    msvc:LIBS  += $${QWT_LIBRARYPATH}/$${QWTLIB}.lib
    msvc.net:LIBS  += $${QWT_LIBRARYPATH}/$${QWTLIB}.lib
    msvc2005:LIBS += $${QWT_LIBRARYPATH}/$${QWTLIB}.lib
    g++:LIBS   += -L$${QWT_LIBRARYPATH} -lqwt
}
else {
	LIBS   += -L$${QWT_LIBRARYPATH} -lqwt
}
