'''
Description: 
Author: F.O.X
Date: 2021-08-18 09:56:43
LastEditor: F.O.X
LastEditTime: 2021-08-18 11:25:39
'''

from QHYCCD.pyqhyccd import *
import sys
from astropy.io import fits
from astropy.time import Time
from datetime import datetime
import time
from pathlib import Path

def main():
    InitQHYCCDResource()
    total_cam = ScanQHYCCD()
    print(f"Found {total_cam} cameras.")
    if total_cam > 0:
        ncam = int(input("select a camera to read\n"))
        camid = GetQHYCCDId(ncam)
        cam = OpenQHYCCD(camid)
        #Readout mode here
        rmode = 3
        SetQHYCCDReadMode(cam, rmode)
        print(GetQHYCCDReadModeName(cam, rmode).decode('UTF-8'))
        SetQHYCCDStreamMode(cam, 1)
        InitQHYCCD(cam)
        SetQHYCCDBitsMode(cam, 16)
        SetQHYCCDParam(cam, CONTROL_ID.CONTROL_DDR, True)

        SetQHYCCDParam(cam, CONTROL_ID.CONTROL_COOLER, -10)
        time.sleep(1)
        print(GetQHYCCDParam(cam, CONTROL_ID.CONTROL_COOLER))

        chipw, chiph, imagew, imageh, pixelw, pixelh, bpp = GetQHYCCDChipInfo(cam)
        print(chipw, chiph, imagew, imageh, pixelw, pixelh, bpp)
        SetQHYCCDResolution(cam, 0, 0, imagew, imageh)

        #Gain offset here
        SetQHYCCDParam(cam, CONTROL_ID.CONTROL_GAIN, 60)
        SetQHYCCDParam(cam, CONTROL_ID.CONTROL_OFFSET, 76)
        exposure = float(input("input exposure in seconds\n"))
        SetQHYCCDParam(cam, CONTROL_ID.CONTROL_EXPOSURE, exposure * 1000000.0)
        SetQHYCCDParam(cam, CONTROL_ID.CAM_GPS, 1)
        expinfo = GetQHYCCDPreciseExposureInfo(cam)
        print("Exposure info: ", expinfo)
        exptime = expinfo[5] / 1000000.
        fixedoffset = GetQHYCCDRollingShutterEndOffset(cam, 0) / 1000000.0
        rowoffset = (GetQHYCCDRollingShutterEndOffset(cam, 2) - GetQHYCCDRollingShutterEndOffset(cam, 0)) / 2000000.0
        SetQHYCCDParam(cam, CONTROL_ID.CONTROL_USBTRAFFIC, 0)
        print("USBTraffic: ", GetQHYCCDParam(cam, CONTROL_ID.CONTROL_USBTRAFFIC))

        #Bin here
        bin = 1
        area = [0, 0, imagew/bin, imageh/bin]
        SetQHYCCDBinMode(cam, bin, bin)
        SetQHYCCDResolution(cam, *area)

        prompt = input("Any key to start exposure, q to exit\n")
        if prompt == 'q':
            pass
        else:
            BeginQHYCCDLive(cam)
            time.sleep(1)
            print("Sys Time: ", datetime.utcnow())
            while 1:
                try:
                    d = GetQHYCCDLiveFrame(cam)
                    if d.shape[2] == 1:
                        d = d[:, :, 0]
                    buf = d[0, 0:22].tobytes(order='C')
                    gps_status = (buf[33] // 16) % 4
                    sec = int.from_bytes(buf[26:30], 'big', signed=False) + int.from_bytes(buf[30:33], 'big', signed=False) / 10000000.
                    jd = (sec - exptime + fixedoffset) / 86400. + 2450000.5
                    tm = Time(jd, format='jd')
                    hdu = fits.PrimaryHDU(data = d)
                    hdu.header['EXPTIME'] = exptime
                    hdu.header['DATE-OBS'] = tm.strftime("%Y-%m-%dT%H:%M:%S.%f")
                    hdu.header['ROWOFF'] = rowoffset
                    hdu.header['GPSTATUS'] = gps_status
                    hdu.writeto(Path('c:/images').joinpath(tm.strftime("%Y%m%d%H%M%S%f.fits")))
                    print("Frame: ", int.from_bytes(buf[0:4], 'big', signed=False), tm)
                except KeyboardInterrupt:
                    break
            print("Sys Time: ", datetime.utcnow())
            StopQHYCCDLive(cam)
        CloseQHYCCD(cam)
    ReleaseQHYCCDResource()


if __name__ == "__main__":
    main()