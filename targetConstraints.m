function [AA, bb] = targetConstraints(A,G,M)

% Eq (10) with dynamics Eq (2)
% X = [fx, fy, d(t)]'
predictedTargetPos = G.Position + G.Velocity * G.dT;
m = 0:M-1;
%---------------------------------
bb = (A.A(1,:)*A.State - predictedTargetPos(1))*sin(2*pi*m/M)' + ...
        (A.A(2,:)*A.State - predictedTargetPos(2))*cos(2*pi*m/M)' ;
bb = -bb;
AA = [A.B(1,1)*sin(2*pi*m/M)' + A.B(2,1)*cos(2*pi*m/M)' ,...
        A.B(1,2)*sin(2*pi*m/M)' + A.B(2,2)*cos(2*pi*m/M)' ];
AA = [AA, -ones(M,1)];

% Appending constraint d >= d_min = Target radius
a = [0,0,-1];
b = -G.Radius;
AA = [AA; a];
bb = [bb;b];
end