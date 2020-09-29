classdef obstacle < handle
    
    properties
        Velocity
        Position
        dT
        Radius
        T
    end
    
    methods
        function obj = obstacle(X, V, dT, r)
            obj.Velocity = V;
            obj.Position = X;
            obj.dT = dT;
            obj.Radius = r;
            obj.T = 0;
        end
        
        function obj = updatePos(obj)
            obj.T = obj.T + obj.dT;
            obj.Position = obj.Position + obj.Velocity * obj.dT; 
        end
    end
    
end
