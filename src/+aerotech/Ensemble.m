classdef Ensemble < aerotech.EnsembleAbstract

    properties (Constant)

        u8AXIS_X = 0
        u8AXIS_Y = 1

    end

    properties (Access = private)

      dSpeed = [5 5]

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

        function findReferenceMark(this, u8Axis)

            this.msg(sprintf('findReferenceMark %d', u8Axis));
            EnsembleMotionHome(this.handle, u8Axis)

        end

        function setPosition(this, u8Axis, dPosition)
          EnsembleMotionMoveAbs(this.handle, u8Axis, dPosition, this.dSpeed(u8Axis))
        end


        function delete(this)

            this.msg('delete()');
            EnsembleMotionDisable(this.handle, this.u8AXIS_X)
            EnsembleMotionDisable(this.handle, this.u8AXIS_Y)
            EnsembleDisconnect();

        end

    end

    methods (Access = private)

        function loadVendorLibs(this)

            % Load the vendor libraries
            % they are located in the matlab-aerotech-ensemble git repo at vendor/aerotech

            cDirThis = fileparts(mfilename('fullpath'));
            cDirAerotech = fullfile(cDirThis, '..', '..', 'vendor', 'aerotech');

            arch = computer('arch');

            if (strcmp(arch, 'win32'))
                cDir = fullfile(cDirAerotech, 'x86');
                addpath(cDir);
            else (strcmp(arch, 'win64'))
                cDir = fullfile(cDirAerotech, 'x64');
                addpath(cDir);
                cDir = fullfile(cDirAerotech, 'AeroBasic');
                addpath(genpath(cDir)); % genpath recursively crawls to get all subfolders

            end

        end

        function this = init(this)
            this.loadVendorLibs();
            this.handle = EnsembleConnect;
            EnsembleMotionEnable(this.handle, this.u8AXIS_X)
            EnsembleMotionEnable(this.handle, this.u8AXIS_Y)

            % Populate initial speed
            this.dSpeed(1) = EnsembleMotionGetSpeed(this.handle, this.u8AXIS_X);
            this.dSpeed(2) = EnsembleMotionGetSpeed(this.handle, this.u8AXIS_Y);

        end

        function msg(this, cMsg)
            fprintf('aerotech.Ensemble %s\n', cMsg);
        end

    end

end
