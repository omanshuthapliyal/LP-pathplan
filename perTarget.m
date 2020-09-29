function [AA,bb] = perTarget(A,G)

dt = A.dT;
V_AG = A.Velocity - G.Velocity;
L_AG = -A.Position + G.Position;
gamma_AG = angleBetween(V_AG,L_AG);
V_A = A.Velocity;

phi_AG = angleBetween(V_A, V_AG);

v_a = norm(V_A);
v_ag = norm(V_AG);
% Eq 6
a1 = [sin(phi_AG)/v_ag, - v_a*cos(phi_AG)/v_ag, -1, 0, 0];
b1 = gamma_AG;

a2 = [-sin(phi_AG)/v_ag, v_a*cos(phi_AG)/v_ag, -1, 0, 0];
b2 = -gamma_AG;

AA = [a1;a2];
bb = [b1;b2];

end