'''
@Description:
@Author: F.O.X
@Date: 2020-03-08 00:01:00
@LastEditor: F.O.X
LastEditTime: 2021-07-05 13:52:45
'''

from .pyqhyccd import *
from astropy.time import Time
import numpy as np


class Camera():
    def __init__(self, name):
        model, interface, num = name.split('.')
        num = int(num)
        if model != 'QHYCCD':
            raise ValueError(f"Not support model {model}.")
        InitQHYCCDResource()
        total_cam = ScanQHYCCD()
        print(f"Found {total_cam} cameras.")
        if num >= total_cam:
            raise ValueError(f"Not available cam id")
        self.camid = GetQHYCCDId(num)
        self.type, self.sn = self.camid.decode('UTF-8').split('-')
        self.lib = GetQHYCCDSDKVersion()
        self.unsaved_settings = 0
        self.starttime = 0
        self.exptime = 0

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
            self.model = GetQHYCCDModel(self.camid).decode('UTF-8')
            chipw, chiph, self.imagew, self.imageh, self.pixelw, self.pixelh, self.bpp = GetQHYCCDChipInfo(
                self.cam)
            self.gain_min, self.gain_max, self.gain_step = list(map(int, GetQHYCCDParamMinMaxStep(
                self.cam, CONTROL_ID.CONTROL_GAIN)))
            self.offset_min, self.offset_max, self.offset_step = list(map(int, GetQHYCCDParamMinMaxStep(
                self.cam, CONTROL_ID.CONTROL_OFFSET)))
            SetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_GAIN, 25)
            SetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_OFFSET, 10)
            self.n_modes = GetQHYCCDNumberOfReadModes(self.cam)
            self.mode_names = []
            for i in range(self.n_modes):
                self.mode_names.append(
                    GetQHYCCDReadModeName(self.cam, i).decode('UTF-8'))
            self.read_mode = 0
            SetQHYCCDReadMode(self.cam, self.read_mode)
            self.bin_modes = GetBinModes(self.cam)
            self.area_eff = GetQHYCCDEffectiveArea(self.cam)
            self.area_ovr = GetQHYCCDOverScanArea(self.cam)
            self.area = [0, 0, self.imagew, self.imageh]
            self.binw = 1
            self.binh = 1
            self.SetImageArea()
            if IsQHYCCDControlAvailable(self.cam, CONTROL_ID.CAM_GPS):
                SetQHYCCDParam(self.cam, CONTROL_ID.CAM_GPS, 1)
                self.has_gps = 1
            else:
                self.has_gps = 0

        elif value is False and self.Connected is True:
            CloseQHYCCD(self.cam)
        else:
            pass

    def SetImageArea(self):
        if (self.area[0] * self.binw) >= self.imagew:
            self.area[0] = (self.imagew / self.binw - 1)
        if self.area[1] * self.binh >= self.imageh:
            self.area[1] = self.imageh / self.binh - 1
        if (self.area[0] + self.area[2]) * self.binw > self.imagew:
            self.area[2] = self.imagew / self.binw
        if (self.area[1] + self.area[3]) * self.binh > self.imageh:
            self.area[3] = self.imageh / self.binh
        SetQHYCCDBinMode(self.cam, self.binw, self.binh)
        SetQHYCCDResolution(self.cam, *self.area)
        self.unsaved_settings = 0

    @property
    def BinX(self):
        return self.binw

    @BinX.setter
    def BinX(self, value):
        if value in self.bin_modes:
            self.binw = value
            self.binh = value
            self.area = [0, 0, self.imagew/self.binw, self.imageh/self.binh]
            self.unsaved_settings = 1

    @property
    def BinY(self):
        return self.binh

    @BinX.setter
    def BinY(self, value):
        if value in self.bin_modes:
            self.binw = value
            self.binh = value
            self.area = [0, 0, self.imagew/self.binw, self.imageh/self.binh]
            self.unsaved_settings = 1

    @property
    def NumX(self):
        return self.area[2]

    @NumX.setter
    def NumX(self, value):
        if value > 0:
            self.area[2] = int(value)
            self.unsaved_settings = 1

    @property
    def NumY(self):
        return self.area[3]

    @NumY.setter
    def NumY(self, value):
        if value > 0:
            self.area[3] = int(value)
            self.unsaved_settings = 1

    @property
    def StartX(self):
        return self.area[0]

    @StartX.setter
    def StartX(self, value):
        if value >= 0 and value < self.imagew:
            self.area[0] = int(value)
            self.unsaved_settings = 1

    @property
    def StartY(self):
        return self.area[1]

    @StartY.setter
    def StartY(self, value):
        if value >= 0 and value < self.imageh:
            self.area[1] = int(value)
            self.unsaved_settings = 1

    def StartExposure(self, exp, light=1):
        if self.unsaved_settings == 1:
            self.SetImageArea()
        SetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_EXPOSURE, exp * 1000000.0)
        self.exptime = exp
        ExpQHYCCDSingleFrame(self.cam)

    @property
    def CameraState(self):
        try:
            p = self.PercentCompleted
            if p == 100:
                return 0
            elif p < 100 and p > 0:
                return 2
            elif p == 0:
                return 1
            else:
                return -1
        except:
            return -1

    @property
    def CameraXSize(self):
        return self.imagew

    @property
    def CameraYSize(self):
        return self.imageh

    @property
    def CanAbortExposure(self):
        return True

    @property
    def CanAsymmetricBin(self):
        return True

    @property
    def CanFastReadout(self):
        return False

    @property
    def CanGetCoolerPower(self):
        return True

    @property
    def CanPulseGuide(self):
        return False

    @property
    def CanSetCCDTemperature(self):
        return True

    @property
    def CanStopExposure(self):
        return False

    @property
    def CCDTemperature(self):
        return GetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_CURTEMP)

    @property
    def CoolerOn(self):
        return True if self.CoolerPower > 0 else False

    @CoolerOn.setter
    def CoolerOn(self, value):
        if value:
            SetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_MANULPWM, 255)
        else:
            SetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_MANULPWM, 0)

    @property
    def CoolerPower(self):
        return GetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_CURPWM) * 100. / 255.
    
    @CoolerPower.setter
    def CoolerPower(self, value):
        if value >= 0 and value <=100:
            SetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_MANULPWM, int(value * 255. / 100.))

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
        self.image = GetQHYCCDSingleFrame(self.cam)
        if self.has_gps:
            buf = self.image[0, 0:22].tobytes(order='C')
            self.image[0, 0:22] = 0
            jd = (int.from_bytes(buf[18:22], 'big', signed=False) + int.from_bytes(
                buf[22:25], 'big', signed=False) / 10000000.) / 86400. + 2450000.5
            tm = Time(jd, format='jd').strftime("%Y-%m-%dT%H:%M:%S.%f")
            self.starttime = tm
        return self.image

    @property
    def ImageArrayVariant(self):
        self.image = GetQHYCCDSingleFrame(self.cam)
        return self.image

    @property
    def LastExposureDuration(self):
        return self.exptime

    @property
    def LastExposureStartTime(self):
        return self.starttime

    @property
    def MaxBinX(self):
        return self.bin_modes[-1]

    @property
    def MaxBinY(self):
        return self.bin_modes[-1]

    @property
    def MaxADU(self):
        return np.power(2, self.bpp) - 1

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
        return self.read_mode

    @property
    def ReadoutModes(self):
        return self.mode_names

    @ReadoutMode.setter
    def ReadoutMode(self, value):
        if value >= 0 and value < self.n_modes:
            SetQHYCCDReadMode(self.cam, value)
            self.read_mode = value

    @property
    def Gain(self):
        return int(GetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_GAIN))

    @property
    def GainMax(self):
        return self.gain_max

    @property
    def GainMin(self):
        return self.gain_min

    @property
    def Gains(self):
        return list(range(self.gain_min, self.gain_max+1, self.gain_step))

    @Gain.setter
    def Gain(self, value):
        if int(value) <= self.GainMax and int(value) >= self.GainMin:
            SetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_GAIN, int(value))

    @property
    def Offset(self):
        return int(GetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_OFFSET))

    @property
    def OffsetMax(self):
        return self.offset_max

    @property
    def OffsetMin(self):
        return self.offset_min

    @property
    def Offsets(self):
        return list(range(self.offset_min, self.offset_max+1, self.offset_step))

    @Offset.setter
    def Offset(self, value):
        if int(value) <= self.OffsetMax and int(value) >= self.OffsetMin:
            SetQHYCCDParam(self.cam, CONTROL_ID.CONTROL_OFFSET, int(value))

    @property
    def SensorType(self):
        return "CMOS"

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
