classdef Ensemble < aerotech.EnsembleAbstract


    % A downside of the native C libraries is that they were not set up to create a
    % separate communication client for each mapped Aerotech controller.  Instead
    % EnsembleConnect returns an array of handles 

    % bitand(uint8(bin2dec('011')), uint8(bin2dec('010'))
    
    % how to convert a status mask to 

    properties (Constant)

        
    end

    properties (Access = private)

      dSpeed = []
      handles = []

      lDebug = true

    end

    methods

        function this = Ensemble(varargin)

            for k = 1:2:length(varargin)
                this.msg(sprintf('passed in %s', varargin{k}));

                if this.hasProp(varargin{k})
                    this.msg(sprintf('settting %s', varargin{k}));
                    this.(varargin{k}) = varargin{k + 1};
                end

            end

            this.init()
        end

        % Stops motion of an axis of a controller
        function stop(this, u8Index, u8Axis)

            mask = zeros(1, length(enumeration('aerotech.Axis')));
            mask(u8Axis + 1) = 1;
            % EnsembleMotionHalt(this.handles(u8Index));
            % EnsembleMotionFreeRunStop(this.handles(u8Index), 1);
            EnsembleMotionAbort(this.handles(u8Index), mask);
            
        end
        
        function findReferenceMark(this, u8Index, u8Axis)
            this.msg(sprintf('findReferenceMark index: %d, axis: %d', u8Index, u8Axis));
            EnsembleMotionWaitMode(this.handles(u8Index), 0);
            EnsembleMotionHome(this.handles(u8Index), u8Axis)

        end

        function l = getIsReferenced(this, u8Index, u8Axis)

            statusMask = EnsembleStatusGetItem(this.handles(u8Index), u8Axis, EnsembleStatusItem.AxisStatus);
            l = bitand(uint32(statusMask), uint32(EnsembleAxisStatus.Homed)) > 0;
        end

        function setPosition(this, u8Index, u8Axis, dPosition)
            EnsembleMotionWaitMode(this.handles(u8Index), 0);
            EnsembleMotionMoveAbs(this.handles(u8Index), u8Axis, dPosition, this.dSpeed(u8Index, u8Axis + 1))
        end

        function d = getPosition(this, u8Index, u8Axis)
            d = EnsembleStatusGetItem(this.handles(u8Index), u8Axis, EnsembleStatusItem.PositionFeedback);
        end

        
        function l = getIsMoving(this, u8Index, u8Axis)
            statusMask = EnsembleStatusGetItem(this.handles(u8Index), u8Axis, EnsembleStatusItem.AxisStatus);
            l = bitand(uint32(statusMask), uint32(EnsembleAxisStatus.MoveActive)) > 0;
        end
        
        function mask = getStatusOfAxis(this, u8Index, u8Axis)
            mask = EnsembleStatusGetItem(this.handles(u8Index), u8Axis, EnsembleStatusItem.AxisStatus);
            mask = dec2bin(uint32(mask));  % convert to binary char array
            
        end

        function setSpeed(this, u8Index, u8Axis, dSpeed)
            this.dSpeed(u8Index, u8Axis + 1) = dSpeed;
        end
        
        function d = getSpeed(this, u8Index, u8Axis)
            d = this.dSpeed(u8Index, u8Axis + 1);
        end

        function delete(this)

            this.msg('delete()');
            this.evalAll(@this.disable);
            EnsembleDisconnect();
        end
        
        % Clears faults on all controllers
        function clearFaults(this, handle, axis, intH, intA )
            for idxH = 1:length(this.handles)
                try
                EnsembleAcknowledgeAll(this.handles(idxH));
                this.msg(sprintf('Cleared faults on controller %d', idxH));
                
                catch mE
                    this.msg(sprintf('Failed to clear faults on controller %d %s', idxH, mE.message));
                end

            end
        end

    end

    methods (Access = private)


        




        % Loops through available controllers and axes and calls the passed function
        % Passes handle, axis, idxHandle, and idxAxis to the function
        % @param {function_handle} fh that takes two arguments: handle and axis
        function evalAll(this, fh)

            [axes] = enumeration('aerotech.Axis');

            for idxH = 1:length(this.handles)
                
                axisMask = EnsembleInformationGetAxisMask(this.handles(idxH)); % Gets the available axes of a controller.

                for idxA = 1:length(axes)

                    idxMask = bitshift(1, idxA - 1); 
                    lAvailable = bitand(axisMask, idxMask) > 0;

                    if ~lAvailable
                        continue
                    end

                    fh(this.handles(idxH), axes(idxA), idxH, idxA);

                    
                end
            end
        end

        function disable(this, handle, axis, idxH, idxA)

            try
                EnsembleMotionDisable(handle, axis);
                cMsg = strjoin({...
                    'disable', ...
                    sprintf('controller: %d', idxH), ...
                    sprintf('axis %d %s', idxA, axis), ...
                }, ' ');
                this.msg(cMsg);

            catch mE
                cMsg = strjoin({...
                    'disable', ...
                    mE.message, ...
                    sprintf('controller: %d', idxH), ...
                    sprintf('axis %d %s', idxA, axis), ...
                }, '; ');
                this.msg(cMsg);
            end
        end


        function loadVendorLibs(this)

            % Load the vendor libraries
            % they are located in the matlab-aerotech-ensemble git repo at vendor/aerotech

            cDirThis = fileparts(mfilename('fullpath'));
            cDirAerotech = fullfile(cDirThis, '..', '..', 'vendor', 'aerotech');
            
            cDirAerotech = this.path2canonical(cDirAerotech);

            arch = computer('arch');

            if (strcmp(arch, 'win32'))
                cDir = fullfile(cDirAerotech, 'x86');
                addpath(cDir);
            else (strcmp(arch, 'win64'))
                cDir = fullfile(cDirAerotech, 'x64');
                addpath(cDir);
                % cDir = fullfile(cDirAerotech, 'AeroBasic');
                % addpath(genpath(cDir)); % genpath recursively crawls to get all subfolders

            end

        end

        % Enables motion on an axis of a controller
        % @param {handle} handle to controller
        % @param {aerotech.Axis} or int 0-5
        
        function enable(this, handle, axis, idxH, idxA)
            try
                EnsembleMotionEnable(handle, axis);
                cMsg = strjoin({...
                    'enable', ...
                    sprintf('controller: %d', idxH), ...
                    sprintf('axis %d %s', idxA, axis), ...
                }, ' ');
                this.msg(cMsg);

            catch mE
                cMsg = strjoin({...
                    'enable()', ...
                    mE.message, ...
                    sprintf('controller: %d', idxH), ...
                    sprintf('axis %d %s', idxA, axis), ...
                }, '; ');
                this.msg(cMsg);
            end
        end

        function populateSpeed(this, handle, axis, idxH, idxA)
            
            % Default to 5
            % The Ensemble has no notion of storing a speed.
            % Every 
            this.dSpeed(idxH, idxA)= 5;
            return;
            
            try
                this.dSpeed(idxH, idxA) = EnsembleStatusGetItem(handle, axis, EnsembleStatusItem.VelocityCommand);
                cMsg = strjoin({...
                    'populateSpeed', ...
                    sprintf('controller: %d', idxH), ...
                    sprintf('axis %d %s', idxA, axis), ...
                    sprintf('speed = %1.1f', this.dSpeed(idxH, idxA)), ...
                }, '; ');
                this.msg(cMsg);
            catch mE
                cMsg = strjoin({...
                    'populateSpeed', ...
                    mE.message, ...
                    sprintf('controller: %d', idxH), ...
                    sprintf('axis %d %s', idxA, axis), ...
                }, '; ');
                this.msg(cMsg);
                
            end
        end


        % Connect to all the mapped Ensembles that are available on the Network.
        % "Mapping" is done with the Aerotech Ensemble
        % ConfigurationManager.exe which will be installed at 

        function connect(this)

            if (isempty(this.handles))
                this.handles = EnsembleConnect();
            end

        end

        function init(this)
            this.loadVendorLibs();
            this.connect();
            this.clearFaults();
            this.evalAll(@this.enable);
            this.evalAll(@this.populateSpeed);
        end

        function msg(this, cMsg)
            this.lDebug & fprintf('aerotech.Ensemble %s\n', cMsg);
        end
        
        % Convert a relative directory path into a canonical path
        % i.e., C:\A\B\..\C becomes C:\A\C.  Uses java io interface
        
        function c = path2canonical(this, cPath)
           jFile = java.io.File(cPath);
           c = char(jFile.getCanonicalPath);
        end

    end

end
