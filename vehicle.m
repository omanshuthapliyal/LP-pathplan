classdef vehicle < handle
    properties
        Velocity
        Position
        State
        dT
        T
        A
        B
        mu
        Radius
    end
    
    methods
        function obj = vehicle(X, V, mu, dT, r)
            obj.Velocity = V;
            obj.Position = X;
            obj.dT = dT;
            obj.T = 0;
            obj.Radius = r;

            obj.A = [1, 0, dT - mu * dT^2/2, 0;
                0, 1, 0, dT  - mu * dT^2/2;
                0, 0, 1 - mu*dT, 0;
                0, 0, 0, 1 - mu * dT];
            obj.B = [dT^2/2, 0;
                0, dT^2/2;
                dT, 0;
                0, dT];
            obj.State = [obj.Position; obj.Velocity];
        end
        
        function obj = updatePos(obj, F)
            obj.State = obj.A * obj.State  + obj.B * F;
            obj.Position = obj.State(1:2);
            obj.Velocity = obj.State(3:4);
            obj.T = obj.T + obj.dT;
        end
    end
end
