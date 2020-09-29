function [coeffs, gamma_flag] = obstacleAvoidanceLine(A,G,Obs)

l_b = G.Position - A.Position;
l_o = Obs.Position - A.Position;

% checking for intersection
gamma = angleBetween(l_b,l_o);
dist = norm(l_o) * sin(gamma);
gamma_flag = 1;
if gamma > pi/2
    gamma_flag = 0;
end
if dist < Obs.Radius    
    % Case 2; intersection
    theta = asin(dist/Obs.Radius);
    Point_P = l_o' * l_b / norm(l_b) * l_b / norm(l_b) - ...
                        Obs.Radius*cos(theta) * l_b / norm(l_b);
    Point_P = Point_P + A.Position;
    n_vec = Obs.Position - Point_P;
    n_vec = n_vec/norm(n_vec);
    % Line coefficients L : ax + by = c
    a = n_vec(1);
    b = n_vec(2);
    c = Point_P' * n_vec;
else
    % Case 1: No intersection
    theta = asin(dist/norm(l_o));
    Delta = dist - Obs.Radius;
    Point_P = l_o' * l_b / norm(l_b) * l_b / norm(l_b) + A.Position;
    n_vec =  Obs.Position - Point_P;
    n_vec = n_vec/norm(n_vec);
    % Line coefficients L : ax + by = c
    a = n_vec(1);
    b = n_vec(2);
    c = Delta + Point_P' * n_vec;
end

coeffs = [a,b,c];

end