# LibreELEC

LibreELEC is a 'Just enough OS' Linux distribution for the award-winning [Kodi](https://kodi.tv) software on popular mediacentre hardware. Further information on the project can be found on the [LibreELEC website](https://libreelec.tv).

## About
This fork is optimizied for my SandyBridge laptop with old and slow (Nvidia G210M) GPU. I added support for Nouveau driver for both GBM and X11 configs. Why to use Nouveau instead of Nvidia 340 legacy driver:
-  Accurate display modes detection
-  GBM mode support
-  Versatility
-  4K DolbyVision 24fps movie playback on 1080p SDR TV is flowless (in GBM mode, X11 is choppy right now and need futher configuration)
