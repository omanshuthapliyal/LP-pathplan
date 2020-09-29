function [AA, bb] = kinematicConstraints(A,DV_max,V_A_max,DV_min,V_A_min,...
    D_alpha_max,D_alpha_min)

V_A = A.Velocity;
v_a = norm(V_A);

lb = max(-DV_max, V_A_min - v_a);
ub = min(DV_max, V_A_max - v_a);

% rho_1 constraints
a1 = [1,0,0,-1,0];
b1 = 0;
a2 = [-1,0,0,-1,0];
b2 = 0;
% rho_2 constraints
a3 = [0,v_a,0,0,-1];
b3 = 0;
a4 = [0,-v_a,0,0,-1];
b4 = 0;
% D_V constraints
a5 = [-1,0,0,0,0];
b5 = -lb;
a6 = [1,0,0,0,0];
b6 = ub;
% D_Alpha constraints
a7 = [0,-1,0,0,0];
b7 = -D_alpha_min;
a8 = [0,1,0,0,0];
b8 = D_alpha_max;

% Positivity constraints
a9 = [zeros(3,2), -eye(3)];
b9 = [0;0;0];

AA = [a1;a2;a3;a4;a5;a6;a7;a8;a9];
bb = [b1;b2;b3;b4;b5;b6;b7;b8;b9];
end