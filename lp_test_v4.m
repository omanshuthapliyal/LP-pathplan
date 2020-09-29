clearvars;
close all; clc;
%%
% https://ieeexplore.ieee.org/document/1713757

%% PARAMS
dt = 0.5;               % s
M = 16;     % circle discretization

v_max = 70;             % cm/s
w_max = pi/3;           % rad/s
sigma = 2;
f_max = sigma * w_max * v_max;  % maximum allowable force
mu = sigma * w_max;
%% Populating Objects in the Environment
% Object radii
r_O1 = 40;              % cm
r_O2 = 40;              % cm
r_O3 = 40;              % cm
r_G = 20;               % cm

% A = vehicle([0;0],[0.10;0], mu, dt);
A1 = vehicle([0;0],[0.10;0], mu, dt, 0);
A2 = vehicle([700;0],[-0.10;0], mu, dt, 0);
A3 = vehicle([500;600],[0.5;-0], mu, dt, 0);
G = target([700;700],[13;-2], dt, r_G);
O_1 = obstacle([500;500],[-7;-6], dt, r_O1);
O_2 = obstacle([500;700],[8;-3], dt, r_O2);
O_3 = obstacle([700;500],[4;8], dt, r_O3);

% Limits & bounds
L_min = 30;                  % [cm]

tF = 22;        % [in s]
% Decision variable:
% [DV_x, DV_y, d_1, d_2, q_1, q_2]^T

plot(G.Position(1), G.Position(2), 'go','MarkerSize', G.Radius); hold on
plot(O_1.Position(1), O_1.Position(2), 'ko','MarkerSize', O_1.Radius);
plot(O_2.Position(1), O_2.Position(2), 'ko','MarkerSize', O_2.Radius);
plot(O_3.Position(1), O_3.Position(2), 'ko','MarkerSize', O_3.Radius);
for i = 1:round(tF/dt)
    % Stuff that occurs at every time step
    
    % Robot 1
    [x1,fval,exitflag] =  perTime(A1,G,O_1,O_2,O_3,f_max,M);
    F1 = [x1(1);x1(2)];
    
    % Robot 2
    [x2,fval,exitflag] =  perTime(A2,A1,O_1,O_2,O_3,f_max,M);
    F2 = [x2(1);x2(2)];
    
    % Robot 3
    [x3,fval,exitflag] =  perTime(A3,A1,O_1,O_2,O_3,f_max,M);
    F3 = [x3(1);x3(2)];
    
    x0_1 = A1.Position;
    x0_2 = A2.Position;
    x0_3 = A3.Position;
    A1.updatePos(F1);
    A2.updatePos(F2);
    A3.updatePos(F3);
    xf_1 = A1.Position;
    xf_2 = A2.Position;
    xf_3 = A3.Position;
    
    
    G.updatePos();
    O_1.updatePos();
    O_2.updatePos();
    O_3.updatePos();
    plot(A1.Position(1), A1.Position(2), 'b.','MarkerSize',8); hold on;
    plot(A2.Position(1), A2.Position(2), 'r.','MarkerSize',8);
    plot(A3.Position(1), A3.Position(2), 'g.','MarkerSize',8);
    
    plot([x0_1(1),xf_1(1)],[x0_1(2),xf_1(2)],'b-');
    plot([x0_2(1),xf_2(1)],[x0_2(2),xf_2(2)],'r-');
    plot([x0_3(1),xf_3(1)],[x0_3(2),xf_3(2)],'g-');
    
    if mod(i,2) == 0
        plot(G.Position(1), G.Position(2), 'go','MarkerSize', G.Radius);
        if mod(i,3) == 0
            plot(O_1.Position(1), O_1.Position(2), 'ko','MarkerSize', O_1.Radius);
            plot(O_2.Position(1), O_2.Position(2), 'ko','MarkerSize', O_2.Radius);
            plot(O_3.Position(1), O_3.Position(2), 'ko','MarkerSize', O_3.Radius);
        end
        axis equal;
        grid on;
        
    end
end
%%
quiver(500,500,O_1.Position(1)-500, O_1.Position(2)-500,0,...
    'LineWidth', 1.5 , 'LineStyle', '-');
quiver(500,700,O_2.Position(1)-500, O_2.Position(2)-700,0,...
    'LineWidth', 1.5 , 'LineStyle', '-');
quiver(700,500,O_3.Position(1)-700, O_3.Position(2)-500,0,...
    'LineWidth', 1.5 , 'LineStyle', '-');
quiver(700,700,G.Position(1)-700, G.Position(2)-700,0,...
    'LineWidth', 1.5 , 'LineStyle', '-');
grid minor
