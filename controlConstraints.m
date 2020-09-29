function [AA,bb] = controlConstraints(f_max,M)

% Eq 4
% X = [fx, fy, d(t)]'
m = 0:M-1;
AA = [sin(2*pi*m/M)', cos(2*pi*m/M)', zeros(M,1)];
bb = f_max*ones(M,1);

end