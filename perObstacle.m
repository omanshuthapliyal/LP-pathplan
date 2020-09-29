function [AA,bb] = perObstacle(A,Obs)

V_AO = A.Velocity - Obs.Velocity;
L_AO = -A.Position + Obs.Position;
V_A = A.Velocity;
gamma_AO = angleBetween(V_AO,L_AO);
L = norm(L_AO);
gamma_AOC = asin(Obs.Radius/L);

temp = V_AO - L_AO;
if temp(2) > 0
    D_gamma_min = gamma_AOC + gamma_AO;
    D_gamma_max = - gamma_AOC + gamma_AO;
else
    D_gamma_max = gamma_AOC + gamma_AO;
    D_gamma_min = - gamma_AOC + gamma_AO;
    
end
phi_AO = angleBetween(V_A, V_AO);

v_a = norm(V_A);
v_ao = norm(V_AO);
% Eqs 2.1 & 2.2
a1 = [-sin(phi_AO)/v_ao , v_a*cos(phi_AO)/v_ao, 0, 0, 0];
b1 = D_gamma_min;

a2 = -a1;
b2 = pi;

a3 = -a1;
b3 = -D_gamma_max;

a4 = a1;
b4 = pi;

AA = [a1;a2;a3;a4];
bb = [b1;b2;b3;b4];

end