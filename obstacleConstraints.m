function [AA,bb] = obstacleConstraints(A,G,Obs)

[coeffs,gamma_flag] = obstacleAvoidanceLine(A,G,Obs);
a = coeffs(1);
b = coeffs(2);
c = coeffs(3);
% Eqs. 8 & 9
% X = [fx, fy, d(t)]'

predictedObsPos = Obs.Position + Obs.Velocity * Obs.dT;
if gamma_flag
    if [coeffs(1), coeffs(2)]* predictedObsPos <= coeffs(3)
        %   from  L(x(t+dT)) >= 0
        AA = [-a*A.B(1,1) - b*A.B(2,1), -a*A.B(1,2) - b*A.B(2,2), 0];
        bb = a * A.A(1,:) * A.State + b * A.A(2,:) * A.State - c;
    else
        %   from  L(x(t+dT)) <= 0
        AA = [a*A.B(1,1) + b*A.B(2,1), a*A.B(1,2) + b*A.B(2,2), 0];
        bb = c - a * A.A(1,:) * A.State - b * A.A(2,:) * A.State ;
    end
else
    AA = [];
    bb = [];
end
end