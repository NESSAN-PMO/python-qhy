import os
import sys
cimport cython
cimport qhyccd as qhy
import numpy as np
cimport numpy as np
from libc.stdint cimport uint32_t, uint8_t, uint16_t
from libc.stdlib cimport malloc, free

np.import_array()

__all__ = ['InitQHYCCDResource', 
'ReleaseQHYCCDResource', 
'ScanQHYCCD', 
'GetQHYCCDId', 
'OpenQHYCCD', 
'SetQHYCCDStreamMode', 
'InitQHYCCD', 
'CloseQHYCCD', 
'GetQHYCCDChipInfo',
'GetQHYCCDModel',
'IsQHYCCDControlAvailable',
'CONTROL_ID',
'BAYER_ID',
'SetQHYCCDParam',
'GetQHYCCDParam',
'GetQHYCCDParamMinMaxStep',
'ExpQHYCCDSingleFrame',
'GetQHYCCDSingleFrame',
'CancelQHYCCDExposing',
'GetQHYCCDMemLength',
'SetQHYCCDBinMode',
'SetQHYCCDResolution',
'GetQHYCCDExposureRemaining',
'GetQHYCCDType',
'GetQHYCCDSDKVersion',
'CancelQHYCCDExposingAndReadout',
'GetQHYCCDNumberOfReadModes',
'GetQHYCCDReadModeResolution',
'GetQHYCCDReadModeName',
'SetQHYCCDReadMode',
'GetQHYCCDReadMode',
'GetQHYCCDEffectiveArea',
'GetQHYCCDOverScanArea',
'SetQHYCCDBinMode',
'BeginQHYCCDLive',
'StopQHYCCDLive',
'GetQHYCCDLiveFrame',
'GetQHYCCDPreciseExposureInfo',
'SetQHYCCDBitsMode',
'GetBinModes',
'SetQHYCCDDebayerOnOff'
]

cdef extern from "Python.h":
    void *PyLong_AsVoidPtr(object)
    object PyLong_FromVoidPtr(void *)

class CONTROL_ID:
    CONTROL_BRIGHTNESS=qhy.CONTROL_BRIGHTNESS
    CONTROL_CONTRAST=qhy.CONTROL_CONTRAST
    CONTROL_WBR=qhy.CONTROL_WBR
    CONTROL_WBB=qhy.CONTROL_WBB
    CONTROL_WBG=qhy.CONTROL_WBG
    CONTROL_GAMMA=qhy.CONTROL_GAMMA
    CONTROL_GAIN=qhy.CONTROL_GAIN
    CONTROL_OFFSET=qhy.CONTROL_OFFSET
    CONTROL_EXPOSURE=qhy.CONTROL_EXPOSURE
    CONTROL_SPEED=qhy.CONTROL_SPEED
    CONTROL_TRANSFERBIT=qhy.CONTROL_TRANSFERBIT
    CONTROL_CHANNELS=qhy.CONTROL_CHANNELS
    CONTROL_USBTRAFFIC=qhy.CONTROL_USBTRAFFIC
    CONTROL_ROWNOISERE=qhy.CONTROL_ROWNOISERE
    CONTROL_CURTEMP=qhy.CONTROL_CURTEMP
    CONTROL_CURPWM=qhy.CONTROL_CURPWM
    CONTROL_MANULPWM=qhy.CONTROL_MANULPWM
    CONTROL_CFWPORT=qhy.CONTROL_CFWPORT
    CONTROL_COOLER=qhy.CONTROL_COOLER
    CONTROL_ST4PORT=qhy.CONTROL_ST4PORT
    CAM_COLOR=qhy.CAM_COLOR
    CAM_BIN1X1MODE=qhy.CAM_BIN1X1MODE
    CAM_BIN2X2MODE=qhy.CAM_BIN2X2MODE
    CAM_BIN3X3MODE=qhy.CAM_BIN3X3MODE
    CAM_BIN4X4MODE=qhy.CAM_BIN4X4MODE
    CAM_MECHANICALSHUTTER=qhy.CAM_MECHANICALSHUTTER
    CAM_TRIGER_INTERFACE=qhy.CAM_TRIGER_INTERFACE
    CAM_TECOVERPROTECT_INTERFACE=qhy.CAM_TECOVERPROTECT_INTERFACE
    CAM_SINGNALCLAMP_INTERFACE=qhy.CAM_SINGNALCLAMP_INTERFACE
    CAM_FINETONE_INTERFACE=qhy.CAM_FINETONE_INTERFACE
    CAM_SHUTTERMOTORHEATING_INTERFACE=qhy.CAM_SHUTTERMOTORHEATING_INTERFACE
    CAM_CALIBRATEFPN_INTERFACE=qhy.CAM_CALIBRATEFPN_INTERFACE
    CAM_CHIPTEMPERATURESENSOR_INTERFACE=qhy.CAM_CHIPTEMPERATURESENSOR_INTERFACE
    CAM_USBREADOUTSLOWEST_INTERFACE=qhy.CAM_USBREADOUTSLOWEST_INTERFACE
    CAM_8BITS=qhy.CAM_8BITS
    CAM_16BITS=qhy.CAM_16BITS
    CAM_GPS=qhy.CAM_GPS
    CAM_IGNOREOVERSCAN_INTERFACE=qhy.CAM_IGNOREOVERSCAN_INTERFACE
    QHYCCD_3A_AUTOBALANCE=qhy.QHYCCD_3A_AUTOBALANCE
    QHYCCD_3A_AUTOEXPOSURE=qhy.QHYCCD_3A_AUTOEXPOSURE
    QHYCCD_3A_AUTOFOCUS=qhy.QHYCCD_3A_AUTOFOCUS
    CONTROL_AMPV=qhy.CONTROL_AMPV
    CONTROL_VCAM=qhy.CONTROL_VCAM
    CAM_VIEW_MODE=qhy.CAM_VIEW_MODE
    CONTROL_CFWSLOTSNUM=qhy.CONTROL_CFWSLOTSNUM
    IS_EXPOSING_DONE=qhy.IS_EXPOSING_DONE
    ScreenStretchB=qhy.ScreenStretchB
    ScreenStretchW=qhy.ScreenStretchW
    CONTROL_DDR=qhy.CONTROL_DDR
    CAM_LIGHT_PERFORMANCE_MODE=qhy.CAM_LIGHT_PERFORMANCE_MODE
    CAM_QHY5II_GUIDE_MODE=qhy.CAM_QHY5II_GUIDE_MODE
    DDR_BUFFER_CAPACITY=qhy.DDR_BUFFER_CAPACITY
    DDR_BUFFER_READ_THRESHOLD=qhy.DDR_BUFFER_READ_THRESHOLD
    DefaultGain=qhy.DefaultGain
    DefaultOffset=qhy.DefaultOffset
    OutputDataActualBits=qhy.OutputDataActualBits
    OutputDataAlignment=qhy.OutputDataAlignment
    CAM_SINGLEFRAMEMODE=qhy.CAM_SINGLEFRAMEMODE
    CAM_LIVEVIDEOMODE=qhy.CAM_LIVEVIDEOMODE
    CAM_IS_COLOR=qhy.CAM_IS_COLOR
    hasHardwareFrameCounter=qhy.hasHardwareFrameCounter
    CONTROL_MAX_ID_Error=qhy.CONTROL_MAX_ID_Error
    CAM_HUMIDITY=qhy.CAM_HUMIDITY
    CAM_PRESSURE=qhy.CAM_PRESSURE
    CONTROL_VACUUM_PUMP=qhy.CONTROL_VACUUM_PUMP
    CONTROL_SensorChamberCycle_PUMP=qhy.CONTROL_SensorChamberCycle_PUMP
    CONTROL_MAX_ID=qhy.CONTROL_MAX_ID

class BAYER_ID:
    BAYER_GB = qhy.BAYER_GB
    BAYER_GR = qhy.BAYER_GR
    BAYER_BG = qhy.BAYER_BG
    BAYER_RG = qhy.BAYER_RG

cdef int chkerr(long err):
    if err != qhy.QHYCCD_SUCCESS:
        print("error: ", err)
        #raise OSError(-err, os.strerror(-err))


def InitQHYCCDResource():
    chkerr(qhy.InitQHYCCDResource())

def ReleaseQHYCCDResource():
    chkerr(qhy.ReleaseQHYCCDResource())

def ScanQHYCCD():
    return(qhy.ScanQHYCCD())

def GetQHYCCDId(i):
    cdef char camid[256]
    chkerr(qhy.GetQHYCCDId(i, camid))
    return camid

def OpenQHYCCD(camid):
    return PyLong_FromVoidPtr(qhy.OpenQHYCCD(<char *>camid))

def SetQHYCCDStreamMode(cam, mode):
    chkerr(qhy.SetQHYCCDStreamMode(PyLong_AsVoidPtr(cam), mode))

def InitQHYCCD(cam):
    chkerr(qhy.InitQHYCCD(PyLong_AsVoidPtr(cam)))

def CloseQHYCCD(cam):
    chkerr(qhy.CloseQHYCCD(PyLong_AsVoidPtr(cam)))

def GetQHYCCDChipInfo(cam):
    cdef double chipw, chiph, pixelw, pixelh
    cdef uint32_t imagew, imageh, bpp
    chkerr(qhy.GetQHYCCDChipInfo(PyLong_AsVoidPtr(cam), &chipw, &chiph, &imagew, &imageh, &pixelw, &pixelh, &bpp))
    return (chipw, chiph, imagew, imageh, pixelw, pixelh, bpp)

def GetQHYCCDModel(camid):
    cdef char cammodel[256]
    chkerr(qhy.GetQHYCCDModel(camid, cammodel))
    return cammodel

def IsQHYCCDControlAvailable(cam, controlId):
    ret = qhy.IsQHYCCDControlAvailable(PyLong_AsVoidPtr(cam), controlId)
    if ret == qhy.QHYCCD_SUCCESS:
        return True
    elif ret == qhy.QHYCCD_ERROR:
        return False
    else:
        return ret

def GetQHYCCDParam(cam, controlId):
    ret = qhy.GetQHYCCDParam(PyLong_AsVoidPtr(cam), controlId)
    if ret != qhy.QHYCCD_ERROR:
        return ret
    else:
        return None

def SetQHYCCDParam(cam, controlId, value):
    chkerr(qhy.SetQHYCCDParam(PyLong_AsVoidPtr(cam), controlId, value))

def GetQHYCCDParamMinMaxStep(cam, controlId):
    cdef double pmin, pmax, pstep 
    chkerr(qhy.GetQHYCCDParamMinMaxStep(PyLong_AsVoidPtr(cam), controlId, &pmin, &pmax, &pstep))
    return (pmin, pmax, pstep)

def ExpQHYCCDSingleFrame(cam):
    chkerr(qhy.ExpQHYCCDSingleFrame(PyLong_AsVoidPtr(cam)))

def CancelQHYCCDExposing(cam):
    chkerr(qhy.CancelQHYCCDExposing(PyLong_AsVoidPtr(cam)))

def CancelQHYCCDExposingAndReadout(cam):
    chkerr(qhy.CancelQHYCCDExposingAndReadout(PyLong_AsVoidPtr(cam)))

def GetQHYCCDSingleFrame(cam):
    cdef uint32_t w, h, bpp, channels
    cdef uint8_t *imgdata
    cdef uint32_t memlength
    memlength = qhy.GetQHYCCDMemLength(PyLong_AsVoidPtr(cam))*2
    imgdata = <uint8_t *>malloc(memlength * sizeof(uint8_t))
    while 1:
        ret = qhy.GetQHYCCDSingleFrame(PyLong_AsVoidPtr(cam), &w, &h, &bpp, &channels, imgdata)
        if ret == -1:
            return False
        elif ret == qhy.QHYCCD_SUCCESS:
            break
        else:
            continue
    if bpp == 8:
        np_bpp = np.NPY_UINT8
    elif bpp == 16:
        np_bpp = np.NPY_UINT16 
    elif bpp == 32:
        np_bpp = np.NPY_INT32
    else:
        np_bpp = np.NPY_UINT16
    cdef np.npy_intp shape[3]
    shape[0] = <np.npy_intp> h
    shape[1] = <np.npy_intp> w
    shape[2] = <np.npy_intp> channels
    data = np.PyArray_SimpleNewFromData(3, shape, np_bpp, <void *>imgdata)
    np.PyArray_ENABLEFLAGS(data, np.NPY_ARRAY_OWNDATA)
    return data

def GetQHYCCDMemLength(cam):
    return qhy.GetQHYCCDMemLength(PyLong_AsVoidPtr(cam))

def SetQHYCCDBinMode(cam, wbin, hbin):
    chkerr(qhy.SetQHYCCDBinMode(PyLong_AsVoidPtr(cam), <uint32_t> wbin, <uint32_t> hbin))

def SetQHYCCDResolution(cam, x, y, xsize, ysize):
    chkerr(qhy.SetQHYCCDResolution(PyLong_AsVoidPtr(cam), <uint32_t> x, <uint32_t> y, <uint32_t> xsize, <uint32_t> ysize))

def GetQHYCCDExposureRemaining(cam):
    return(qhy.GetQHYCCDExposureRemaining(PyLong_AsVoidPtr(cam)))

def GetQHYCCDType(cam):
    ret = qhy.GetQHYCCDType(PyLong_AsVoidPtr(cam))
    if ret != qhy.QHYCCD_ERROR:
        return ret
    else:
        raise OSError(-ret, os.stderror(-ret))
    
def GetQHYCCDSDKVersion():
    cdef uint32_t year, month, day, subday
    chkerr(qhy.GetQHYCCDSDKVersion(&year, &month, &day, &subday))
    return f"QHYCCD SDK {year}-{month}-{day},{subday}"

def GetQHYCCDNumberOfReadModes(cam):
    cdef uint32_t numModes
    chkerr(qhy.GetQHYCCDNumberOfReadModes(PyLong_AsVoidPtr(cam), &numModes))
    return numModes

def GetQHYCCDReadModeResolution(cam, modeNumber):
    cdef uint32_t width, height
    chkerr(qhy.GetQHYCCDReadModeResolution(PyLong_AsVoidPtr(cam), <uint32_t> modeNumber, &width, &height))
    return (width, height)

def GetQHYCCDReadModeName(cam, modeNumber):
    cdef char name[32]
    chkerr(qhy.GetQHYCCDReadModeName(PyLong_AsVoidPtr(cam), <uint32_t> modeNumber, name))
    return name

def GetQHYCCDReadMode(cam):
    cdef uint32_t modeNumber
    chkerr(qhy.GetQHYCCDReadMode(PyLong_AsVoidPtr(cam), &modeNumber))
    return modeNumber

def SetQHYCCDReadMode(cam, modeNumber):
    chkerr(qhy.SetQHYCCDReadMode(PyLong_AsVoidPtr(cam), <uint32_t> modeNumber))

def GetQHYCCDOverScanArea(cam):
    cdef uint32_t startX, startY, sizeX, sizeY
    chkerr(qhy.GetQHYCCDOverScanArea(PyLong_AsVoidPtr(cam), &startX, &startY, &sizeX, &sizeY))
    return (startX, startY, sizeX, sizeY)

def GetQHYCCDEffectiveArea(cam):
    cdef uint32_t startX, startY, sizeX, sizeY
    chkerr(qhy.GetQHYCCDEffectiveArea(PyLong_AsVoidPtr(cam), &startX, &startY, &sizeX, &sizeY))
    return (startX, startY, sizeX, sizeY)

def SetQHYCCDBinMode(cam, binw, binh):
    chkerr(qhy.SetQHYCCDBinMode(PyLong_AsVoidPtr(cam), binw, binh))

def BeginQHYCCDLive(cam):
    chkerr(qhy.BeginQHYCCDLive(PyLong_AsVoidPtr(cam)))

def StopQHYCCDLive(cam):
    chkerr(qhy.StopQHYCCDLive(PyLong_AsVoidPtr(cam)))

def GetQHYCCDLiveFrame(cam):
    cdef uint32_t w, h, bpp, channels
    cdef uint8_t *imgdata
    cdef uint32_t memlength
    memlength = qhy.GetQHYCCDMemLength(PyLong_AsVoidPtr(cam))*2
    imgdata = <uint8_t *>malloc(memlength * sizeof(uint8_t))
    ret = qhy.QHYCCD_ERROR
    while(ret == qhy.QHYCCD_ERROR):
        ret = qhy.GetQHYCCDLiveFrame(PyLong_AsVoidPtr(cam), &w, &h, &bpp, &channels, imgdata)
    if bpp == 8:
        np_bpp = np.NPY_UINT8
    elif bpp == 16:
        np_bpp = np.NPY_UINT16 
    elif bpp == 32:
        np_bpp = np.NPY_INT32
    else:
        np_bpp = np.NPY_UINT16
    cdef np.npy_intp shape[3]
    shape[0] = <np.npy_intp> h
    shape[1] = <np.npy_intp> w
    shape[2] = <np.npy_intp> channels
    data = np.PyArray_SimpleNewFromData(3, shape, np_bpp, <void *>imgdata)
    np.PyArray_ENABLEFLAGS(data, np.NPY_ARRAY_OWNDATA)
    return data

def GetQHYCCDPreciseExposureInfo(cam):
    cdef uint32_t PixelPeriod_ps, LinePeriod_ns, FramePeriod_us, ClocksPerLine, LinesPerFrame, ActualExposureTime
    cdef uint8_t isLongExposureMode
    qhy.GetQHYCCDPreciseExposureInfo(PyLong_AsVoidPtr(cam), 
                                            &PixelPeriod_ps, 
                                            &LinePeriod_ns, 
                                            &FramePeriod_us, 
                                            &ClocksPerLine, 
                                            &LinesPerFrame, 
                                            &ActualExposureTime, 
                                            &isLongExposureMode)
    return (PixelPeriod_ps, LinePeriod_ns, FramePeriod_us, ClocksPerLine, LinesPerFrame, ActualExposureTime, isLongExposureMode)

def SetQHYCCDBitsMode(cam, value):
    chkerr(qhy.SetQHYCCDBitsMode(PyLong_AsVoidPtr(cam), <uint32_t> value))
    
def GetBinModes(cam):
    modes = [1]
    if qhy.IsQHYCCDControlAvailable(PyLong_AsVoidPtr(cam), CONTROL_ID.CAM_BIN2X2MODE) == qhy.QHYCCD_SUCCESS:
        modes.append(2)
    if qhy.IsQHYCCDControlAvailable(PyLong_AsVoidPtr(cam), CONTROL_ID.CAM_BIN3X3MODE) == qhy.QHYCCD_SUCCESS:
        modes.append(3)
    if qhy.IsQHYCCDControlAvailable(PyLong_AsVoidPtr(cam), CONTROL_ID.CAM_BIN4X4MODE) == qhy.QHYCCD_SUCCESS:
        modes.append(4)
    return modes

def SetQHYCCDDebayerOnOff(cam, onoff):
    chkerr(qhy.SetQHYCCDDebayerOnOff(PyLong_AsVoidPtr(cam), onoff))
