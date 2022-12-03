# matlab-aerotech-ensemble
MATLAB communication class for Aerotech Ensemble motion controller

Only Matlab base with the provided Matlab library package are sufficient. There is no need for any Matlab toolbox or Simulink.

## Instructions

### 1. Install Aerotech Ensemble software

This package requires installation of the Aerotech Ensemble software that shipped with the controller.  The Aerotech Ensemble software ships with a MATLAB communication library that this code uses. If you are at Berkeley Lab, the contents of the Aerotech Ensemble USB / Thumb drive can be downloaded from Google Drive [here](https://drive.google.com/drive/folders/1AqtE8ZvXBEfvqQukng4vdDdi1-JT11CC?usp=share_link)

The install location will be something like C:\Program Files (x86)\Aerotech\Ensemble

### 2. Connect the Ensemble controller to the PC via ethernet or USB

### 3. "Map" connected Aerotech controllers with ConfigurationManager.exe

"Mapping" is done with the Aerotech Ensemble ConfigurationManager.exe which will be installed at C:\Program Files (x86)\Aerotech\Ensemble\Bin\ConfigurationManager.exe

- Controller menu -> Connection Settings
- wait for devices to refresh
- check the ones you want and click "apply"
- if you need to change the IP address of any devices, do this in their network tab.

To do: figure out what file on the machine gets modified after mapping is done.  I would love to know why this is required to use the MATLAB library.

### 4. Create vendor/aerotech directory in this repo

### 5. Copy MATLAB library from Aerotech into vendor/aerotech

- (64-bit) Copy C:\Program Files (x86)\Aerotech\Ensemble\Matlab\x64 into vendor/aerotech
- (32-bit) Copy C:\Program Files (x86)\Aerotech\Ensemble\Matlab\x86 into vendor/aerotech

## Testing

Use C:\Program Files (x86)\Aerotech\Ensemble\Bin\MotionComposer.exe to control the stage with native software.  When the app is opened go to Controller (menu) -> Connect.

Useful to use this MATLAB comm class to perform actions and see the UI update in MotionComposer, reflecting that the MATLAB code works.

When first opening.











