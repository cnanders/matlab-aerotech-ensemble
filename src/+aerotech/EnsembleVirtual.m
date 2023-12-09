classdef EnsembleVirtual < aerotech.EnsembleAbstract


    
    properties (Constant)

        
    end

    properties (Access = private)

      dSpeed = [5 5]
      lIsReferenced = [false false]
      dPosition = [0 0]

    end

    methods

        function this = EnsembleVirtual(varargin)

            for k = 1:2:length(varargin)
                this.msg(sprintf('passed in %s', varargin{k}));

                if this.hasProp(varargin{k})
                    this.msg(sprintf('settting %s', varargin{k}));
                    this.(varargin{k}) = varargin{k + 1};
                end

            end

        end

        % Stops motion of an axis of a controller
        function stop(this, u8Index, u8Axis)
            
        end
        
        function findReferenceMark(this, u8Index, u8Axis)
            this.lIsReferenced(u8Axis + 1) = true;

        end

        function l = getIsReferenced(this, u8Index, u8Axis)
            l = this.lIsReferenced(u8Axis + 1);
        end

        function setPosition(this, u8Index, u8Axis, dPosition)
            this.dPosition(u8Axis +1) = dPosition;
            
        end

        function d = getPosition(this, u8Index, u8Axis)
            d = this.dPosition(u8Axis+1);
        end

        
        function l = getIsMoving(this, u8Index, u8Axis)
            l = false;
        end
        

        function setSpeed(this, u8Index, u8Axis, dSpeed)
            this.dSpeed(u8Axis + 1) = dSpeed;
        end
        
        function d = getSpeed(this, u8Index, u8Axis)
            d = this.dSpeed(u8Axis + 1);
        end
        

    end

    methods (Access = private)


        



    end

end
