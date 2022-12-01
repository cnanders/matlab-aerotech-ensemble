# matlab-aerotech-ensemble
MATLAB communication class for Aerotech Ensemble motion controller

Only Matlab base with the provided Matlab library package are sufficient. There is no need for any Matlab toolbox or Simulink.

## Instructions

### 1. Install Aerotech Ensemble software

This package requires installation of the Aerotech Ensemble software that shipped with the controller.  The Aerotech Ensemble software ships with a MATLAB communication library that this code uses. If you are at Berkeley Lab, the contents of the Aerotech Ensemble USB / Thumb drive can be downloaded from Google Drive [here](https://drive.google.com/drive/folders/1AqtE8ZvXBEfvqQukng4vdDdi1-JT11CC?usp=share_link)

The install location will usually be something like C:\Program Files (x86)\Aerotech\Ensemble

### 2. Connect the Ensemble controller to the PC via ethernet or USB

### 3. "Map" connected Aerotech controllers with ConfigurationManager.exe

"Mapping" is done with the Aerotech Ensemble ConfigurationManager.exe which will be installed at C:\Program Files (x86)\Aerotech\Ensemble\Bin\ConfigurationManager.exe

Inside ConfigurationManager app, go to the Controller menu -> Connection Settings and map available devices 

### 4. Create vendor/aerotech directory in this repo

### 5. Copy MATLAB libs into vendor/aerotech

- (64-bit) Copy C:\Program Files (x86)\Aerotech\Ensemble\Matlab\x64 into vendor/aerotech
- (32-bit) Copy C:\Program Files (x86)\Aerotech\Ensemble\Matlab\x86 into vendor/aerotech











