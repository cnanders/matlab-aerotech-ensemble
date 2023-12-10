% test_Ensemble


cDir = fileparts(mfilename('fullpath'));
addpath(fullfile(cDir, '..', 'src'));
addpath(genpath(fullfile(cDir, '..', 'vendor')));

%% Create, init, and open
comm = aerotech.Ensemble();

% Command examples


%{
comm.getIsReferenced(1, 1)
comm.findReferenceMark(1, 1)
comm.getIsReferenced(1, 1)
comm.setPosition(1, 1, 10)
comm.getPosition(1, 1)
%}

%{
comm.setPosition(1, 1, 10)
comm.setPosition(1, 1, 20)
comm.setSpeed(1, 1, 1)
comm.setPosition(1, 1, 30)
comm.stop(1)
comm.setPosition(1, 1, 10)
comm.stop(1)
comm.setPosition(1, 1, 10)
comm.stop(1)
size(aerotech.Axis)
size(enumerate('aerotech.Axis'))
size(enumeration('aerotech.Axis'))
length(enumeration('aerotech.Axis'))
comm.setPosition(1, 1, 10)
comm.stop(1, 1)
comm.setPosition(1, 1, 10)
comm.stop(1, 1)
comm.findReferenceMark(1, 1)
comm.setPosition(1, 1, 10)
comm.stop(1, 1)
comm.getIsMoving(1, 1)
comm.getIsReferenced(1, 1)
comm.getIsReferenced(1, 0)
comm.getIsMoving(1, 1)
comm.setPosition(1, 1, 10)
comm.getIsMoving(1, 1)
%}
