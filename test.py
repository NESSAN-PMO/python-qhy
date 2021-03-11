#!/usr/bin/env python
'''
Description: 
Author: F.O.X
Date: 2021-01-07 16:31:54
LastEditor: F.O.X
LastEditTime: 2021-03-11 21:51:38
'''

from QHYCCD import Camera
import time
from astropy.io import fits

cam = Camera("QHY.usb.0")
cam.Connected = True
cam.StartExposure(1)
time.sleep(3)
t = time.time()
d = cam.ImageArray
print(time.time() - t)
fits.PrimaryHDU(data=d).writeto("test.fits", overwrite=True)
cam.Connected = False

# from QHYCCD.pyqhyccd import *
# import sys
# from astropy.io import fits

# InitQHYCCDResource()
# total_cam = ScanQHYCCD()
# print(f"Found {total_cam} cameras.")
# if total_cam > 0:
#     camid = GetQHYCCDId(0)
#     print(camid)
#     cam = OpenQHYCCD(camid)
#     print(cam)
#     SetQHYCCDStreamMode(cam, 0)
#     InitQHYCCD(cam)

#     chipw, chiph, imagew, imageh, pixelw, pixelh, bpp = GetQHYCCDChipInfo(cam)
#     print(chipw, chiph, imagew, imageh, pixelw, pixelh, bpp)
#     SetQHYCCDResolution(cam, 0, 0, imagew, imageh)

#     SetQHYCCDParam(cam, CONTROL_ID.CONTROL_GAIN, 60)
#     SetQHYCCDParam(cam, CONTROL_ID.CONTROL_OFFSET, 76)
#     SetQHYCCDParam(cam, CONTROL_ID.CONTROL_EXPOSURE, 1 * 1000000.0)
#     ExpQHYCCDSingleFrame(cam)
#     d = GetQHYCCDSingleFrame(cam)
#     fits.PrimaryHDU(data=d).writeto("test.fits", overwrite=True)
#     CloseQHYCCD(cam)
# ReleaseQHYCCDResource()
