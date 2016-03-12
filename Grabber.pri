# Options
CONFIG += use_ssl
Release {
    CONFIG += use_breakpad
}

# Travis settings
@
T = $$(TRAVIS)
!isEmpty(T) {
    CONFIG -= use_breakpad use_qscintilla
}
@

# Global
APP_VERSION = \\\"4.3.0\\\"

# General
TEMPLATE = app
DEPENDPATH += . .. ../includes ../languages ../source ../vendor
INCLUDEPATH += . .. ../includes ../source ../vendor
DEFINES += VERSION=$$APP_VERSION
QT += core network xml sql script

# Windows specials
win32 {
        QT += winextras
}

# Additionnal
CONFIG += plugin c++11
RESOURCES += ../resources.qrc
RC_FILE = ../icon.rc
CODECFORTR = UTF-8
TRANSLATIONS += languages/English.ts languages/Français.ts languages/Russian.ts

# Target WinXP
Release:win32 {
    QMAKE_LFLAGS_WINDOWS = /SUBSYSTEM:WINDOWS,5.01
    QMAKE_LFLAGS_CONSOLE = /SUBSYSTEM:CONSOLE,5.01
    DEFINES += _ATL_XP_TARGETING
    QMAKE_CFLAGS += /D _USING_V110_SDK71
    QMAKE_CXXFLAGS += /D _USING_V110_SDK71
    LIBS *= -L"%ProgramFiles(x86)%/Microsoft SDKs/Windows/7.1A/Lib"
    INCLUDEPATH += "%ProgramFiles(x86)%/Microsoft SDKs/Windows/7.1A/Include"
}

# SSL
use_ssl {
    win32 {
        LIBS += -L"C:/OpenSSL-Win32/lib" -llibeay32
        INCLUDEPATH += C:/OpenSSL-Win32/include
    }
    unix {
        PKGCONFIG += openssl
    }
}

# Google-Breakpad
use_breakpad {
    DEFINES += USE_BREAKPAD=1
    win32 {
        QMAKE_LFLAGS_RELEASE = /INCREMENTAL:NO /DEBUG
        QMAKE_CFLAGS_RELEASE = -O2 -MD -zi
                BREAKPAD = D:/bin/google-breakpad
                Debug:LIBS	+= $${BREAKPAD}/src/client/windows/Debug/lib/common.lib \
                                   $${BREAKPAD}/src/client/windows/Debug/lib/crash_generation_client.lib \
                                   $${BREAKPAD}/src/client/windows/Debug/lib/exception_handler.lib
        Release:LIBS	+= $${BREAKPAD}/src/client/windows/Release/lib/common.lib \
                                   $${BREAKPAD}/src/client/windows/Release/lib/crash_generation_client.lib \
                                   $${BREAKPAD}/src/client/windows/Release/lib/exception_handler.lib
    }
    unix {
        QMAKE_CXXFLAGS += -fpermissive
        BREAKPAD = ~/Programmation/google-breakpad
        LIBS += $${BREAKPAD}/src/client/linux/libbreakpad_client.a
    }
    INCLUDEPATH += $${BREAKPAD}/src
}

OTHER_FILES += \
    ../Grabber.pri \
    ../icon.rc \
    ../.gitignore

DISTFILES += \
    ../README.md \
    ../LICENSE \
    ../NOTICE
