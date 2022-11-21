classdef EnsembleAbstract < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Abstract)
        
        %@param {uint32} absolute position to move to in mm
        goToPositionAbsolute(this, u32Channel, dPosition)

        findReferenceMark(this, u32Channel)
        
        l = getIsReferenced(this, u32Channel) 
        l = getIsMoving(this, u32Channel)
           
        setPosition(this.u32Channel, dPosition)
        dPosition = getPosition(this, u32Channel)

        setSpeed(this, u32Channel, dSpeed)
        getSpeed(this, u32Channel)

        
    end
    
    
end

