#!/usr/bin/env python
'''
Description: 
Author: F.O.X
Date: 2021-01-07 16:31:54
LastEditor: F.O.X
LastEditTime: 2021-08-18 09:57:25
'''

from QHYCCD import Camera
import time
from astropy.io import fits
from astropy.time import Time
import tifffile as tiff

cam = Camera("usb.0")
cam.Connected = True
cam.Debayer = True
# cam.ReadoutMode = 3
# cam.Gain = 70
# cam.Offset = 10
for i in range(1):
    cam.StartExposure(2)
    while not cam.ImageReady:
        time.sleep(0.1)
    t = time.time()
    d = cam.ImageArray
    print(time.time() - t)
    #fits.PrimaryHDU(data=d).writeto("test.fits", overwrite=True)
    tiff.imsave('test.tif', d)
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
