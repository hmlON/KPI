#-------------------------------------------------
#
# Project created by QtCreator 2016-05-20T16:38:11
#
#-------------------------------------------------

QT       += core gui sql

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = HotelAdministrator
TEMPLATE = app


SOURCES += main.cpp\
        hoteladministrator.cpp \
    settlementwindow.cpp \
    database.cpp \
    evictionwindow.cpp \
    searchwindow.cpp \
    displaywindow.cpp

HEADERS  += hoteladministrator.h \
    settlementwindow.h \
    database.h \
    evictionwindow.h \
    searchwindow.h \
    displaywindow.h

FORMS    += hoteladministrator.ui \
    settlementwindow.ui \
    evictionwindow.ui \
    searchwindow.ui \
    displaywindow.ui

OTHER_FILES += \
    resourses/clients.sqlite
