'''
@Description:
@Author: F.O.X
@Date: 2020-03-08 00:01:00
@LastEditor: F.O.X
LastEditTime: 2021-03-12 00:55:57
'''

from .pyqhyccd import *
import time
from astropy.io import fits


class Camera():
    def __init__(self, name):
        model, interface, num = name.split('.')
        num = int(num)
        if model != 'QHY':
            raise NameError(f"Not support model {model}")
        InitQHYCCDResource()
        total_cam = ScanQHYCCD()
        print(f"Found {total_cam} cameras.")
        if num >= total_cam:
            pass
        self.camid = GetQHYCCDId(num)
        self.lib = GetQHYCCDSDKVersion()

    def __del__(self):
        try:
            CloseQHYCCD(self.cam)
        except:
            pass
        ReleaseQHYCCDResource()

    @property
    def Connected(self):
        try:
            GetQHYCCDType(self.cam)
            return True
        except:
            return False

    @Connected.setter
    def Connected(self, value):
        if value is True and self.Connected is False:
            self.cam = OpenQHYCCD(self.camid)
            SetQHYCCDStreamMode(self.cam, 0)
            InitQHYCCD(self.cam)
            self.model = GetQHYCCDModel(self.camid)
            chipw, chiph, self.imagew, self.imageh, self.pixelw, self.pixelh, bpp = GetQHYCCDChipInfo(
                self.cam)
            SetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_GAIN, 60)
            SetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_OFFSET, 76)
            self.n_modes = GetQHYCCDNumberOfReadModes(self.cam)
            self.mode_names = []
            for i in range(self.n_modes):
                self.mode_names.append(GetQHYCCDReadModeName(self.cam, i))
            SetQHYCCDResolution(self.cam, 0, 0, self.imagew, self.imageh)
            print(GetQHYCCDEffectiveArea(self.cam))
            print(GetQHYCCDOverScanArea(self.cam))

#             ul_x, ul_y, lr_x, lr_y = getVisibleArea(
#                 self.cam)
#             self.sizex = lr_x - ul_x
#             self.sizey = lr_y - ul_y
#             self.offsetx = ul_x
#             self.offsety = ul_y
#             aul_x, aul_y, alr_x, alr_y = getArrayArea(
#                 self.cam)
#             self.sizeax = alr_x - aul_x
#             self.sizeay = alr_y - aul_y

#             self.startx = 0
#             self.starty = 0
#             self.numx = self.sizex
#             self.numy = self.sizey
#             self.binx = 1
#             self.biny = 1
#             self.SetImageArea()

#             self.psx, self.psy = getPixelSize(self.cam)
#             n = 0
#             modes = []
#             while 1:
#                 try:
#                     modes.append(getCameraModeString(self.cam, n))
#                     n += 1
#                 except:
#                     break
#             self.modes = tuple(modes)
#             self.model = getModel(self.cam)
#             self.sn = getSerialString(self.cam)
#             self.lib = getLibVersion()
#             self.fw = getFWRevision(self.cam)
#             self.hw = getHWRevision(self.cam)

        elif value is False and self.Connected is True:
            CloseQHYCCD(self.cam)
        else:
            pass

#     def SetImageArea(self):
#         if (self.numx + self.startx) * self.binx >= self.sizex:
#             self.numx = int(self.sizex / self.binx - self.startx)
#         if (self.numy + self.starty) * self.biny >= self.sizey:
#             self.numy = int(self.sizey / self.biny - self.starty)
#         setImageArea(self.cam, self.startx + self.offsetx / self.binx,
#                      self.starty + self.offsety / self.biny,
#                      self.startx + self.numx + self.offsetx / self.binx,
#                      self.starty + self.numy + self.offsety / self.biny)

#     @property
#     def BinX(self):
#         return getReadoutDimensions(self.cam)[2]

#     @BinX.setter
#     def BinX(self, value):
#         if value <= 16 and value >= 1:
#             setHBin(self.cam, value)
#             self.binx = int(value)
#             self.SetImageArea()

#     @property
#     def BinY(self):
#         return getReadoutDimensions(self.cam)[5]

#     @BinX.setter
#     def BinY(self, value):
#         if value <= 16 and value >= 1:
#             setVBin(self.cam, value)
#             self.biny = int(value)
#             self.SetImageArea()

#     @property
#     def NumX(self):
#         return getReadoutDimensions(self.cam)[0]

#     @NumX.setter
#     def NumX(self, value):
#         if value > 0:
#             self.numx = int(value)
#             self.SetImageArea()
#         else:
#             raise ValueError("Invalid value")

#     @property
#     def NumY(self):
#         return getReadoutDimensions(self.cam)[3]

#     @NumY.setter
#     def NumY(self, value):
#         if value > 0:
#             self.numy = int(value)
#             self.SetImageArea()
#         else:
#             raise ValueError("Invalid value")

#     @property
#     def StartX(self):
#         return getReadoutDimensions(self.cam)[1] - self.offsetx

#     @StartX.setter
#     def StartX(self, value):
#         if value >= 0 and value < self.sizex:
#             self.startx = int(value)
#             self.SetImageArea()

#     @property
#     def StartY(self):
#         return getReadoutDimensions(self.cam)[4] - self.offsety

#     @StartY.setter
#     def StartY(self, value):
#         if value >= 0 and value < self.sizey:
#             self.starty = int(value)
#             self.SetImageArea()

    def StartExposure(self, exp, light=1):
        SetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_EXPOSURE, exp * 1000000.0)
        self.exptime = exp * 1000000.0
        ExpQHYCCDSingleFrame(self.cam)

#     @property
#     def CameraState(self):
#         s = getDeviceStatus(self.cam)
#         if s == CAMERA_STATUS_UNKNOWN:
#             return 5
#         elif s & 0x03 == 0x00:
#             return 0
#         elif s & 0x03 == 0x01:
#             return 1
#         elif s & 0x03 == 0x02:
#             return 2
#         elif s & 0x03 == 0x03:
#             return 3

    @property
    def CameraXSize(self):
        return self.imagew

    @property
    def CameraYSize(self):
        return self.imageh

#     @property
#     def CanAbortExposure(self):
#         return True

#     @property
#     def CanAsymmetricBin(self):
#         return True

#     @property
#     def CanFastReadout(self):
#         return False

#     @property
#     def CanGetCoolerPower(self):
#         return True

#     @property
#     def CanPulseGuide(self):
#         return False

#     @property
#     def CanSetCCDTemperature(self):
#         return True

#     @property
#     def CanStopExposure(self):
#         return False

    @property
    def CCDTemperature(self):
        return GetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_CURTEMP)

    @property
    def CoolerOn(self):
        return True if self.CoolerPower > 0 else False

    @CoolerOn.setter
    def CoolerOn(self, value):
        if value:
            SetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_MANULPWM, 50)
        else:
            SetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_MANULPWM, 0)

    @property
    def CoolerPower(self):
        return GetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_CURPWM) * 100. / 255.

    @property
    def HeatSinkTemperature(self):
        return GetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_CURTEMP)

    @property
    def ImageReady(self):
        if GetQHYCCDExposureRemaining(self.cam) > 0:
            return False
        else:
            return True

    @property
    def ImageArray(self):
        return GetQHYCCDSingleFrame(self.cam)

    @property
    def ImageArrayVariant(self):
        return GetQHYCCDSingleFrame(self.cam)

#     @property
#     def LastExposureDuration(self):
#         return 0

#     @property
#     def LastExposureStartTime(self):
#         return 0

#     @property
#     def MaxBinX(self):
#         return 16

#     @property
#     def MaxBinY(self):
#         return 16

#     @property
#     def MaxADU(self):
#         return 65535

    @property
    def PercentCompleted(self):
        return (100 - GetQHYCCDExposureRemaining(self.cam))

    @property
    def PixelSizeX(self):
        return self.pixelw

    @property
    def PixelSizeY(self):
        return self.pixelh

    @property
    def ReadoutMode(self):
        return GetQHYCCDReadMode(self.cam)

    @property
    def ReadoutModes(self):
        return self.mode_names

    @ReadoutMode.setter
    def ReadoutMode(self, value):
        if value >= 0 and value < self.n_modes:
            GetQHYCCDReadMode(self.cam, value)

    @property
    def SensorType(self):
        return

    @property
    def SetCCDTemperature(self):
        return GetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_COOLER)

    @SetCCDTemperature.setter
    def SetCCDTemperature(self, value):
        if value < 45 and value > -55:
            SetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_COOLER, value)
        else:
            raise ValueError("Invalid value")

    def AbortExposure(self):
        CancelQHYCCDExposing(self.cam)

    def StopExposure(self):
        CancelQHYCCDExposingAndReadout(self.cam)

    @property
    def SensorName(self):
        return self.type

    @property
    def Name(self):
        return self.model

    @property
    def Description(self):
        return f"{self.model}"

    @property
    def DriverVersion(self):
        return self.lib.split()[-1]

    @property
    def InterfaceVersion(self):
        return "3"

    @property
    def DriverInfo(self):
        return self.lib
