#!/usr/bin/env python
'''
Description: 
Author: F.O.X
Date: 2021-01-07 16:31:54
LastEditor: F.O.X
LastEditTime: 2021-07-05 16:26:05
'''

from QHYCCD import Camera
import time
from astropy.io import fits
from astropy.time import Time

cam = Camera("QHYCCD.usb.0")
cam.Connected = True
cam.ReadoutMode = 3
cam.Gain=70
cam.Offset=5
for i in range(5):
    cam.StartExposure(2)
    while not cam.ImageReady:
        time.sleep(0.1)
    t = time.time()
    d = cam.ImageArray
    print(time.time() - t)
    #fits.PrimaryHDU(data=d).writeto("test_sdk.fits", overwrite=True)
    print(cam.LastExposureStartTime)
cam.Connected = False


# from comtypes.client import CreateObject

# cam = CreateObject("ASCOM.QHYCCD.Camera")
# cam.Connected=True
# cam.Gain = 70
# cam.Offset = 5
# cam.StartExposure(1, 1)
# while not cam.ImageReady:
#     time.sleep(0.1)
# t = time.time()
# d=cam.ImageArray
# print(time.time() - t)
# fits.PrimaryHDU(data=d).writeto("test_ascom.fits", overwrite=True)
# cam.Connected = False

# from QHYCCD.pyqhyccd import *
# import sys
# from astropy.io import fits
# from astropy.time import Time
# from datetime import datetime
# import time

# InitQHYCCDResource()
# total_cam = ScanQHYCCD()
# print(f"Found {total_cam} cameras.")
# if total_cam > 0:
#     camid = GetQHYCCDId(0)
#     cam = OpenQHYCCD(camid)
#     SetQHYCCDStreamMode(cam, 1)
#     InitQHYCCD(cam)
#     SetQHYCCDBitsMode(cam, 16)

#     SetQHYCCDParam(cam, CONTROL_ID.CONTROL_COOLER, -3)
#     time.sleep(1)
#     print(GetQHYCCDParam(cam, CONTROL_ID.CONTROL_COOLER))

#     chipw, chiph, imagew, imageh, pixelw, pixelh, bpp = GetQHYCCDChipInfo(cam)
#     print(chipw, chiph, imagew, imageh, pixelw, pixelh, bpp)
#     SetQHYCCDResolution(cam, 0, 0, imagew, imageh)

#     SetQHYCCDParam(cam, CONTROL_ID.CONTROL_GAIN, 60)
#     SetQHYCCDParam(cam, CONTROL_ID.CONTROL_OFFSET, 76)
#     SetQHYCCDParam(cam, CONTROL_ID.CONTROL_EXPOSURE, 0.1 * 1000000.0)
#     SetQHYCCDParam(cam, CONTROL_ID.CAM_GPS, 1)
#     print("Exposure info: ", GetQHYCCDPreciseExposureInfo(cam))
#     SetQHYCCDParam(cam, CONTROL_ID.CONTROL_USBTRAFFIC, 0)
#     print("USBTraffic: ", GetQHYCCDParam(cam, CONTROL_ID.CONTROL_USBTRAFFIC))
#     BeginQHYCCDLive(cam)
#     time.sleep(1)
#     print("Sys Time: ", datetime.utcnow())
#     for i in range(100):
#         t = time.time()
#         d = GetQHYCCDLiveFrame(cam)
#         print(d.shape, time.time() - t)
#         buf = d[0, 0:22].tobytes(order='C')
#         jd = (int.from_bytes(buf[18:22], 'big', signed=False) + int.from_bytes(
#             buf[22:25], 'big', signed=False) / 10000000.) / 86400. + 2450000.5
#         tm = Time(jd, format='jd').strftime("%Y-%m-%dT%H:%M:%S.%f")
#         print("Frame: ", int.from_bytes(buf[0:4], 'big', signed=False), tm)
#     print("Sys Time: ", datetime.utcnow())
#     StopQHYCCDLive(cam)
#     CloseQHYCCD(cam)
# ReleaseQHYCCDResource()
