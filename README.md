# LibreELEC

LibreELEC is a 'Just enough OS' Linux distribution for the award-winning [Kodi](https://kodi.tv) software on popular mediacentre hardware. Further information on the project can be found on the [LibreELEC website](https://libreelec.tv).

## About
This fork is optimizied for my SandyBridge laptop with old and slow (Nvidia G210M) GPU. I added support for Nouveau driver for both GBM and X11 configs. Why to use Nouveau instead of Nvidia 340 legacy driver:
-  Accurate display modes detection
-  GBM mode support
-  Versatility
-  4K DolbyVision 24fps movie playback on 1080p SDR TV is flowless

## Performance tunning
Based on my experience, GBM require less GPU resourses if compared to X11 to play 4K HDR content on 1080p SDR TV. To get a smooth experince all the time, we can set perfomrance level for the GPU manualy. To get available powerstates execute this:
```
cat /sys/kernel/debug/dri/0/pstate
```
This is the result for my GPU:
```
03: core 135 MHz shader 270 MHz memory 135 MHz
07: core 405 MHz shader 810 MHz memory 405 MHz
0f: core 606 MHz shader 1468 MHz memory 790 MHz
AC: core 405 MHz shader 810 MHz memory 405 MHz
```
In my case, highiest pstate is 0f. So, to set maximum performance level we have to execute the folowing code:
```
echo 0f > /sys/kernel/debug/dri/0/pstate
```
Also, you can set performance levels at startup by including this code in /storage/.config/autostart.sh script file.
