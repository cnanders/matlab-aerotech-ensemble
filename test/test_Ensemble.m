% test_Ensemble


cDir = fileparts(mfilename('fullpath'));
addpath(fullfile(cDir, '..', 'src'));
addpath(genpath(fullfile(cDir, '..', 'vendor')));

%% Create, init, and open
comm = aerotech.Ensemble();

