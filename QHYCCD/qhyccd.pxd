from libc.stdint cimport uint32_t, uint8_t#, uint64_t, uint16_t, int32_t
from libcpp cimport bool
# from libc.stddef cimport wchar_t

cdef extern from 'qhyccderr.h':
    cdef enum:
        QHYCCD_SUCCESS
        QHYCCD_ERROR
        QHYCCD_NOTCOOL
        QHYCCD_COOL
        QHYCCD_MONO
        QHYCCD_COLOR
        QHYCCD_USBASYNC
        QHYCCD_USBSYNC
        QHYCCD_QGIGAE
        QHYCCD_WINPCAP
        QHYCCD_PCIE
        QHYCCD_DELAY_200MS
        QHYCCD_READ_DIRECTLY

cdef extern from 'qhyccdstruct.h':
    ctypedef enum BAYER_ID:
        BAYER_GB
        BAYER_GR
        BAYER_BG
        BAYER_RG
        
cdef extern from 'qhyccdstruct.h':
    ctypedef enum CONTROL_ID:
        CONTROL_BRIGHTNESS
        CONTROL_CONTRAST
        CONTROL_WBR
        CONTROL_WBB
        CONTROL_WBG
        CONTROL_GAMMA
        CONTROL_GAIN
        CONTROL_OFFSET
        CONTROL_EXPOSURE
        CONTROL_SPEED
        CONTROL_TRANSFERBIT
        CONTROL_CHANNELS
        CONTROL_USBTRAFFIC
        CONTROL_ROWNOISERE
        CONTROL_CURTEMP
        CONTROL_CURPWM
        CONTROL_MANULPWM
        CONTROL_CFWPORT
        CONTROL_COOLER
        CONTROL_ST4PORT
        CAM_COLOR
        CAM_BIN1X1MODE
        CAM_BIN2X2MODE
        CAM_BIN3X3MODE
        CAM_BIN4X4MODE
        CAM_MECHANICALSHUTTER
        CAM_TRIGER_INTERFACE
        CAM_TECOVERPROTECT_INTERFACE
        CAM_SINGNALCLAMP_INTERFACE
        CAM_FINETONE_INTERFACE
        CAM_SHUTTERMOTORHEATING_INTERFACE
        CAM_CALIBRATEFPN_INTERFACE
        CAM_CHIPTEMPERATURESENSOR_INTERFACE
        CAM_USBREADOUTSLOWEST_INTERFACE
        CAM_8BITS
        CAM_16BITS
        CAM_GPS
        CAM_IGNOREOVERSCAN_INTERFACE
        QHYCCD_3A_AUTOBALANCE
        QHYCCD_3A_AUTOEXPOSURE
        QHYCCD_3A_AUTOFOCUS
        CONTROL_AMPV
        CONTROL_VCAM
        CAM_VIEW_MODE
        CONTROL_CFWSLOTSNUM
        IS_EXPOSING_DONE
        ScreenStretchB
        ScreenStretchW
        CONTROL_DDR
        CAM_LIGHT_PERFORMANCE_MODE
        CAM_QHY5II_GUIDE_MODE
        DDR_BUFFER_CAPACITY
        DDR_BUFFER_READ_THRESHOLD
        DefaultGain
        DefaultOffset
        OutputDataActualBits
        OutputDataAlignment
        CAM_SINGLEFRAMEMODE
        CAM_LIVEVIDEOMODE
        CAM_IS_COLOR
        hasHardwareFrameCounter
        CONTROL_MAX_ID_Error
        CAM_HUMIDITY
        CAM_PRESSURE
        CONTROL_VACUUM_PUMP
        CONTROL_SensorChamberCycle_PUMP
        CONTROL_MAX_ID

cdef extern from 'qhyccd.h':

    ctypedef void qhyccd_handle
    uint32_t InitQHYCCDResource() nogil
    uint32_t ReleaseQHYCCDResource() nogil
    uint32_t ScanQHYCCD() nogil
    uint32_t GetQHYCCDId(uint32_t index,char *id) nogil
    qhyccd_handle * OpenQHYCCD(char *id) nogil
    uint32_t SetQHYCCDStreamMode(qhyccd_handle *handle,uint8_t mode) nogil
    uint32_t InitQHYCCD(qhyccd_handle *handle) nogil
    uint32_t CloseQHYCCD(qhyccd_handle *handle) nogil
    uint32_t GetQHYCCDChipInfo(qhyccd_handle *h,double *chipw,double *chiph,uint32_t *imagew,uint32_t *imageh,double *pixelw,double *pixelh,uint32_t *bpp) nogil
    uint32_t GetQHYCCDModel(char *id, char *model) nogil
    uint32_t IsQHYCCDControlAvailable(qhyccd_handle *handle,CONTROL_ID controlId) nogil
    uint32_t SetQHYCCDParam(qhyccd_handle *handle,CONTROL_ID controlId, double value) nogil
    double GetQHYCCDParam(qhyccd_handle *handle,CONTROL_ID controlId) nogil
    uint32_t GetQHYCCDParamMinMaxStep(qhyccd_handle *handle,CONTROL_ID controlId,double *min,double *max,double *step) nogil
    uint32_t ExpQHYCCDSingleFrame(qhyccd_handle *handle) nogil
    uint32_t GetQHYCCDSingleFrame(qhyccd_handle *handle,uint32_t *w,uint32_t *h,uint32_t *bpp,uint32_t *channels,uint8_t *imgdata) nogil
    uint32_t CancelQHYCCDExposing(qhyccd_handle *handle) nogil
    uint32_t GetQHYCCDMemLength(qhyccd_handle *handle) nogil
    uint32_t SetQHYCCDResolution(qhyccd_handle *handle,uint32_t x,uint32_t y,uint32_t xsize,uint32_t ysize) nogil
    uint32_t SetQHYCCDSingleFrameTimeOut(qhyccd_handle *h,uint32_t time) nogil
    uint32_t GetQHYCCDExposureRemaining(qhyccd_handle *h) nogil
    uint32_t GetQHYCCDType(qhyccd_handle *h) nogil
    uint32_t GetQHYCCDSDKVersion(uint32_t *year,uint32_t *month,uint32_t *day,uint32_t *subday) nogil
    uint32_t CancelQHYCCDExposingAndReadout(qhyccd_handle *handle) nogil
    uint32_t GetQHYCCDNumberOfReadModes(qhyccd_handle *h,uint32_t *numModes) nogil
    uint32_t GetQHYCCDReadModeResolution(qhyccd_handle *h,uint32_t modeNumber, uint32_t* width, uint32_t* height) nogil
    uint32_t GetQHYCCDReadModeName(qhyccd_handle *h,uint32_t modeNumber, char* name) nogil
    uint32_t SetQHYCCDReadMode(qhyccd_handle *h,uint32_t modeNumber) nogil
    uint32_t GetQHYCCDReadMode(qhyccd_handle *h,uint32_t* modeNumber) nogil
    uint32_t GetQHYCCDEffectiveArea(qhyccd_handle *h,uint32_t *startX, uint32_t *startY, uint32_t *sizeX, uint32_t *sizeY) nogil
    uint32_t GetQHYCCDOverScanArea(qhyccd_handle *h,uint32_t *startX, uint32_t *startY, uint32_t *sizeX, uint32_t *sizeY) nogil
    uint32_t SetQHYCCDBinMode(qhyccd_handle *handle,uint32_t wbin,uint32_t hbin) nogil
    uint32_t BeginQHYCCDLive(qhyccd_handle *handle) nogil
    uint32_t GetQHYCCDLiveFrame(qhyccd_handle *handle,uint32_t *w,uint32_t *h,uint32_t *bpp,uint32_t *channels,uint8_t *imgdata) nogil
    uint32_t StopQHYCCDLive(qhyccd_handle *handle) nogil
    uint32_t GetQHYCCDPreciseExposureInfo(qhyccd_handle *h, uint32_t *PixelPeriod_ps, uint32_t *LinePeriod_ns, uint32_t *FramePeriod_us, uint32_t *ClocksPerLine, uint32_t *LinesPerFrame, uint32_t *ActualExposureTime, uint8_t *isLongExposureMode) nogil
    uint32_t SetQHYCCDBitsMode(qhyccd_handle *handle,uint32_t bits) nogil
    uint32_t SetQHYCCDDebayerOnOff(qhyccd_handle *h, bool onoff) nogil

    # void SetQHYCCDAutoDetectCamera(bool enable)

    # void SetQHYCCDLogLevel(uint8_t logLevel)

    # void EnableQHYCCDMessage(bool enable)
    
    # void EnableQHYCCDLogFile(bool enable)

    # const char* GetTimeStamp()

    # uint32_t GetQHYCCDCameraStatus(qhyccd_handle *h,uint8_t *buf) nogil




    # uint32_t ControlQHYCCDTemp(qhyccd_handle *handle,double targettemp)

    # uint32_t ControlQHYCCDGuide(qhyccd_handle *handle,uint32_t direction,uint16_t duration)

    # uint32_t SendOrder2QHYCCDCFW(qhyccd_handle *handle,char *order,uint32_t length)

    # uint32_t GetQHYCCDCFWStatus(qhyccd_handle *handle,char *status)

    # uint32_t IsQHYCCDCFWPlugged(qhyccd_handle *handle)

    # uint32_t SetQHYCCDTrigerMode(qhyccd_handle *handle,uint32_t trigerMode)

    # void Bits16ToBits8(qhyccd_handle *h,uint8_t *InputData16,uint8_t *OutputData8,uint32_t imageX,uint32_t imageY,uint16_t B,uint16_t W)

    # void  HistInfo192x130(qhyccd_handle *h,uint32_t x,uint32_t y,uint8_t *InBuf,uint8_t *OutBuf)

    # uint32_t OSXInitQHYCCDFirmware(char *path)

    # uint32_t OSXInitQHYCCDFirmwareArray()

    # uint32_t OSXInitQHYCCDAndroidFirmwareArray(int idVendor,int idProduct, qhyccd_handle *handle)

    # uint32_t SetQHYCCDFocusSetting(qhyccd_handle *h,uint32_t focusCenterX, uint32_t focusCenterY)


    # uint32_t GetQHYCCDFWVersion(qhyccd_handle *h,uint8_t *buf)

    # uint32_t GetQHYCCDFPGAVersion(qhyccd_handle *h, uint8_t fpga_index, uint8_t *buf)

    # uint32_t SetQHYCCDInterCamSerialParam(qhyccd_handle *h,uint32_t opt)

    # uint32_t QHYCCDInterCamSerialTX(qhyccd_handle *h,char *buf,uint32_t length)

    # uint32_t QHYCCDInterCamSerialRX(qhyccd_handle *h,char *buf)

    # uint32_t QHYCCDInterCamOledOnOff(qhyccd_handle *handle,uint8_t onoff)

    # uint32_t SetQHYCCDInterCamOledBrightness(qhyccd_handle *handle,uint8_t brightness)

    # uint32_t SendFourLine2QHYCCDInterCamOled(qhyccd_handle *handle,char *messagetemp,char *messageinfo,char *messagetime,char *messagemode)

    # uint32_t SendTwoLine2QHYCCDInterCamOled(qhyccd_handle *handle,char *messageTop,char *messageBottom)

    # uint32_t SendOneLine2QHYCCDInterCamOled(qhyccd_handle *handle,char *messageTop)


    # uint32_t GetQHYCCDShutterStatus(qhyccd_handle *handle)

    # uint32_t ControlQHYCCDShutter(qhyccd_handle *handle,uint8_t status)

    # uint32_t GetQHYCCDPressure(qhyccd_handle *handle,double *pressure)

    # uint32_t GetQHYCCDHumidity(qhyccd_handle *handle,double *hd)

    # uint32_t QHYCCDI2CTwoWrite(qhyccd_handle *handle,uint16_t addr,uint16_t value)

    # uint32_t QHYCCDI2CTwoRead(qhyccd_handle *handle,uint16_t addr)

    # double GetQHYCCDReadingProgress(qhyccd_handle *handle)

    # uint32_t TestQHYCCDPIDParas(qhyccd_handle *h, double p, double i, double d)

    # uint32_t SetQHYCCDTrigerFunction(qhyccd_handle *h,bool value)

    # uint32_t DownloadFX3FirmWare(uint16_t vid,uint16_t pid,char *imgpath)



    # uint32_t SetQHYCCDFineTone(qhyccd_handle *h,uint8_t setshporshd,uint8_t shdloc,uint8_t shploc,uint8_t shwidth)

    # uint32_t SetQHYCCDGPSVCOXFreq(qhyccd_handle *handle,uint16_t i)

    # uint32_t SetQHYCCDGPSLedCalMode(qhyccd_handle *handle,uint8_t i)

    # void SetQHYCCDGPSLedCal(qhyccd_handle *handle,uint32_t pos,uint8_t width)

    # void SetQHYCCDGPSPOSA(qhyccd_handle *handle,uint8_t is_slave,uint32_t pos,uint8_t width)

    # void SetQHYCCDGPSPOSB(qhyccd_handle *handle,uint8_t is_slave,uint32_t pos,uint8_t width)

    # uint32_t SetQHYCCDGPSMasterSlave(qhyccd_handle *handle,uint8_t i)

    # void SetQHYCCDGPSSlaveModeParameter(qhyccd_handle *handle,uint32_t target_sec,uint32_t target_us,uint32_t deltaT_sec,uint32_t deltaT_us,uint32_t expTime)

    # void SetQHYCCDQuit()

    # uint32_t QHYCCDVendRequestWrite(qhyccd_handle *h,uint8_t req,uint16_t value,uint16_t index1,uint32_t length,uint8_t *data)

    # uint32_t QHYCCDReadUSB_SYNC(qhyccd_handle *pDevHandle, uint8_t endpoint, uint32_t length, uint8_t *data, uint32_t timeout)

    # uint32_t QHYCCDLibusbBulkTransfer(qhyccd_handle *pDevHandle, uint8_t endpoint, uint8_t *data, uint32_t length, int32_t *transferred, uint32_t timeout)



    # uint32_t GetQHYCCDBeforeOpenParam(QHYCamMinMaxStepValue *p, CONTROL_ID controlId)
    # uint32_t EnableQHYCCDBurstMode(qhyccd_handle *h,bool i)
    # uint32_t SetQHYCCDBurstModeStartEnd(qhyccd_handle *h,unsigned short start,unsigned short end)
    # uint32_t EnableQHYCCDBurstCountFun(qhyccd_handle *h,bool i)
    # uint32_t ResetQHYCCDFrameCounter(qhyccd_handle *h)
    # uint32_t SetQHYCCDBurstIDLE(qhyccd_handle *h)
    # uint32_t ReleaseQHYCCDBurstIDLE(qhyccd_handle *h)
    # uint32_t SetQHYCCDBurstModePatchNumber(qhyccd_handle *h,uint32_t value)
    # uint32_t SetQHYCCDEnableLiveModeAntiRBI(qhyccd_handle *h,uint32_t value)
    # uint32_t SetQHYCCDWriteFPGA(qhyccd_handle *h,uint8_t number,uint8_t regindex,uint8_t regvalue)

    # uint32_t SetQHYCCDWriteCMOS(qhyccd_handle *h,uint8_t number,uint16_t regindex,uint16_t regvalue)

    # uint32_t SetQHYCCDTwoChannelCombineParameter(qhyccd_handle *handle, double x,double ah,double bh,double al,double bl)

    # uint32_t EnableQHYCCDImageOSD(qhyccd_handle *h,uint32_t i)


    # void QHYCCDQuit()

    # QHYDWORD SetQHYCCDCallBack(QHYCCDProcCallBack ProcCallBack, int32_t Flag)

    # void call_pnp_event()
