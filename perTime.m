function [x,fval,exitflag] = perTime(A,G,O_1,O_2,O_3,f_max,M)

[A_1,b_1] = obstacleConstraints(A,G,O_1);
[A_2,b_2] = obstacleConstraints(A,G,O_2);
[A_3,b_3] = obstacleConstraints(A,G,O_3);

[A_4,b_4] = controlConstraints(f_max,M);

[A_5, b_5] = targetConstraints(A,G,M);
                                
                                
A_T = [A_1;A_2;A_3;A_4;A_5];
b_T = [b_1;b_2;b_3;b_4;b_5];                                
% X = [fx, fy, d(t)]'

f = [0,0,1];

[x, fval, exitflag] = linprog(f, A_T, b_T);

end