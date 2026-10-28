from libc.stddef cimport wchar_t
from libc.stdint cimport int32_t, uint16_t, uint32_t, uint64_t, uint8_t
from libcpp cimport bool

cdef extern from "qhyccd.h":

    cdef struct _QHYCamMinMaxStepValue:
        const char* name
        double min
        double max
        double step

    ctypedef _QHYCamMinMaxStepValue QHYCamMinMaxStepValue

    ctypedef uint64_t QHYDWORD

    ctypedef QHYDWORD (*QHYCCDProcCallBack)(void* handle, QHYDWORD message, QHYDWORD wParam, QHYDWORD lParam)

    ctypedef void qhyccd_handle

    void ImgProcRotationMirror(uint32_t* width, uint32_t* height, uint32_t* depth, uint32_t* channels, uint8_t* inbuf, uint8_t* outbuf, uint8_t flag)

    void OutputQHYCCDDebug(char* strOutput)

    void SetQHYCCDAutoDetectCamera(bool enable)

    void SetQHYCCDLogPath(char* path)

    void SetQHYCCDLogLevel(uint8_t logLevel)

    void EnableQHYCCDMessage(bool enable)

    void set_histogram_equalization(bool enable)

    void EnableQHYCCDLogFile(bool enable)

    uint32_t SetQHYCCDArrayCamSync(qhyccd_handle* handle, bool onoff)

    uint32_t SetQHYCCDSingleFrameTimeOut(qhyccd_handle* h, uint32_t time)

    const char* GetTimeStamp()

    uint32_t CheckQHYCCDDeviceDriverIO(uint32_t series)

    uint32_t InitQHYCCDResource()

    uint32_t ReleaseQHYCCDResource()

    uint32_t ScanQHYCCD()

    uint32_t GetQHYCCDId(uint32_t index, char* id)

    uint32_t GetQHYCCDModel(char* id, char* model)

    qhyccd_handle* OpenQHYCCD(char* id)

    uint32_t CloseQHYCCD(qhyccd_handle* handle)

    uint32_t SetQHYCCDStreamMode(qhyccd_handle* handle, uint8_t mode)

    uint32_t InitQHYCCD(qhyccd_handle* handle)

    uint32_t IsQHYCCDControlAvailable(qhyccd_handle* handle, CONTROL_ID controlId)

    uint32_t GetQHYCCDControlName(qhyccd_handle* handle, CONTROL_ID controlId, char* IDname)

    uint32_t SetQHYCCDParam(qhyccd_handle* handle, CONTROL_ID controlId, double value)

    double GetQHYCCDParam(qhyccd_handle* handle, CONTROL_ID controlId)

    uint32_t GetQHYCCDParamMinMaxStep(qhyccd_handle* handle, CONTROL_ID controlId, double* min, double* max, double* step)

    uint32_t SetQHYCCDResolution(qhyccd_handle* handle, uint32_t x, uint32_t y, uint32_t xsize, uint32_t ysize)

    uint32_t GetQHYCCDMemLength(qhyccd_handle* handle)

    uint32_t ExpQHYCCDSingleFrame(qhyccd_handle* handle)

    uint32_t GetQHYCCDSingleFrame(qhyccd_handle* handle, uint32_t* w, uint32_t* h, uint32_t* bpp, uint32_t* channels, uint8_t* imgdata)

    uint32_t GetQHYCCDSingleFrame_proc(qhyccd_handle* handle, uint32_t* w, uint32_t* h, uint32_t* bpp, uint32_t* channels, uint8_t* imgdata, uint8_t proc_overscan, uint32_t proc_binx, uint32_t proc_biny, uint8_t proc_bin_avg)

    void ParseGPSFromFrame(uint8_t* imgdata, uint32_t w, uint32_t bpp, uint32_t channels, uint32_t* seqNumber, uint32_t* latitude, uint32_t* longitude, bool* gps_locked, uint16_t* year, uint8_t* month, uint8_t* day, uint8_t* hour, uint8_t* minute, uint8_t* second)

    uint32_t CancelQHYCCDExposing(qhyccd_handle* handle)

    uint32_t CancelQHYCCDExposingAndReadout(qhyccd_handle* handle)

    uint32_t BeginQHYCCDLive(qhyccd_handle* handle)

    uint32_t GetQHYCCDLiveFrame(qhyccd_handle* handle, uint32_t* w, uint32_t* h, uint32_t* bpp, uint32_t* channels, uint8_t* imgdata)

    uint32_t StopQHYCCDLive(qhyccd_handle* handle)

    uint32_t QHYCCDPcieRecv(qhyccd_handle* handle, void* data, int len, uint64_t timeout)

    uint32_t GetQHYCCDPcieDDRNum(qhyccd_handle* handle)

    double GetQHYCCDDDRBufferValue(qhyccd_handle* handle)

    uint32_t SetQHYCCDBinMode(qhyccd_handle* handle, uint32_t wbin, uint32_t hbin)

    uint32_t SetQHYCCDBitsMode(qhyccd_handle* handle, uint32_t bits)

    uint32_t ControlQHYCCDTemp(qhyccd_handle* handle, double targettemp)

    uint32_t ControlQHYCCDGuide(qhyccd_handle* handle, uint32_t direction, uint16_t duration)

    uint32_t SendOrder2QHYCCDCFW(qhyccd_handle* handle, char* order, uint32_t length)

    uint32_t GetQHYCCDCFWStatus(qhyccd_handle* handle, char* status)

    uint32_t IsQHYCCDCFWPlugged(qhyccd_handle* handle)

    uint32_t GetQHYCCDTrigerInterfaceNumber(qhyccd_handle* handle, uint32_t* interfaceNumber)

    uint32_t GetQHYCCDTrigerInterfaceName(qhyccd_handle* handle, uint32_t interfaceIndex, char* name)

    uint32_t SetQHYCCDTrigerInterface(qhyccd_handle* handle, uint32_t interfaceIndex)

    uint32_t GetQHYCCDTrigerModeNumber(qhyccd_handle* handle, uint32_t* modeNumber)

    uint32_t GetQHYCCDTrigerModeName(qhyccd_handle* handle, uint32_t modeIndex, char* name)

    uint32_t SetQHYCCDTrigerMode(qhyccd_handle* handle, uint32_t modeIndex)

    uint32_t SetQHYCCDTrigerFunction(qhyccd_handle* h, bool value)

    uint32_t SetQHYCCDTrigerInOnly(qhyccd_handle* h, bool value)

    uint32_t SetQHYCCDTrigerOutOnly(qhyccd_handle* h, bool value)

    uint32_t EnableQHYCCDTrigerOut(qhyccd_handle* handle)

    uint32_t EnableQHYCCDTrigerOutA(qhyccd_handle* handle)

    uint32_t SendSoftTriger2QHYCCDCam(qhyccd_handle* handle)

    uint32_t SetQHYCCDTrigerFilterOnOff(qhyccd_handle* handle, bool onoff)

    uint32_t SetQHYCCDTrigerFilterTime(qhyccd_handle* handle, uint32_t time)

    void Bits16ToBits8(qhyccd_handle* h, uint8_t* InputData16, uint8_t* OutputData8, uint32_t imageX, uint32_t imageY, uint16_t B, uint16_t W)

    void HistInfo192x130(qhyccd_handle* h, uint32_t x, uint32_t y, uint8_t* InBuf, uint8_t* OutBuf)

    uint32_t OSXInitQHYCCDFirmware(char* path)

    uint32_t OSXInitQHYCCDFirmwareArray()

    uint32_t OSXInitQHYCCDAndroidFirmwareArray(int idVendor, int idProduct, int fileDescriptor)

    uint32_t GetQHYCCDChipInfo(qhyccd_handle* h, double* chipw, double* chiph, uint32_t* imagew, uint32_t* imageh, double* pixelw, double* pixelh, uint32_t* bpp)

    uint32_t GetQHYCCDEffectiveArea(qhyccd_handle* h, uint32_t* startX, uint32_t* startY, uint32_t* sizeX, uint32_t* sizeY)

    uint32_t GetQHYCCDOverScanArea(qhyccd_handle* h, uint32_t* startX, uint32_t* startY, uint32_t* sizeX, uint32_t* sizeY)

    uint32_t GetQHYCCDCurrentROI(qhyccd_handle* handle, uint32_t* startX, uint32_t* startY, uint32_t* sizeX, uint32_t* sizeY)

    uint32_t GetQHYCCDImageStabilizationGravity(qhyccd_handle* handle, int* GravityX, int* GravityY)

    uint32_t SetQHYCCDFocusSetting(qhyccd_handle* h, uint32_t focusCenterX, uint32_t focusCenterY)

    uint32_t GetQHYCCDExposureRemaining(qhyccd_handle* h)

    uint32_t GetQHYCCDFWVersion(qhyccd_handle* h, uint8_t* buf)

    uint32_t GetQHYCCDFPGAVersion(qhyccd_handle* h, uint8_t fpga_index, uint8_t* buf)

    uint32_t SetQHYCCDInterCamSerialParam(qhyccd_handle* h, uint32_t opt)

    uint32_t QHYCCDInterCamSerialTX(qhyccd_handle* h, char* buf, uint32_t length)

    uint32_t QHYCCDInterCamSerialRX(qhyccd_handle* h, char* buf)

    uint32_t QHYCCDInterCamOledOnOff(qhyccd_handle* handle, uint8_t onoff)

    uint32_t SetQHYCCDInterCamOledBrightness(qhyccd_handle* handle, uint8_t brightness)

    uint32_t SendFourLine2QHYCCDInterCamOled(qhyccd_handle* handle, char* messagetemp, char* messageinfo, char* messagetime, char* messagemode)

    uint32_t SendTwoLine2QHYCCDInterCamOled(qhyccd_handle* handle, char* messageTop, char* messageBottom)

    uint32_t SendOneLine2QHYCCDInterCamOled(qhyccd_handle* handle, char* messageTop)

    uint32_t GetQHYCCDCameraStatus(qhyccd_handle* h, uint8_t* buf)

    uint32_t GetQHYCCDShutterStatus(qhyccd_handle* handle)

    uint32_t ControlQHYCCDShutter(qhyccd_handle* handle, uint8_t status)

    uint32_t GetQHYCCDPressure(qhyccd_handle* handle, double* pressure)

    uint32_t GetQHYCCDHumidity(qhyccd_handle* handle, double* hd)

    uint32_t QHYCCDI2CTwoWrite(qhyccd_handle* handle, uint16_t addr, uint16_t value)

    uint32_t QHYCCDI2CTwoRead(qhyccd_handle* handle, uint16_t addr)

    double GetQHYCCDReadingProgress(qhyccd_handle* handle)

    uint32_t TestQHYCCDPIDParas(qhyccd_handle* h, double p, double i, double d)

    uint32_t DownloadFX3FirmWare(uint16_t vid, uint16_t pid, char* imgpath)

    uint32_t GetQHYCCDType(qhyccd_handle* h)

    uint32_t SetQHYCCDDebayerOnOff(qhyccd_handle* h, bool onoff)

    uint32_t SetQHYCCDFineTone(qhyccd_handle* h, uint8_t setshporshd, uint8_t shdloc, uint8_t shploc, uint8_t shwidth)

    uint32_t SetQHYCCDGPSVCOXFreq(qhyccd_handle* handle, uint16_t i)

    uint32_t SetQHYCCDGPSLedCalMode(qhyccd_handle* handle, uint8_t i)

    void SetQHYCCDGPSLedCal(qhyccd_handle* handle, uint32_t pos, uint8_t width)

    void SetQHYCCDGPSPOSA(qhyccd_handle* handle, uint8_t is_slave, uint32_t pos, uint8_t width)

    void SetQHYCCDGPSPOSB(qhyccd_handle* handle, uint8_t is_slave, uint32_t pos, uint8_t width)

    uint32_t SetQHYCCDGPSMasterSlave(qhyccd_handle* handle, uint8_t i)

    void SetQHYCCDGPSSlaveModeParameter(qhyccd_handle* handle, uint32_t target_sec, uint32_t target_us, uint32_t deltaT_sec, uint32_t deltaT_us, uint32_t expTime)

    void SetQHYCCDQuit()

    uint32_t QHYCCDVendRequestWrite(qhyccd_handle* h, uint8_t req, uint16_t value, uint16_t index1, uint32_t length, uint8_t* data)

    uint32_t QHYCCDVendRequestRead(qhyccd_handle* h, uint8_t req, uint16_t value, uint16_t index1, uint32_t length, uint8_t* data)

    uint32_t QHYCCDReadUSB_SYNC(qhyccd_handle* pDevHandle, uint8_t endpoint, uint32_t length, uint8_t* data, uint32_t timeout)

    uint32_t QHYCCDLibusbBulkTransfer(qhyccd_handle* pDevHandle, uint8_t endpoint, uint8_t* data, uint32_t length, int32_t* transferred, uint32_t timeout)

    uint32_t GetQHYCCDSDKVersion(uint32_t* year, uint32_t* month, uint32_t* day, uint32_t* subday)

    uint32_t GetQHYCCDPCIECardNum(uint32_t* num)

    uint32_t GetQHYCCDPCIECardVer(uint32_t index, uint32_t* year, uint32_t* month, uint32_t* day, uint32_t* subday)

    uint32_t GetQHYCCDNumberOfReadModes(qhyccd_handle* h, uint32_t* numModes)

    uint32_t GetQHYCCDReadModeNumberFromID(char* id, uint32_t* numModes)

    uint32_t GetQHYCCDReadModeResolution(qhyccd_handle* h, uint32_t modeNumber, uint32_t* width, uint32_t* height)

    uint32_t GetQHYCCDReadModeName(qhyccd_handle* h, uint32_t modeNumber, char* name)

    uint32_t GetQHYCCDReadModeNameFromID(char* id, uint32_t modeNumber, char* name)

    uint32_t SetQHYCCDReadMode(qhyccd_handle* h, uint32_t modeNumber)

    uint32_t GetQHYCCDReadMode(qhyccd_handle* h, uint32_t* modeNumber)

    uint32_t GetQHYCCDBeforeOpenParam(QHYCamMinMaxStepValue* p, CONTROL_ID controlId)

    uint32_t EnableQHYCCDBurstMode(qhyccd_handle* h, bool i)

    uint32_t SetQHYCCDBurstModeStartEnd(qhyccd_handle* h, uint32_t start, uint32_t end)

    uint32_t EnableQHYCCDBurstCountFun(qhyccd_handle* h, bool i)

    uint32_t ResetQHYCCDFrameCounter(qhyccd_handle* h)

    uint32_t SetQHYCCDBurstIDLE(qhyccd_handle* h)

    uint32_t ReleaseQHYCCDBurstIDLE(qhyccd_handle* h)

    uint32_t RereadQHYCCDBurstFrame(qhyccd_handle* h)

    uint32_t SetQHYCCDBurstModePatchNumber(qhyccd_handle* h, uint32_t value)

    uint32_t SetQHYCCDEnableLiveModeAntiRBI(qhyccd_handle* h, uint32_t value)

    uint32_t SetQHYCCDWriteFPGA(qhyccd_handle* h, uint8_t number, uint8_t regindex, uint8_t regvalue)

    uint32_t SetQHYCCDWriteCMOS(qhyccd_handle* h, uint8_t number, uint16_t regindex, uint16_t regvalue)

    uint32_t SetQHYCCDTwoChannelCombineParameter(qhyccd_handle* handle, double x, double ah, double bh, double al, double bl)

    uint32_t EnableQHYCCDImageOSD(qhyccd_handle* h, uint32_t i)

    uint32_t GetQHYCCDPreciseExposureInfo(qhyccd_handle* h, uint32_t* PixelPeriod_ps, uint32_t* LinePeriod_ns, uint32_t* FramePeriod_us, uint32_t* ClocksPerLine, uint32_t* LinesPerFrame, uint32_t* ActualExposureTime, uint8_t* isLongExposureMode)

    uint32_t GetQHYCCDRollingShutterEndOffset(qhyccd_handle* h, uint32_t row, double* offset)

    void QHYCCDQuit()

    QHYDWORD SetQHYCCDCallBack(QHYCCDProcCallBack ProcCallBack, int32_t Flag)

    void RegisterPnpEventIn(void (*in_pnp_event_in_func)(char* id))

    void RegisterPnpEventOut(void (*in_pnp_event_out_func)(char* id))

    uint32_t resetDev(char* deviceID, uint32_t readModeIndex, uint8_t streamMode, qhyccd_handle* devHandle, uint32_t* imageWidth, uint32_t* imageHigh, uint32_t bitDepth)

    void RegisterDataEventSingle(void (*in_data_event_single_func)(char* id, uint8_t* imgdata))

    void RegisterDataEventLive(void (*in_data_event_live_func)(char* id, uint8_t* imgdata))

    void RegisterTransferEventError(void (*transfer_event_error_func)())

    void RegisterPnpEventUVLO(void (*in_pnp_event_uvlo_func)(char* id, uint8_t status))

    uint32_t PCIEClearDDR(qhyccd_handle* handle)

    uint32_t GetReadModesNumber(char* deviceID, uint32_t* numModes)

    uint32_t GetReadModeName(char* deviceID, uint32_t modeIndex, char* modeName)

    void QHYCCDSensorPhaseReTrain(qhyccd_handle* handle)

    void QHYCCDReadInitConfigFlash(qhyccd_handle* handle, char* configString_raw64)

    void QHYCCDEraseInitConfigFlash(qhyccd_handle* handle)

    void QHYCCDResetFlashULVOError(qhyccd_handle* handle)

    void QHYCCDTestFlashULVOError(qhyccd_handle* handle)

    void QHYCCDSetFlashInitPWM(qhyccd_handle* handle, uint8_t pwm)

    void QHYCCDGetDebugDataD3(qhyccd_handle* handle, char* debugData_raw64)

    uint32_t QHYCCDSolve(int timeout_s, float scale_l, float scale_h, float center_ra, float center_dec, float center_r, float& s_ra, float& s_dec, float& s_size_x, float& s_size_y, float& s_rotation)

    void QHYCCDGetDebugControlID(CONTROL_ID controlId, bool hasValue, bool isSetValue, double value)

    void QHYCCDEqualizeHistogram(uint8_t* pdata, int width, int height, int bpp)

    cdef struct fpga_info_list

    int QHYCCD_fpga_list(fpga_info_list& list)

    uint32_t QHYCCD_fpga_open(int id)

    void QHYCCD_fpga_close()

    int QHYCCD_fpga_send(int chnl, void* data, int len, int destoff, int last, uint64_t timeout)

    int QHYCCD_fpga_recv(int chnl, void* data, int len, uint64_t timeout)

    void QHYCCD_fpga_reset()

    uint32_t SetQHYCCDLoadCalibrationFrames(qhyccd_handle* handle, uint32_t ImgW, uint32_t ImgH, uint32_t ImgBits, uint32_t ImgChannel, char* DarkFile, char* FlatFile, char* BiasFile)

    uint32_t SetQHYCCDCalibrationOnOff(qhyccd_handle* handle, bool onoff)

    uint32_t SetQHYCCDFrameDetectPos(qhyccd_handle* handle, uint32_t pos)

    uint32_t SetQHYCCDFrameDetectCode(qhyccd_handle* handle, uint8_t code)

    uint32_t SetQHYCCDFrameDetectOnOff(qhyccd_handle* handle, bool onoff)

    uint32_t GetQHYCCDSensorName(qhyccd_handle* handle, char* name)

    uint8_t GetCameraIsSuperSpeedFromID(char* id)

    uint8_t GetCameraStatusFromID(char* id)

    void EnableSupportOICamera(char* password)

    void QHYCCDResetEMMC(qhyccd_handle* handle, bool reset)

    uint32_t QHYCCDReadEMMCState(qhyccd_handle* handle)

    uint32_t QHYCCDReadEMMCAddress(qhyccd_handle* handle)

    uint32_t QHYCCDReadEMMCFPGAData(qhyccd_handle* handle, uint32_t* data)

    uint32_t QHYCCDOpenEMMCMode(qhyccd_handle* handle, bool open)

    uint32_t QHYCCDReadEMMC(qhyccd_handle* handle, uint32_t address, uint32_t length, unsigned char* buffer)

    uint32_t QHYCCDWriteEMMC(qhyccd_handle* handle, uint32_t address, uint32_t length, unsigned char* buffer)

    uint32_t RedirectCommand(qhyccd_handle* handle, const char* command, char* response)

    void call_pnp_event()

    void call_pnp_event_device_uvlo(char* id, uint8_t status)

    void call_data_event_live(char* id, uint8_t* imgdata)

    void call_transfer_event_error()

    void call_critical_event_error(qhyccd_handle* h)

    void SetPCIECardInfo(qhyccd_handle* handle, unsigned char index, unsigned char value)

    uint32_t PCIEWriteCameraRegister1(qhyccd_handle* handle, unsigned char idx, unsigned char val)

    uint32_t PCIEWriteCameraRegister2(qhyccd_handle* handle, unsigned char idx, unsigned char val)

    uint32_t QHYCCD_DbGainToGainValue(qhyccd_handle* h, double dbgain, double* gainvalue)

    uint32_t QHYCCD_GainValueToDbGain(qhyccd_handle* h, double gainvalue, double* dbgain)

    uint32_t QHYCCD_curveSystemGain(qhyccd_handle* handle, double gainV, double* systemgain)

    uint32_t QHYCCD_curveFullWell(qhyccd_handle* handle, double gainV, double* fullwell)

    uint32_t QHYCCD_curveReadoutNoise(qhyccd_handle* handle, double gainV, double* readoutnoise)

    uint32_t GetQHYCCDFPGATemp(qhyccd_handle* handle, double* temp)

    char* GetQHYCCDLastError()

    uint32_t ClearQHYCCDImageQueue(qhyccd_handle* handle)

    # int BCDUSBJJMASK

    # int USB30MAJORVER

    # int USB20MAJORVER

    # int USB_BOS_DESCRIPTOR_TYPE

    # int USB_DEVICE_CAPABILITY

    # int USB_SUPERSPEED_ENDPOINT_COMPANION

    # int USB_BOS_CAPABILITY_TYPE_Wireless_USB

    # int USB_BOS_CAPABILITY_TYPE_USB20_EXT

    # int USB_BOS_CAPABILITY_TYPE_SUPERSPEED_USB

    # int USB_BOS_CAPABILITY_TYPE_CONTAINER_ID

    # int USB_BOS_CAPABILITY_TYPE_CONTAINER_ID_SIZE

    # int USB_BOS_DEVICE_CAPABILITY_TYPE_INDEX

    # # NOTE: packed struct (Cython does not support __attribute__((packed)))
    # cdef struct _USB_BOS_DESCRIPTOR:
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     USHORT wTotalLength
    #     UCHAR bNumDeviceCaps

    # ctypedef _USB_BOS_DESCRIPTOR USB_BOS_DESCRIPTOR

    # ctypedef _USB_BOS_DESCRIPTOR* PUSB_BOS_DESCRIPTOR

    # # NOTE: packed struct (Cython does not support __attribute__((packed)))
    # cdef struct _USB_BOS_USB20_DEVICE_EXTENSION:
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     UCHAR bDevCapabilityType
    #     UINT bmAttribute

    # ctypedef _USB_BOS_USB20_DEVICE_EXTENSION USB_BOS_USB20_DEVICE_EXTENSION

    # ctypedef _USB_BOS_USB20_DEVICE_EXTENSION* PUSB_BOS_USB20_DEVICE_EXTENSION

    # # NOTE: packed struct (Cython does not support __attribute__((packed)))
    # cdef struct _USB_BOS_SS_DEVICE_CAPABILITY:
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     UCHAR bDevCapabilityType
    #     UCHAR bmAttribute
    #     USHORT wSpeedsSuported
    #     UCHAR bFunctionalitySupporte
    #     UCHAR bU1DevExitLat
    #     USHORT bU2DevExitLat

    # ctypedef _USB_BOS_SS_DEVICE_CAPABILITY USB_BOS_SS_DEVICE_CAPABILITY

    # ctypedef _USB_BOS_SS_DEVICE_CAPABILITY* PUSB_BOS_SS_DEVICE_CAPABILITY

    # cdef struct _USB_BOS_CONTAINER_ID:
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     UCHAR bDevCapabilityType
    #     UCHAR bReserved
    #     UCHAR ContainerID[16]

    # ctypedef _USB_BOS_CONTAINER_ID USB_BOS_CONTAINER_ID

    # ctypedef _USB_BOS_CONTAINER_ID* PUSB_BOS_CONTAINER_ID

    # # NOTE: packed struct (Cython does not support __attribute__((packed)))
    # cdef struct _USB_SUPERSPEED_ENDPOINT_COMPANION_DESCRIPTOR:
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     UCHAR bMaxBurst
    #     UCHAR bmAttributes
    #     USHORT bBytesPerInterval

    # ctypedef _USB_SUPERSPEED_ENDPOINT_COMPANION_DESCRIPTOR USB_SUPERSPEED_ENDPOINT_COMPANION_DESCRIPTOR

    # ctypedef _USB_SUPERSPEED_ENDPOINT_COMPANION_DESCRIPTOR* PUSB_SUPERSPEED_ENDPOINT_COMPANION_DESCRIPTOR

    int CALLBACK_MODE_SUPPORT

    int IMAGEQUEUE_ORIG_MODE

    int version_year

    int version_month

    int version_day

    int version_subday

    int SDK_SVN_REVISION

    int WINDOWS_PTHREAD_SUPPORT

    int WINPCAP_MODE_SUPPORT

    int PCIE_MODE_SUPPORT

    int CYUSB_MODE_SUPPORT

    int WINUSB_MODE_SUPPORT

    int LIBUSB_MODE_SUPPORT

    int PCIE_MODE_TEST

    int __CPP_MODE__

    int DEVICETYPE_IMG0S

    int DEVICETYPE_IMG0H

    int DEVICETYPE_IMG0L

    int DEVICETYPE_IMG0X

    int DEVICETYPE_IMG1S

    int DEVICETYPE_IMG2S

    int DEVICETYPE_IMG1E

    int DEVICETYPE_FX3G2

    int DEVICETYPE_QHY5

    int DEVICETYPE_QHY5II

    int DEVICETYPE_QHY5LII_M

    int DEVICETYPE_QHY5LII_C

    int DEVICETYPE_QHY5TII

    int DEVICETYPE_QHY5RII

    int DEVICETYPE_QHY5PII

    int DEVICETYPE_QHY5VII

    int DEVICETYPE_QHY5HII

    int DEVICETYPE_MINICAM5S_M

    int DEVICETYPE_MINICAM5S_C

    int DEVICETYPE_QHY5PII_C

    int DEVICETYPE_QHY5RII_C

    int DEVICETYPE_MINICAM5F_M

    int DEVICETYPE_QHY5PII_M

    int DEVICETYPE_QHY5TII_C

    int DEVICETYPE_POLEMASTER

    int DEVICETYPE_QHY5IIEND

    int DEVICETYPE_QHY5III174

    int DEVICETYPE_QHY5III174M

    int DEVICETYPE_QHY5III174C

    int DEVICETYPE_QHY174

    int DEVICETYPE_QHY174M

    int DEVICETYPE_QHY174C

    int DEVICETYPE_QHY5III178

    int DEVICETYPE_QHY5III178C

    int DEVICETYPE_QHY5III178M

    int DEVICETYPE_QHY178

    int DEVICETYPE_QHY178M

    int DEVICETYPE_QHY178C

    int DEVICETYPE_QHY5III185

    int DEVICETYPE_QHY5III185C

    int DEVICETYPE_QHY5III185M

    int DEVICETYPE_QHY185

    int DEVICETYPE_QHY185M

    int DEVICETYPE_QHY185C

    int DEVICETYPE_QHY5III224

    int DEVICETYPE_QHY5III224C

    int DEVICETYPE_QHY5III224M

    int DEVICETYPE_QHY224

    int DEVICETYPE_QHY224M

    int DEVICETYPE_QHY224C

    int DEVICETYPE_QHY5III290

    int DEVICETYPE_QHY5III290C

    int DEVICETYPE_QHY5III290M

    int DEVICETYPE_QHY290

    int DEVICETYPE_QHY290M

    int DEVICETYPE_QHY290C

    int DEVICETYPE_QHY5III236

    int DEVICETYPE_QHY5III236C

    int DEVICETYPE_QHY5III236M

    int DEVICETYPE_QHY236

    int DEVICETYPE_QHY236M

    int DEVICETYPE_QHY236C

    int DEVICETYPE_QHY5IIIG400M

    int DEVICETYPE_QHY163

    int DEVICETYPE_QHY163M

    int DEVICETYPE_QHY163C

    int DEVICETYPE_QHY165

    int DEVICETYPE_QHY165C

    int DEVICETYPE_QHY367

    int DEVICETYPE_QHY367C

    int DEVICETYPE_QHY183

    int DEVICETYPE_QHY183C

    int DEVICETYPE_QHY5IIICOMMON

    int DEVICETYPE_QHY247

    int DEVICETYPE_QHY247C

    int DEVICETYPE_MINICAM6F

    int DEVICETYPE_QHY168

    int DEVICETYPE_QHY168C

    int DEVICETYPE_QHY128

    int DEVICETYPE_QHY128C

    int DEVICETYPE_QHY294

    int DEVICETYPE_QHY2020

    int DEVICETYPE_QHY4040

    int DEVICETYPE_QHY550

    int DEVICETYPE_QHY42PRO

    int DEVICETYPE_QHY6060

    int DEVICETYPE_QHY411

    int DEVICETYPE_QHY600

    int DEVICETYPE_QHY600C

    int DEVICETYPE_QHY600M

    int DEVICETYPE_QHY0204

    int DEVICETYPE_QHY411ERIS

    int DEVICETYPE_QHY411MERIS

    int DEVICETYPE_QHY411CERIS

    int DEVICETYPE_QHY367PROC

    int DEVICETYPE_QHY268C

    int DEVICETYPE_QHY410C

    int DEVICETYPE_QHY432

    int DEVICETYPE_QHY342

    int DEVICETYPE_QHY4040PRO

    int DEVICETYPE_QHY128PROC

    int DEVICETYPE_QHY5III462

    int DEVICETYPE_QHY5III462C

    int DEVICETYPE_QHY5III462M

    int DEVICETYPE_QHY533C

    int DEVICETYPE_QHY492M

    int DEVICETYPE_QHY461

    int DEVICETYPE_QHY461M

    int DEVICETYPE_QHY461C

    int DEVICETYPE_QHY492MT

    int DEVICETYPE_QHY5III485

    int DEVICETYPE_QHY294PRO

    int DEVICETYPE_QHY294MPRO

    int DEVICETYPE_QHY294CPRO

    int DEVICETYPE_QHY4040PRO_F

    int DEVICETYPE_QHY4040PRO_B

    int DEVICETYPE_QHY268M

    int DEVICETYPE_QHY4040PRO_FN

    int DEVICETYPE_QHY4040PRO_BN

    int DEVICETYPE_QHY990

    int DEVICETYPE_QHY5III178C_Celestron

    int DEVICETYPE_QHY5LII_C_OrionAllInOne

    int DEVICETYPE_QHY5LII_M_Orion_StarShoot

    int DEVICETYPE_QHY550_PM

    int DEVICETYPE_QHY550_PC

    int DEVICETYPE_QHY550_M

    int DEVICETYPE_QHY550_C

    int DEVICETYPE_QHY5III482C

    int DEVICETYPE_QHY5III464

    int DEVICETYPE_QHY183A

    int DEVICETYPE_QHY183A_M

    int DEVICETYPE_QHY183A_C

    int DEVICETYPE_QHY5III334

    int DEVICETYPE_QHY5III334M

    int DEVICETYPE_QHY5III334C

    int DEVICETYPE_QHY991

    int DEVICETYPE_QHY1253

    int DEVICETYPE_QHY5III415

    int DEVICETYPE_QHY1920

    int DEVICETYPE_QHY1920M

    int DEVICETYPE_QHY1920C

    int DEVICETYPE_QHY9701

    int DEVICETYPE_QHY530

    int DEVICETYPE_QHY600M_OEM

    int DEVICETYPE_QHY533M

    int DEVICETYPE_QHY5III200M

    int DEVICETYPE_QHY5III585C

    int DEVICETYPE_QHY10768

    int DEVICETYPE_QHY6060Pro

    int DEVICETYPE_QHY5III678

    int DEVICETYPE_QHY5III678C

    int DEVICETYPE_QHY5III678M

    int DEVICETYPE_QHY342PRO

    int DEVICETYPE_QHY5III715

    int DEVICETYPE_QHY5III715C

    int DEVICETYPE_QHY5III715M

    int DEVICETYPE_QHY630T

    int DEVICETYPE_QHY268_OEM

    int DEVICETYPE_QHY268M_OEM

    int DEVICETYPE_QHY268C_OEM

    int DEVICETYPE_QHY5III568M

    int DEVICETYPE_QHY5III568C

    int DEVICETYPE_QHYMINICAM8M

    int DEVICETYPE_QHYMINICAM8C

    int DEVICETYPE_QHY533M_OEM

    int DEVICETYPE_QHY533C_OEM

    int DEVICETYPE_QHY487

    int DEVICETYPE_QHY992

    int DEVICETYPE_QHY533M_OI533M

    int DEVICETYPE_QHY533C_OI533C

    int DEVICETYPE_QHY268M_OI268M

    int DEVICETYPE_QHY268C_OI268C

    int DEVICETYPE_QHY600M_C600MC2

    int DEVICETYPE_QHY5III585M

    int DEVICETYPE_QHY661

    int DEVICETYPE_ORIGIN678C

    int DEVICETYPE_ORIGIN678M

    int DEVICETYPE_QHY1920M_OI1920M

    int DEVICETYPE_QHY1920C_OI1920C

    int DEVICETYPE_QHY811M

    int DEVICETYPE_QHY411MERISPH

    int DEVICETYPE_QHY411CERISPH

    int DEVICETYPE_QHY411MERISARRAY

    int DEVICETYPE_QHY600M_61M600

    int DEVICETYPE_QHY268M_SPOTCAM

    int DEVICETYPE_QHY1920M_U9ML

    int DEVICETYPE_QHY600M_DBC600

    int DEVICETYPE_QHY585M

    int DEVICETYPE_QHY585C

    int DEVICETYPE_QHY992ARRAY

    int DEVICETYPE_QHY1253ARRAY

    int DEVICETYPE_QHY26800A

    int DEVICETYPE_QHY6060ProBSI

    int DEVICETYPE_QHY26800AGUIDE

    int DEVICETYPE_QHY811C

    int DEVICETYPE_QHY992DEEP_COOLING

    int DEVICETYPE_QHY676M

    int DEVICETYPE_QHY676C

    int DEVICETYPE_QHY5III662M

    int DEVICETYPE_QHY5III662C

    int DEVICETYPE_QHY5IIIEND

    int DEVICETYPE_QHY16

    int DEVICETYPE_QHY6

    int DEVICETYPE_QHY7

    int DEVICETYPE_QHY2PRO

    int DEVICETYPE_IMG2P

    int DEVICETYPE_QHY8

    int DEVICETYPE_QHY8PRO

    int DEVICETYPE_QHY16000

    int DEVICETYPE_QHY12

    int DEVICETYPE_IC8300

    int DEVICETYPE_QHY9S

    int DEVICETYPE_QHY10

    int DEVICETYPE_QHY8L

    int DEVICETYPE_QHY11

    int DEVICETYPE_QHY21

    int DEVICETYPE_QHY22

    int DEVICETYPE_QHY23

    int DEVICETYPE_QHY15

    int DEVICETYPE_QHY27

    int DEVICETYPE_QHY28

    int DEVICETYPE_QHY9T

    int DEVICETYPE_QHY29

    int DEVICETYPE_SOLAR1600

    int DEVICETYPE_90A

    int DEVICETYPE_16200A

    int DEVICETYPE_814A

    int DEVICETYPE_16803

    int DEVICETYPE_09000

    int DEVICETYPE_695A

    int DEVICETYPE_QHY15G

    int DEVICETYPE_SOLAR800G

    int DEVICETYPE_A0340G

    int DEVICETYPE_QHY08050G

    int DEVICETYPE_QHY694G

    int DEVICETYPE_QHY27G

    int DEVICETYPE_QHY23G

    int DEVICETYPE_QHY16000G

    int DEVICETYPE_QHY160002AD

    int DEVICETYPE_QHY814G

    int DEVICETYPE_QHY45GX

    int DEVICETYPE_QHY10_FOCUS

    int DEVICETYPE_QHY50GX

    int DEVICETYPE_QHYPCIEBEGIN

    int DEVICETYPE_QHY4040PROPCIE

    int DEVICETYPE_QHY411ERISPCIE

    int DEVICETYPE_QHY411ERISPCIEARRAY

    int DEVICETYPE_QHY600PCIE

    int DEVICETYPE_QHY600PCIE_61M600

    int DEVICETYPE_QHY268PCIE

    int DEVICETYPE_QHY530PCIE

    int DEVICETYPE_QHY6060P_PCIE

    int DEVICETYPE_QHY990PCIE

    int DEVICETYPE_QHY991PCIE

    int DEVICETYPE_QHY461PCIE

    int DEVICETYPE_QHY342PCIE

    int DEVICETYPE_QHY487PCIE

    int DEVICETYPE_QHY811PCIE

    int DEVICETYPE_QHY661PCIE

    int DEVICETYPE_QHYPCIEEND

    int IMG132E_MAX_WIDTH

    int IMG132E_MAX_HEIGHT

    int IMG0H_MAX_WIDTH

    int IMG0H_MAX_HEIGHT

    int IMG0L_MAX_WIDTH

    int IMG0L_MAX_HEIGHT

    int IMG0X_MAX_WIDTH

    int IMG0X_MAX_HEIGHT

    int IMG1S_MAX_WIDTH

    int IMG1S_MAX_HEIGHT

    int IMG2S_MAX_WIDTH

    int IMG2S_MAX_HEIGHT

    int IMG1E_MAX_WIDTH

    int IMG1E_MAX_HEIGHT

    int QHY5_MAX_WIDTH

    int QHY5_MAX_HEIGHT

    int QHY5II_MAX_WIDTH

    int QHY5II_MAX_HEIGHT

    int QHY5LII_M_MAX_WIDTH

    int QHY5LII_M_MAX_HEIGHT

    int QHY5LII_C_MAX_WIDTH

    int QHY5LII_C_MAX_HEIGHT

    int QHY5TII_MAX_WIDTH

    int QHY5TII_MAX_HEIGHT

    int QHY5RII_MAX_WIDTH

    int QHY5RII_MAX_HEIGHT

    int QHY5PII_MAX_WIDTH

    int QHY5PII_MAX_HEIGHT

    int QHY5VII_MAX_WIDTH

    int QHY5VII_MAX_HEIGHT

    int QHY5HII_MAX_WIDTH

    int QHY5HII_MAX_HEIGHT

    int MINICAM5S_M_MAX_WIDTH

    int MINICAM5S_M_MAX_HEIGHT

    int MINICAM5S_C_MAX_WIDTH

    int MINICAM5S_C_MAX_HEIGHT

    int QHY5PII_C_MAX_WIDTH

    int QHY5PII_C_MAX_HEIGHT

    int QHY5RII_C_MAX_WIDTH

    int QHY5RII_C_MAX_HEIGHT

    int MINICAM5F_M_MAX_WIDTH

    int MINICAM5F_M_MAX_HEIGHT

    int QHY5PII_M_MAX_WIDTH

    int QHY5PII_M_MAX_HEIGHT

    int QHY5TII_C_MAX_WIDTH

    int QHY5TII_C_MAX_HEIGHT

    int POLEMASTER_MAX_WIDTH

    int POLEMASTER_MAX_HEIGHT

    int QHY5III174_MAX_WIDTH

    int QHY5III174_MAX_HEIGHT

    int QHY174_MAX_WIDTH

    int QHY174_MAX_HEIGHT

    int QHY5III178_MAX_WIDTH

    int QHY5III178_MAX_HEIGHT

    int QHY178_MAX_WIDTH

    int QHY178_MAX_HEIGHT

    int QHY5III185_MAX_WIDTH

    int QHY5III185_MAX_HEIGHT

    int QHY185_MAX_WIDTH

    int QHY185_MAX_HEIGHT

    int QHY185M_MAX_WIDTH

    int QHY185M_MAX_HEIGHT

    int QHY185C_MAX_WIDTH

    int QHY185C_MAX_HEIGHT

    int QHY5III224_MAX_WIDTH

    int QHY5III224_MAX_HEIGHT

    int QHY224_MAX_WIDTH

    int QHY224_MAX_HEIGHT

    int QHY5III290_MAX_WIDTH

    int QHY5III290_MAX_HEIGHT

    int QHY290_MAX_WIDTH

    int QHY290_MAX_HEIGHT

    int QHY5III236_MAX_WIDTH

    int QHY5III236_MAX_HEIGHT

    int QHY236_MAX_WIDTH

    int QHY236_MAX_HEIGHT

    int QHY5IIIG400M_MAX_WIDTH

    int QHY5IIIG400M_MAX_HEIGHT

    int QHY163_MAX_WIDTH

    int QHY163_MAX_HEIGHT

    int QHY165_MAX_WIDTH

    int QHY165_MAX_HEIGHT

    int QHY367_MAX_WIDTH

    int QHY367_MAX_HEIGHT

    int QHY183_MAX_WIDTH

    int QHY183_MAX_HEIGHT

    int QHY5IIICOMMON_MAX_WIDTH

    int QHY5IIICOMMON_MAX_HEIGHT

    int QHYFXNCOMMON_MAX_WIDTH

    int QHYFXNCOMMON_MAX_HEIGHT

    int QHY247_MAX_WIDTH

    int QHY247_MAX_HEIGHT

    int QHY168_MAX_WIDTH

    int QHY168_MAX_HEIGHT

    int QHY128_MAX_WIDTH

    int QHY128_MAX_HEIGHT

    int QHY294_MAX_WIDTH

    int QHY294_MAX_HEIGHT

    int QHY294_M_C_PRO_MAX_WIDTH_Mod_14_11M

    int QHY294_M_C_PRO_MAX_HEIGHT_Mod_14_11M

    int QHY294_M_C_PRO_MAX_WIDTH_Mod_12_47M

    int QHY294_M_C_PRO_MAX_HEIGHT_Mod_12_47M

    int QHY492_MAX_WIDTH

    int QHY492_MAX_HEIGHT

    int QHY2020_MAX_WIDTH

    int QHY2020_MAX_HEIGHT

    int QHY4040_MAX_WIDTH

    int QHY4040_MAX_HEIGHT

    int QHY4040PRO_MAX_WIDTH

    int QHY4040PRO_MAX_HEIGHT

    int QHY550_MAX_WIDTH

    int QHY550_MAX_HEIGHT

    int QHY990_MAX_WIDTH

    int QHY990_MAX_HEIGHT

    int QHY991_MAX_WIDTH

    int QHY991_MAX_HEIGHT

    int QHY42PRO_MAX_WIDTH

    int QHY42PRO_MAX_HEIGHT

    int QHY6060_MAX_WIDTH

    int QHY6060_MAX_HEIGHT

    int QHY10768_MAX_WIDTH

    int QHY10768_MAX_HEIGHT

    int QHY411_MAX_WIDTH

    int QHY411_MAX_HEIGHT

    int QHY661_MAX_WIDTH

    int QHY661_MAX_HEIGHT

    int QHY676_MAX_WIDTH

    int QHY676_MAX_HEIGHT

    int QHY811_MAX_WIDTH

    int QHY811_MAX_HEIGHT

    int QHY811_MAX_WIDTH_FDBIN22

    int QHY811_MAX_HEIGHT_FDBIN22

    int QHY411ERIS_MAX_WIDTH

    int QHY411ERIS_MAX_HEIGHT

    int QHY411ERIS_Left_Blank_single

    int QHY411ERIS_right_Blank_single

    int QHY411ERIS_Left_Blank_live

    int QHY411ERIS_right_Blank_live

    int QHY411ERIS_Top_Blank

    int QHY411ERIS_M_Default_SHIFT

    int QHY411ERIS_C_Default_SHIFT

    int QHY411ERIS_Bottom_Blank_live

    int QHY411ERIS_Bottom_Blank_single

    int QHY411ERIS_BIN33_MAX_WIDTH

    int QHY411ERIS_BIN33_MAX_HEIGHT

    int QHY411ERIS_M_BIN33_Left_Blank

    int QHY411ERIS_M_BIN33_right_Blank

    int QHY411ERIS_BIN33_Top_Blank

    int QHY411ERIS_BIN33_M_C_Default_SHIFT

    int QHY411ERIS_BIN33_M_Default_SHIFT

    int QHY411ERIS_BIN33_C_Default_SHIFT

    int QHY411ERIS_BIN33_Bottom_Blank

    int QHY600_MAX_WIDTH

    int QHY600_MAX_HEIGHT

    int QHY461_MAX_WIDTH

    int QHY461_MAX_HEIGHT

    int QHY432_MAX_WIDTH

    int QHY432_MAX_HEIGHT

    int QHY342_MAX_WIDTH

    int QHY342_MAX_HEIGHT

    int QHY16_MAX_WIDTH

    int QHY16_MAX_HEIGHT

    int QHY6_MAX_WIDTH

    int QHY6_MAX_HEIGHT

    int QHY7_MAX_WIDTH

    int QHY7_MAX_HEIGHT

    int QHY2PRO_MAX_WIDTH

    int QHY2PRO_MAX_HEIGHT

    int IMG2P_MAX_WIDTH

    int IMG2P_MAX_HEIGHT

    int QHY8_MAX_WIDTH

    int QHY8_MAX_HEIGHT

    int QHY8PRO_MAX_WIDTH

    int QHY8PRO_MAX_HEIGHT

    int QHY16000_MAX_WIDTH

    int QHY16000_MAX_HEIGHT

    int QHY12_MAX_WIDTH

    int QHY12_MAX_HEIGHT

    int IC8300_MAX_WIDTH

    int IC8300_MAX_HEIGHT

    int QHY9S_MAX_WIDTH

    int QHY9S_MAX_HEIGHT

    int QHY10_MAX_WIDTH

    int QHY10_MAX_HEIGHT

    int QHY8L_MAX_WIDTH

    int QHY8L_MAX_HEIGHT

    int QHY11_MAX_WIDTH

    int QHY11_MAX_HEIGHT

    int QHY21_MAX_WIDTH

    int QHY21_MAX_HEIGHT

    int QHY23_MAX_WIDTH

    int QHY23_MAX_HEIGHT

    int QHY15_MAX_WIDTH

    int QHY15_MAX_HEIGHT

    int QHY27_MAX_WIDTH

    int QHY27_MAX_HEIGHT

    int QHY28_MAX_WIDTH

    int QHY28_MAX_HEIGHT

    int QHY9T_MAX_WIDTH

    int QHY9T_MAX_HEIGHT

    int QHY29_MAX_WIDTH

    int QHY29_MAX_HEIGHT

    int SOLAR1600_MAX_WIDTH

    int SOLAR1600_MAX_HEIGHT

    int QHY90A_MAX_WIDTH

    int QHY90A_MAX_HEIGHT

    int QHY16200A_MAX_WIDTH

    int QHY16200A_MAX_HEIGHT

    int QHY814A_MAX_WIDTH

    int QHY814A_MAX_HEIGHT

    int IC16803_MAX_WIDTH

    int IC16803_MAX_HEIGHT

    int QHY09000_MAX_WIDTH

    int QHY09000_MAX_HEIGHT

    int QHY695A_MAX_WIDTH

    int QHY695A_MAX_HEIGHT

    int QHY15G_MAX_WIDTH

    int QHY15G_MAX_HEIGHT

    int SOLAR800G_MAX_WIDTH

    int SOLAR800G_MAX_HEIGHT

    int A0340G_MAX_WIDTH

    int A0340G_MAX_HEIGHT

    int QHY08050G_MAX_WIDTH

    int QHY08050G_MAX_HEIGHT

    int QHY694G_MAX_WIDTH

    int QHY694G_MAX_HEIGHT

    int QHY27G_MAX_WIDTH

    int QHY27G_MAX_HEIGHT

    int QHY23G_MAX_WIDTH

    int QHY23G_MAX_HEIGHT

    int QHY16000G_MAX_WIDTH

    int QHY16000G_MAX_HEIGHT

    int QHY160002AD_MAX_WIDTH

    int QHY160002AD_MAX_HEIGHT

    int QHY814G_MAX_WIDTH

    int QHY814G_MAX_HEIGHT

    int QHY45GX_MAX_WIDTH

    int QHY45GX_MAX_HEIGHT

    int QHY50GX_MAX_WIDTH

    int QHY50GX_MAX_HEIGHT

    int QHY26800A_MAX_WIDTH

    int QHY26800A_MAX_HEIGHT

    int QHY26800AGUIDE_MAX_WIDTH

    int QHY26800AGUIDE_MAX_HEIGHT

    int DEVICETYPE_QHY_DEMO

    int DEVICETYPE_UNKNOW

    int MAX_EXPOSURE_TIMES

    int REMAINING_MIN_EXPOSURETIMES

    int MAX_CAMERA_NUMBER

    int CAMERA_ID_LENGTH

    int MAXDEVICES

    int MAX_READMODE_NAME

    int MAX_READMODE_CAM_NUMBER

    int SEND_CAMERA_NO_MESSAGE

    int SEND_CAMERA_ID

    int SEND_CAMERA_STATUS

    int SEND_CAMERA_LIVE

    int SEND_CAMERA_SINGLE

    int SEND_CAMERA_CAPABLE

    int SEND_CAMERA_MAXMINSTEP

    int SEND_CAMERA_EXPOSING

    int CAMERA_HANDLE_INVALID

    int HANDLE_IS_NULL

    int USB_PORT_ERROR

    int CAMERA_LOSE

    int CAMERA_INSERT

    int CAMERA_LIVE_ERROR

    int CAMERA_LIVE_DATA_AVAILABLE

    int CAMERA_LIVE_STOP

    int CAMERA_LIVE_TIMEOUT

    int CAMERA_SINGLE_ERROR

    int CAMERA_SINGLE_DATA_AVAILABLE

    int CAMERA_SINGLE_STOP

    int CAMERA_SINGLE_TIMEOUT

    int SEND_MSG_NONE

    int SEND_MSG_WHOLE

    int SEND_MSG_PART

    int SINGLE_MODE

    int LIVE_MODE

    int QHYCCDParam_On

    int QHYCCDParam_Off

    int QHYCCDParam_AirPump_On

    int QHYCCDParam_AirPump_Off

    int FLASH_CONFIG_PAGE_INDEX

    int FPGA_MODE_DEFAULT

    int FPGA_MODE_12_47M

    int FPGA_MODE_14_11M

    int GET_IMAGE_TIMEOUT

    int IS_OPERATOR_NONE

    int IS_CAMARA_INIT

    int IS_CAMARA_OPEN

    int IS_CAMARA_CLOSE

    int IS_CAMARA_STOP_LIVE

    int IS_CAMARA_CAN_EXP

    int IS_CAMARA_ERROR

    int IS_GET_SINGLEPICTURE

    int IS_GET_LIVEPICTURE

    int COMMAND_QUEUE_PUSH

    int COMMAND_QUEUE_POP

    int DEMO_MAXDEVICES

    int MESSAGE_SIZS

    int CFWSLOTS_NUM9

    int CFWSLOTS_NUM8

    int CFWSLOTS_NUM7

    int CFWSLOTS_NUM6

    int CFWSLOTS_DELAY

    int RESET_USB_PIPE

    int ABORT_USB_PIPE

    int MAX_PCIE_CHANNEL

    int FPGA_CAMARA_LENGTH

    int CAM_SCAN_INTERVAL

    int CRC32_POLY

    int PCIE_CARD_READ_C

    int PCIE_CARD_WRITE_C

    int PCIE_FPGA_WRITE_C

    int PCIE_NIOS_READ_C

    int PCIE_NIOS_WRITE_C

    int PCIE_CAPTURE_WRITE_C

    int PCIE_EMMC_WRITE_C

    int PCIE_DWORD

    int FRAME_BUFF_NUM

    int IS_WRITE

    int IS_READ

    int CAM_CONN_STATUS_TO_NOTHING

    int CAM_CONN_STATUS_TO_PC

    int CAM_CONN_STATUS_TO_SDK

    cdef enum BOARDMODEL:
        PH_MODEL
        PRO_MODEL

    cdef enum TYPEMODEL:
        STD_MODEL
        QHY411MERIS_ARRAYMASTER
        QHY411MERIS_ARRAYSLAVE
        QHY600M_CCM
        QHY600M_61M
        QHY600M_DBC
        QHY1253_ARRAYMASTER
        QHY1253_ARRAYSLAVE

    int QHYCCD_READ_DIRECTLY

    int QHYCCD_DELAY_200MS

    int QHYCCD_PCIE

    int QHYCCD_WINPCAP

    int QHYCCD_QGIGAE

    int QHYCCD_USBSYNC

    int QHYCCD_USBASYNC

    int QHYCCD_COLOR

    int QHYCCD_MONO

    int QHYCCD_COOL

    int QHYCCD_NOTCOOL

    int QHYCCD_SUCCESS

    int QHYCCD_ERROR

    int QHYCCD_ERROR_IMAGESHIFT

    int QHYCCD_ERROR_DEVICELOSE

    int BUFSIZE_UPORT

    int CYWB_BL_4_BYTES_COPY(int destination, int source)

    # ctypedef struct vendorCmdData:
    #     UCHAR* buf
    #     UCHAR opCode
    #     UINT addr
    #     long size
    #     bool isRead

    # # NOTE: packed struct (Cython does not support __attribute__((packed)))
    # cdef struct _USB_DEVICE_DESCRIPTOR:
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     USHORT bcdUSB
    #     UCHAR bDeviceClass
    #     UCHAR bDeviceSubClass
    #     UCHAR bDeviceProtocol
    #     UCHAR bMaxPacketSize0
    #     USHORT idVendor
    #     USHORT idProduct
    #     USHORT bcdDevice
    #     UCHAR iManufacturer
    #     UCHAR iProduct
    #     UCHAR iSerialNumber
    #     UCHAR bNumConfigurations

    # ctypedef _USB_DEVICE_DESCRIPTOR USB_DEVICE_DESCRIPTOR

    # ctypedef _USB_DEVICE_DESCRIPTOR* PUSB_DEVICE_DESCRIPTOR

    # # NOTE: packed struct (Cython does not support __attribute__((packed)))
    # cdef struct _USB_ENDPOINT_DESCRIPTOR:
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     UCHAR bEndpointAddress
    #     UCHAR bmAttributes
    #     USHORT wMaxPacketSize
    #     UCHAR bInterval

    # ctypedef _USB_ENDPOINT_DESCRIPTOR USB_ENDPOINT_DESCRIPTOR

    # ctypedef _USB_ENDPOINT_DESCRIPTOR* PUSB_ENDPOINT_DESCRIPTOR

    # # NOTE: packed struct (Cython does not support __attribute__((packed)))
    # cdef struct _USB_CONFIGURATION_DESCRIPTOR:
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     USHORT wTotalLength
    #     UCHAR bNumInterfaces
    #     UCHAR bConfigurationValue
    #     UCHAR iConfiguration
    #     UCHAR bmAttributes
    #     UCHAR MaxPower

    # ctypedef _USB_CONFIGURATION_DESCRIPTOR USB_CONFIGURATION_DESCRIPTOR

    # ctypedef _USB_CONFIGURATION_DESCRIPTOR* PUSB_CONFIGURATION_DESCRIPTOR

    # cdef struct _USB_INTERFACE_DESCRIPTOR:
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     UCHAR bInterfaceNumber
    #     UCHAR bAlternateSetting
    #     UCHAR bNumEndpoints
    #     UCHAR bInterfaceClass
    #     UCHAR bInterfaceSubClass
    #     UCHAR bInterfaceProtocol
    #     UCHAR iInterface

    # ctypedef _USB_INTERFACE_DESCRIPTOR USB_INTERFACE_DESCRIPTOR

    # ctypedef _USB_INTERFACE_DESCRIPTOR* PUSB_INTERFACE_DESCRIPTOR

    # # NOTE: packed struct (Cython does not support __attribute__((packed)))
    # cdef struct _USB_STRING_DESCRIPTOR:
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     WCHAR bString[1]

    # ctypedef _USB_STRING_DESCRIPTOR USB_STRING_DESCRIPTOR

    # ctypedef _USB_STRING_DESCRIPTOR* PUSB_STRING_DESCRIPTOR

    # cdef struct _USB_COMMON_DESCRIPTOR:
    #     UCHAR bLength
    #     UCHAR bDescriptorType

    # ctypedef _USB_COMMON_DESCRIPTOR USB_COMMON_DESCRIPTOR

    # ctypedef _USB_COMMON_DESCRIPTOR* PUSB_COMMON_DESCRIPTOR

    # cdef cppclass CCyIsoPktInfo:
    #     LONG Status
    #     LONG Length

    # GUID CYUSBDRV_GUID

    # cdef enum CTL_XFER_TGT_TYPE:
    #     TGT_DEVICE
    #     TGT_INTFC
    #     TGT_ENDPT
    #     TGT_OTHER

    # cdef enum CTL_XFER_REQ_TYPE:
    #     REQ_STD
    #     REQ_CLASS
    #     REQ_VENDOR

    # cdef enum CTL_XFER_DIR_TYPE:
    #     DIR_TO_DEVICE
    #     DIR_FROM_DEVICE

    # cdef enum XFER_MODE_TYPE:
    #     XMODE_BUFFERED
    #     XMODE_DIRECT

    # const int MAX_ENDPTS

    # const int MAX_INTERFACES

    # const int USB_STRING_MAXLEN

    # cdef enum FX3_FWDWNLOAD_MEDIA_TYPE:
    #     RAM
    #     I2CE2PROM
    #     SPIFLASH

    # cdef enum FX3_FWDWNLOAD_ERROR_CODE:
    #     SUCCESS
    #     FAILED
    #     INVALID_MEDIA_TYPE
    #     INVALID_FWSIGNATURE
    #     DEVICE_CREATE_FAILED
    #     INCORRECT_IMAGE_LENGTH
    #     INVALID_FILE
    #     SPILASH_ERASE_FAILED
    #     CORRUPT_FIRMWARE_IMAGE_FILE
    #     I2CE2PROM_UNKNOWN_I2C_SIZE

    # cdef cppclass CCyUSBEndPoint:
    #     HANDLE hDevice
    #     UCHAR DscLen
    #     UCHAR DscType
    #     UCHAR Address
    #     UCHAR Attributes
    #     USHORT MaxPktSize
    #     USHORT PktsPerFrame
    #     UCHAR Interval
    #     UCHAR ssdscLen
    #     UCHAR ssdscType
    #     UCHAR ssmaxburst
    #     UCHAR ssbmAttribute
    #     USHORT ssbytesperinterval
    #     ULONG TimeOut
    #     ULONG UsbdStatus
    #     ULONG NtStatus
    #     DWORD bytesWritten
    #     DWORD LastError
    #     bool bIn
    #     XFER_MODE_TYPE XferMode
    #     CCyUSBEndPoint()
    #     CCyUSBEndPoint(CCyUSBEndPoint& ept)
    #     CCyUSBEndPoint(HANDLE h, PUSB_ENDPOINT_DESCRIPTOR pEndPtDescriptor)
    #     CCyUSBEndPoint(HANDLE hDev, PUSB_ENDPOINT_DESCRIPTOR pEndPtDescriptor, USB_SUPERSPEED_ENDPOINT_COMPANION_DESCRIPTOR* SSEndPtDescriptor)
    #     bool XferData(PUCHAR buf, LONG& len, CCyIsoPktInfo* pktInfos)
    #     bool XferData(PUCHAR buf, LONG& bufLen, CCyIsoPktInfo* pktInfos, bool pktMode)
    #     PUCHAR BeginDataXfer(PUCHAR buf, LONG len, OVERLAPPED* ov)
    #     bool FinishDataXfer(PUCHAR buf, LONG& len, OVERLAPPED* ov, PUCHAR pXmitBuf, CCyIsoPktInfo* pktInfos)
    #     bool WaitForXfer(OVERLAPPED* ov, ULONG tOut)
    #     ULONG GetXferSize()
    #     void SetXferSize(ULONG xfer)
    #     bool Reset()
    #     bool Abort()

    # cdef cppclass CCyControlEndPoint(CCyUSBEndPoint):
    #     CTL_XFER_TGT_TYPE Target
    #     CTL_XFER_REQ_TYPE ReqType
    #     CTL_XFER_DIR_TYPE Direction
    #     UCHAR ReqCode
    #     WORD Value
    #     WORD Index
    #     CCyControlEndPoint()
    #     CCyControlEndPoint(CCyControlEndPoint& ept)
    #     CCyControlEndPoint(HANDLE h, PUSB_ENDPOINT_DESCRIPTOR pEndPtDescriptor)
    #     bool Read(PUCHAR buf, LONG& len)
    #     bool Write(PUCHAR buf, LONG& len)
    #     PUCHAR BeginDataXfer(PUCHAR buf, LONG len, OVERLAPPED* ov)

    # cdef cppclass CCyIsocEndPoint(CCyUSBEndPoint):
    #     CCyIsocEndPoint()
    #     CCyIsocEndPoint(HANDLE h, PUSB_ENDPOINT_DESCRIPTOR pEndPtDescriptor)
    #     CCyIsocEndPoint(HANDLE h, PUSB_ENDPOINT_DESCRIPTOR pEndPtDescriptor, USB_SUPERSPEED_ENDPOINT_COMPANION_DESCRIPTOR* SSEndPtDescriptor)
    #     PUCHAR BeginDataXfer(PUCHAR buf, LONG len, OVERLAPPED* ov)
    #     CCyIsoPktInfo* CreatePktInfos(LONG bufLen, int& packets)

    # cdef cppclass CCyBulkEndPoint(CCyUSBEndPoint):
    #     CCyBulkEndPoint()
    #     CCyBulkEndPoint(HANDLE h, PUSB_ENDPOINT_DESCRIPTOR pEndPtDescriptor)
    #     CCyBulkEndPoint(HANDLE h, PUSB_ENDPOINT_DESCRIPTOR pEndPtDescriptor, USB_SUPERSPEED_ENDPOINT_COMPANION_DESCRIPTOR* SSEndPtDescriptor)
    #     PUCHAR BeginDataXfer(PUCHAR buf, LONG len, OVERLAPPED* ov)

    # cdef cppclass CCyInterruptEndPoint(CCyUSBEndPoint):
    #     CCyInterruptEndPoint()
    #     CCyInterruptEndPoint(HANDLE h, PUSB_ENDPOINT_DESCRIPTOR pEndPtDescriptor)
    #     CCyInterruptEndPoint(HANDLE h, PUSB_ENDPOINT_DESCRIPTOR pEndPtDescriptor, USB_SUPERSPEED_ENDPOINT_COMPANION_DESCRIPTOR* SSEndPtDescriptor)
    #     PUCHAR BeginDataXfer(PUCHAR buf, LONG len, OVERLAPPED* ov)

    # cdef cppclass CCyUSBInterface:
    #     CCyUSBEndPoint* EndPoints[32]
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     UCHAR bInterfaceNumber
    #     UCHAR bAlternateSetting
    #     UCHAR bNumEndpoints
    #     UCHAR bInterfaceClass
    #     UCHAR bInterfaceSubClass
    #     UCHAR bInterfaceProtocol
    #     UCHAR iInterface
    #     UCHAR bAltSettings
    #     USHORT wTotalLength
    #     CCyUSBInterface(HANDLE handle, PUSB_INTERFACE_DESCRIPTOR pIntfcDescriptor, UCHAR usb30Dummy)
    #     CCyUSBInterface(HANDLE h, PUSB_INTERFACE_DESCRIPTOR pIntfcDescriptor)
    #     CCyUSBInterface(CCyUSBInterface& ifc)

    # cdef cppclass CCyUSBConfig:
    #     CCyUSBInterface* Interfaces[255]
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     USHORT wTotalLength
    #     UCHAR bNumInterfaces
    #     UCHAR bConfigurationValue
    #     UCHAR iConfiguration
    #     UCHAR bmAttributes
    #     UCHAR MaxPower
    #     UCHAR AltInterfaces
    #     CCyUSBConfig()
    #     CCyUSBConfig(CCyUSBConfig& cfg)
    #     CCyUSBConfig(HANDLE h, PUSB_CONFIGURATION_DESCRIPTOR pConfigDescr)
    #     CCyUSBConfig(HANDLE h, PUSB_CONFIGURATION_DESCRIPTOR pConfigDescr, UCHAR usb30Dummy)

    # cdef cppclass CCyBosUSB20Extesnion:
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     UCHAR bDevCapabilityType
    #     UINT bmAttribute
    #     CCyBosUSB20Extesnion()
    #     CCyBosUSB20Extesnion(HANDLE h, PUSB_BOS_USB20_DEVICE_EXTENSION BosUsb20ExtDesc)

    # cdef cppclass CCyBosSuperSpeedCapability:
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     UCHAR bDevCapabilityType
    #     UCHAR bmAttribute
    #     USHORT SpeedsSuported
    #     UCHAR bFunctionalitySupporte
    #     UCHAR bU1DevExitLat
    #     USHORT bU2DevExitLat
    #     CCyBosSuperSpeedCapability()
    #     CCyBosSuperSpeedCapability(HANDLE h, PUSB_BOS_SS_DEVICE_CAPABILITY pUSB_SuperSpeedUsb)

    # cdef cppclass CCyBosContainerID:
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     UCHAR bDevCapabilityType
    #     UCHAR bReserved
    #     UCHAR ContainerID[16]
    #     CCyBosContainerID()
    #     CCyBosContainerID(HANDLE h, PUSB_BOS_CONTAINER_ID pContainerID)

    # cdef cppclass CCyUSBBOS:
    #     CCyBosContainerID* pContainer_ID
    #     CCyBosUSB20Extesnion* pUSB20_DeviceExt
    #     CCyBosSuperSpeedCapability* pSS_DeviceCap
    #     UCHAR bLength
    #     UCHAR bDescriptorType
    #     USHORT wTotalLength
    #     UCHAR bNumDeviceCaps
    #     CCyUSBBOS()
    #     CCyUSBBOS(HANDLE h, PUSB_BOS_DESCRIPTOR pBosDescrData)

    # cdef cppclass CCyUSBDevice:
    #     CCyUSBEndPoint** EndPoints
    #     CCyUSBBOS* UsbBos
    #     CCyIsocEndPoint* IsocInEndPt
    #     CCyIsocEndPoint* IsocOutEndPt
    #     CCyBulkEndPoint* BulkInEndPt
    #     CCyBulkEndPoint* BulkOutEndPt
    #     CCyControlEndPoint* ControlEndPt
    #     CCyInterruptEndPoint* InterruptInEndPt
    #     CCyInterruptEndPoint* InterruptOutEndPt
    #     USHORT StrLangID
    #     ULONG LastError
    #     ULONG UsbdStatus
    #     ULONG NtStatus
    #     ULONG DriverVersion
    #     ULONG USBDIVersion
    #     char DeviceName[256]
    #     char FriendlyName[256]
    #     wchar_t Manufacturer[256]
    #     wchar_t Product[256]
    #     wchar_t SerialNumber[256]
    #     CHAR DevPath[256]
    #     USHORT BcdUSB
    #     USHORT VendorID
    #     USHORT ProductID
    #     UCHAR USBAddress
    #     UCHAR DevClass
    #     UCHAR DevSubClass
    #     UCHAR DevProtocol
    #     INT MaxPacketSize
    #     USHORT BcdDevice
    #     UCHAR ConfigValue
    #     UCHAR ConfigAttrib
    #     UCHAR MaxPower
    #     UCHAR IntfcClass
    #     UCHAR IntfcSubClass
    #     UCHAR IntfcProtocol
    #     bool bHighSpeed
    #     bool bSuperSpeed
    #     DWORD BytesXfered
    #     CCyUSBDevice(HANDLE hnd, GUID guid, BOOL bOpen)
    #     CCyUSBEndPoint* EndPointOf(UCHAR addr)
    #     UCHAR DeviceCount()
    #     UCHAR ConfigCount()
    #     UCHAR IntfcCount()
    #     UCHAR AltIntfcCount()
    #     UCHAR EndPointCount()
    #     void SetConfig(UCHAR cfg)
    #     UCHAR Config()
    #     UCHAR Interface()
    #     UCHAR AltIntfc()
    #     bool SetAltIntfc(UCHAR alt)
    #     GUID DriverGUID()
    #     HANDLE DeviceHandle()
    #     void UsbdStatusString(ULONG stat, PCHAR s)
    #     bool CreateHandle(UCHAR dev)
    #     void DestroyHandle()
    #     bool Open(UCHAR dev)
    #     void Close()
    #     bool Reset()
    #     bool ReConnect()
    #     bool Suspend()
    #     bool Resume()
    #     bool IsOpen()
    #     UCHAR PowerState()
    #     bool GetBosDescriptor(PUSB_BOS_DESCRIPTOR descr)
    #     bool GetBosUSB20DeviceExtensionDescriptor(PUSB_BOS_USB20_DEVICE_EXTENSION descr)
    #     bool GetBosContainedIDDescriptor(PUSB_BOS_CONTAINER_ID descr)
    #     bool GetBosSSCapabilityDescriptor(PUSB_BOS_SS_DEVICE_CAPABILITY descr)
    #     void GetDeviceDescriptor(PUSB_DEVICE_DESCRIPTOR descr)
    #     void GetConfigDescriptor(PUSB_CONFIGURATION_DESCRIPTOR descr)
    #     void GetIntfcDescriptor(PUSB_INTERFACE_DESCRIPTOR descr)
    #     CCyUSBConfig GetUSBConfig(int index)

    # cdef cppclass CCyFX3Device(CCyUSBDevice):
    #     CCyFX3Device()
    #     bool IsBootLoaderRunning()
    #     FX3_FWDWNLOAD_ERROR_CODE DownloadFw(char* fileName, FX3_FWDWNLOAD_MEDIA_TYPE enMediaType)

    int QHYCCD_REQUEST_RQT

    int QHYCCD_REQUEST_READ

    int QHYCCD_REQUEST_WRITE

    int MACHANICALSHUTTER_OPEN

    int MACHANICALSHUTTER_CLOSE

    int MACHANICALSHUTTER_FREE

    int MAX_READMODE_NUMBER

    int MAX_READMODE_CAMARA_NUMBER

    cdef struct ccdreg:
        uint8_t Gain
        uint8_t Offset
        uint32_t Exptime
        uint8_t HBIN
        uint8_t VBIN
        uint16_t LineSize
        uint16_t VerticalSize
        uint16_t SKIP_TOP
        uint16_t SKIP_BOTTOM
        uint16_t LiveVideo_BeginLine
        uint16_t AnitInterlace
        uint8_t MultiFieldBIN
        uint8_t AMPVOLTAGE
        uint8_t DownloadSpeed
        uint8_t TgateMode
        uint8_t ShortExposure
        uint8_t VSUB
        uint8_t CLAMP
        uint8_t TransferBIT
        uint8_t TopSkipNull
        uint16_t TopSkipPix
        uint8_t MechanicalShutterMode
        uint8_t DownloadCloseTEC
        uint8_t SDRAM_MAXSIZE
        uint16_t ClockADJ
        uint8_t Trig
        uint8_t MotorHeating
        uint8_t WindowHeater
        uint8_t ADCSEL

    ctypedef ccdreg CCDREG

    cdef struct BIOREG:
        uint16_t LineSize
        uint16_t PatchNumber
        uint8_t AMPVOLTAGE
        uint8_t ShortExposure
        uint8_t SDRAM_MAXSIZE
        uint8_t DownloadSpeed
        uint8_t TransferBIT
        uint8_t BIOCCD_Mode
        uint8_t BIOCCD_Video
        uint8_t SDRAM_Bypass

    cdef enum CONTROL_ID:
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
        CAM_32BITS
        CAM_Sensor_ULVO_Status
        CAM_SensorPhaseReTrain
        CAM_InitConfigFromFlash
        CAM_TRIGER_MODE
        CAM_TRIGER_OUT
        CAM_BURST_MODE
        CAM_SPEAKER_LED_ALARM
        CAM_WATCH_DOG_FPGA
        CAM_BIN6X6MODE
        CAM_BIN8X8MODE
        CAM_GlobalSensorGPSLED
        CONTROL_ImgProc
        CONTROL_RemoveRBI
        CONTROL_GlobalReset
        CONTROL_FrameDetect
        CAM_GainDBConversion
        CAM_CurveSystemGain
        CAM_CurveFullWell
        CAM_CurveReadoutNoise
        CAM_UseAverageBinning
        CONTROL_OUTSIDE_PUMP_V2
        CONTROL_AUTOEXPOSURE
        CONTROL_AUTOEXPTargetBrightness
        CONTROL_AUTOEXPSampleArea
        CONTROL_AUTOEXPexpMaxMS
        CONTROL_AUTOEXPgainMax
        CONTROL_Error_Led
        CONTROL_HEATINGBOARD
        CONTROL_CAA_ROTATOR
        CONTROL_MAX_ID
        CONTROL_AUTOWHITEBALANCE
        CONTROL_ImageStabilization
        CONTROL_GAINdB
        CONTROL_DPC
        CONTROL_DPC_value
        CONTROL_HDR
        CONTROL_HDR_L_k
        CONTROL_HDR_L_b
        CONTROL_HDR_x
        CONTROL_HDR_showKB

    cdef enum BAYER_ID:
        BAYER_GB
        BAYER_GR
        BAYER_BG
        BAYER_RG

    cdef enum CodecID:
        NONE_CODEC
        H261_CODEC

    cdef enum ImgProc:
        NOPROC
        ROTATION180
        ROTATION90L
        ROTATION90R
        MIRRORH
        MIRRORV

    cdef struct _QHYGetImageParam:
        void* handle
        uint8_t* imgdata
        uint32_t w
        uint32_t h
        uint32_t bpp
        uint32_t channels
        bool HaveImgData

    ctypedef _QHYGetImageParam QHYGetImageParam

    ctypedef struct HistCoordinates:
        int x[3000]
        int y[3000]

    ctypedef struct StarRough:
        int x
        int y
        int starLevel

    ctypedef struct StarData:
        double x
        double y
        double snr
        int brightness
