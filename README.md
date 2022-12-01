# matlab-aerotech-ensemble
MATLAB communication class for Aerotech Ensemble motion controller

Only Matlab base with the provided Matlab library package are sufficient. There is no need for any Matlab toolbox or Simulink.


## Installation and dependencies

This package requires installation of the Aerotech Ensemble software that shipped with the controller.  The Aerotech Ensemble software ships with a MATLAB communication library that this code uses.  

### 1. Install Aerotech Ensemble software

The install location will usually be something like C:\Program Files (x86)\Aerotech\Ensemble

### 2. Connect the Ensemble controller to the PC via ethernet or USB

### 3. "Map" connected Aerotech controllers with ConfigurationManager.exe

"Mapping" is done with the Aerotech Ensemble ConfigurationManager.exe which will be installed at C:\Program Files (x86)\Aerotech\Ensemble\Bin\ConfigurationManager.exe

After installing Matlab and the Aerotech Ensemble software, locate the folder of Matlab in the Ensemble installation folder. Usually its address can be as follows.


### Copy C:\Program Files (x86)\Aerotech\Ensemble\Matlab\x64 and \x86 into vendor/aerotech

**The library should already be copied into the vendor folder of this repository**

The Matlab library package is stored in the folder of x64 (if your computer architecture is x64) inside the Matlab directory above. To make sure that you do not modify any files in this Matlab library, you can copy the entire x64 folder and paste it into another location. For example, it can be placed in C:\Users\cxrodev\Documents\MATLAB\Aerotech

### Copy C:\Program Files (x86)\Aerotech\Ensemble\AeroBasic into vendor/aerotech

**The library should already be copied into the vendor folder of this repository**

After that, in vendor/aerotech there are two folders, x64 and AeroBasic.










