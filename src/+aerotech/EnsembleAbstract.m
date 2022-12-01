classdef EnsembleAbstract < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    methods (Abstract)
        
        findReferenceMark(this, u8Handle, u8Axis)
        l = getIsReferenced(this, u8Handle, u8Axis) 

           
        setPosition(this, u8Handle, u8Axis, dPosition)
        dPosition = getPosition(this, u8Handle, u8Axis)
        l = getIsMoving(this, u8Handle, u8Axis)


        setSpeed(this, u8Handle, u8Axis, dSpeed)
        getSpeed(this, u8Handle, u8Axis)
        
    end
    
    
end

