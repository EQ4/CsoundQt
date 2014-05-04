CONFIG *= thread \
    warn_on
CONFIG -= stl
QT *= xml

build32:TMPDIR = build/floats
build64:TMPDIR = build/doubles
#build64:DEFINES += USE_DOUBLE
OBJECTS_DIR = "$${TMPDIR}/obj"

DEFAULT_RTMIDI_DIRNAME="rtmidi-2.0.1"
DEFAULT_RTMIDI_DIRS = $${DEFAULT_RTMIDI_DIRNAME} \
  ../$${DEFAULT_RTMIDI_DIRNAME} \
  ../../../$${DEFAULT_RTMIDI_DIRNAME}
DEFAULT_RTMIDI_DIRNAME="rtmidi-1.0.15"
DEFAULT_RTMIDI_DIRS += $${DEFAULT_RTMIDI_DIRNAME} \
  ../$${DEFAULT_RTMIDI_DIRNAME} \
  ../../../$${DEFAULT_RTMIDI_DIRNAME}

exists(config.user.pri) {
    include(config.user.pri)
    !no_messages:message(... config.user.pri found)
}
!no_messages {
	message()
	build32:message(Building CsoundQt for the single precision version of Csound.)
	build64:message(Building CsoundQt for the double precision version of Csound.)
	CONFIG(debug, debug|release):message(Building debug version.)
	CONFIG(release, debug|release):message(Building release version.)
	message()
	message(CONFIG ...)
	for(flag, CONFIG):message(+ $$flag)
	message()
}
isEmpty(CSOUND_API_INCLUDE_DIR) {
    !isEmpty(CSOUND_INCLUDE_DIR):CSOUND_API_INCLUDE_DIR = $${CSOUND_INCLUDE_DIR}
    isEmpty(CSOUND_API_INCLUDE_DIR):!isEmpty(CSOUND_SOURCE_TREE) {
        CSOUND_API_INCLUDE_DIR = $${CSOUND_SOURCE_TREE}/include
        CSOUND_INTERFACES_INCLUDE_DIR = $${CSOUND_SOURCE_TREE}/interfaces
    }
    isEmpty(CSOUND_API_INCLUDE_DIR) {
        !no_messages:message(Csound API include directory not specified.)
        for(dir, DEFAULT_CSOUND_API_INCLUDE_DIRS) {
            !no_messages:message(... searching in $${dir})
            exists($${dir}):exists($${dir}/csound.h):exists($${dir}/cwindow.h) {
                !no_messages {
                    message(CSOUND_API_INCLUDE_DIR set to $${dir})
                    message()
                }
                CSOUND_API_INCLUDE_DIR = $${dir}
                break()
            }
        }
    }
    isEmpty(CSOUND_API_INCLUDE_DIR):error(A valid Csound API include directory was not found.)
}
isEmpty(CSOUND_LIBRARY_DIR) {
    !isEmpty(CSOUND_SOURCE_TREE):CSOUND_LIBRARY_DIR = $${CSOUND_SOURCE_TREE}
    else {
        !no_messages:message(Csound library directory not specified.)
        for(dir, DEFAULT_CSOUND_LIBRARY_DIRS) {
            !no_messages:message(... searching in $${dir})
            exists($${dir}) {
                !no_messages:message(... in $${dir} for $${DEFAULT_CSOUND_LIBS})
                for(csound_lib, DEFAULT_CSOUND_LIBS):exists($${dir}/$${csound_lib}) {
                    !no_messages {
                        message(CSOUND_LIBRARY_DIR set to $${dir})
                        message()
                    }
                    CSOUND_LIB = $${csound_lib}
                    CSOUND_LIBRARY_DIR = $${dir}
                    break()
                }
            }
        }
    }
    isEmpty(CSOUND_LIBRARY_DIR):error(A valid Csound library directory was not found.)
}
isEmpty(CSOUND_LIB) {
    for(csound_lib, DEFAULT_CSOUND_LIBS):exists($${CSOUND_LIBRARY_DIR}/$${csound_lib}) {
        CSOUND_LIB = $${csound_lib}
        break()
    }
    isEmpty(CSOUND_LIB):error(A valid csound library was not found.)
}
isEmpty(LIBSNDFILE_INCLUDE_DIR) {
    !no_messages:message(libsndfile include directory not specified.)
    for(dir, DEFAULT_LIBSNDFILE_INCLUDE_DIRS) {
        !no_messages:message(... searching in $${dir})
        exists($${dir}):exists($${dir}/sndfile.h) {
            !no_messages {
                message(LIBSNDFILE_INCLUDE_DIR set to $${dir})
                message()
            }
            LIBSNDFILE_INCLUDE_DIR = $${dir}
            break()
        }
    }
    isEmpty(LIBSNDFILE_INCLUDE_DIR):error(A valid libsndfile include directory was not found.)
}
isEmpty(LIBSNDFILE_LIBRARY_DIR) {
    !no_messages:message(libsndfile library directory not specified.)
    for(dir, DEFAULT_LIBSNDFILE_LIBRARY_DIRS) {
        !no_messages:message(... searching in $${dir})
        exists($${dir}):exists($${dir}/$${LIBSNDFILE_LIB}) {
            !no_messages {
                message(LIBSNDFILE_LIBRARY_DIR set to $${dir})
                message()
            }
            LIBSNDFILE_LIBRARY_DIR = $${dir}
            break()
        }
    }
    isEmpty(LIBSNDFILE_LIBRARY_DIR):error(A valid libsndfile library directory was not found.)
}
pythonqt {
    DEFINES += QCS_PYTHONQT
    win32:isEmpty(PYTHON_INCLUDE_DIR) {
        !no_messages:message(Python directory not specified.)
        for(dir, DEFAULT_PYTHON_INCLUDE_DIRS) {
            !no_messages:message(... searching in $${dir})
            exists($${dir}) {
                !no_messages {
                    message(PYTHON_INCLUDE_DIR set to $${dir})
                    message()
                }
                PYTHON_INCLUDE_DIR = $${dir}
                break()
            }
        }
        isEmpty(PYTHON_INCLUDE_DIR):error(A valid Python directory was not found.)
    }
    isEmpty(PYTHONQT_SRC_DIR) {
        !no_messages:message(PythonQt source directory not specified.)
        for(dir, DEFAULT_PYTHONQT_SRC_DIRS) {
            !no_messages:message(... searching in $${dir})
            exists($${dir}) {
                !no_messages {
                    message(PYTHONQT_SRC_DIR set to $${dir})
                    message()
                }
                PYTHONQT_SRC_DIR = $${dir}
                break()
            }
        }
        isEmpty(PYTHONQT_SRC_DIR):error(A valid PythonQt source directory was not found.)
    }
    isEmpty(PYTHONQT_LIB_DIR) {
        !no_messages:message(PythonQt library directory not specified. Using source directory.)
        PYTHONQT_LIB_DIR = $${PYTHONQT_SRC_DIR}/lib
    }
}
rtmidi {
isEmpty(RTMIDI_DIR) {
    !no_messages:message(RtMidi include directory not specified.)
    for(dir, DEFAULT_RTMIDI_DIRS) {
        !no_messages:message(... searching in $${dir})
        exists($${dir}) {
            !no_messages {
                message(RTMIDI_DIR set to $${dir})
                message()
            }
			RTMIDI_DIR = $${dir}
            break()
        }
    }
}
!rtmidi: message(Not building RtMidi support)
}
win32 {
    CSOUND_INCLUDE_DIR = $$replace(CSOUND_INCLUDE_DIR, \\\\, /)
    CSOUND_LIBRARY_DIR = $$replace(CSOUND_LIBRARY_DIR, \\\\, /)
    LIBSNDFILE_INCLUDE_DIR = $$replace(LIBSNDFILE_INCLUDE_DIR, \\\\, /)
    LIBSNDFILE_LIBRARY_DIR = $$replace(LIBSNDFILE_LIBRARY_DIR, \\\\, /)
}
!no_messages {
    message(Csound API include directory is $${CSOUND_API_INCLUDE_DIR})
    message(Csound interfaces include directory is $${CSOUND_INTERFACES_INCLUDE_DIR})
    message(Csound library directory is $${CSOUND_LIBRARY_DIR})
    message(libsndfile include directory is $${LIBSNDFILE_INCLUDE_DIR})
    message(libsndfile library directory is $${LIBSNDFILE_LIBRARY_DIR})
    pythonqt {
        win32:message(Python include directory is $${PYTHON_INCLUDE_DIR})
        message(PythonQt source tree directory is $${PYTHONQT_SRC_DIR})
        message(PythonQt lib directory is $${PYTHONQT_LIB_DIR})
    }
    rtmidi {
        message(RtMidi directory is $${RTMIDI_DIR})
		DEFINES += QCS_RTMIDI
    }
    message()
}
!no_checks {
    defineTest(directoryExists) {
        exists($${1}):return(true)
        return(false)
    }
    defineTest(csoundApiHeaderExists) {
        exists($${CSOUND_API_INCLUDE_DIR}/$${1}):return(true)
        return(false)
    }
    defineTest(csoundInterfacesHeaderExists) {
        exists($${CSOUND_INTERFACES_INCLUDE_DIR}/$${1}):return(true)
        return(false)
    }
    defineTest(csoundLibraryExists) {
        exists($${CSOUND_LIBRARY_DIR}/$${1}):return(true)
        return(false)
    }
    defineTest(libsndfileHeaderExists) {
        exists($${LIBSNDFILE_INCLUDE_DIR}/$${1}):return(true)
        return(false)
    }
    defineTest(libsndfileLibraryExists) {
        exists($${LIBSNDFILE_LIBRARY_DIR}/$${1}):return(true)
        return(false)
    }
    !directoryExists($${CSOUND_API_INCLUDE_DIR}):error(Csound API include directory not found)
    !directoryExists($${CSOUND_LIBRARY_DIR}):error(Csound library directory not found)
    !directoryExists($${LIBSNDFILE_INCLUDE_DIR}):error(libsndfile include directory not found)
    !directoryExists($${LIBSNDFILE_LIBRARY_DIR}):error(libsndfile library directory not found)
    pythonqt {
        win32:!directoryExists($${PYTHON_INCLUDE_DIR}):error(Python include directory not found)
		!directoryExists($${PYTHONQT_SRC_DIR}):error(PythonQt include directory not found)
		!directoryExists($${PYTHONQT_LIB_DIR}):error(PythonQt build directory not found)
    }
    !csoundApiHeaderExists(csound.h):error(csound.h not found)
    !csoundApiHeaderExists(csound.hpp):error(csound.hpp not found)
    !csoundApiHeaderExists(cwindow.h):error(cwindow.h not found)
    !csoundLibraryExists($${CSOUND_LIB}):error(Csound API library not found)
    !libsndfileHeaderExists(sndfile.h):error(sndfile.h not found)
    !libsndfileLibraryExists($${LIBSNDFILE_LIB}):error(libsndfile library not found: $${LIBSNDFILE_LIB})
}
!is_quteapp {
win32-g++ {
exists (src/res/windows/QuteApp_f.exe) :CONFIG += quteapp_f
exists (src/res/windows/QuteApp_d.exe) :CONFIG += quteapp_d
}
unix {
    macx {
# Nothing here as it's not saved in the qrc in OS X but inside the app bundle
}
    else {
exists (src/res/linux/QuteApp_f) :CONFIG += quteapp_f
exists (src/res/linux/QuteApp_d) :CONFIG += quteapp_d
!quteapp_f: message(Not bundling QuteApp_f. Please put QuteApp_f in the res/ folder)
!quteapp_d: message(Not bundling QuteApp_d. Please put QuteApp_d in the res/ folder)
}
}

}
