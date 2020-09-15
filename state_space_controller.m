%% Parameters and stability
close all;
A = [ 0   1   0
     980  0  -2.8
      0   0  -100 ];

B = [ 0
      0
      100 ];

C = [ 1 0 0 ];

D = 0;

poles = eig(A);

%% Open-loop system

t = 0:0.01:2;
r = zeros(size(t));
x0 = [0.01 0 0];

sys = ss(A, B, C, 0);
figure(1)
h = pzplot(sys);
title('$Pole$ $Zero$ $Plot$ $of$ $Open-loop$ $System$', 'Interpreter', 'latex')
xlabel('$Real$ $Axis$ $(seconds^{-1})$')
h.AxesGrid.XUnits = ''; 
ylabel('$Imaginary$ $Axis$ $(seconds^{-1})$')
h.AxesGrid.YUnits = ''; 
h.AxesGrid.BackgroundAxes.Title.Interpreter = 'Latex';
h.AxesGrid.BackgroundAxes.XLabel.Interpreter = 'Latex'; 
h.AxesGrid.BackgroundAxes.YLabel.Interpreter = 'Latex'; 

[y, t] = lsim(sys, r, t, x0);
figure(2)
plot(t,y)
legend('$h$', 'Interpreter', 'latex')
title('$Open-Loop$ $Response$', 'Interpreter', 'latex')
xlabel('$Time(sec)$', 'Interpreter', 'latex')
y = ylabel('$h(m)$', 'Interpreter', 'latex', 'rotation', 0);
set(y, 'Units', 'Normalized', 'Position', [-0.08, 0.5]);

%% Full state feedback with zero reference input

p1 = -10 + 10i;
p2 = -10 - 10i;
p3 = -50;

K = place(A,B,[p1 p2 p3]);
sys_cl = ss(A-B*K, B, C, 0);
figure(3)
h = pzplot(sys_cl);
title('$Pole$ $Zero$ $Plot$ $of$ $Closed-loop$ $System$', 'Interpreter', 'latex')
xlabel('$Real$ $Axis$ $(seconds^{-1})$')
h.AxesGrid.XUnits = ''; 
ylabel('$Imaginary$ $Axis$ $(seconds^{-1})$')
h.AxesGrid.YUnits = ''; 
h.AxesGrid.BackgroundAxes.Title.Interpreter = 'Latex';
h.AxesGrid.BackgroundAxes.XLabel.Interpreter = 'Latex'; 
h.AxesGrid.BackgroundAxes.YLabel.Interpreter = 'Latex'; 

[y, t] = lsim(sys_cl, r, t, x0);
figure(4);
plot(t, y);
legend('$h$', 'Interpreter', 'latex')
title('$Full$ $State$ $Feedback$ $Control$ $without$ $Reference$ $Input$', 'Interpreter', 'latex')
xlabel('$Time(sec)$', 'Interpreter', 'latex')
y = ylabel('$h(m)$', 'Interpreter', 'latex', 'rotation', 0);
set(y, 'Units', 'Normalized', 'Position', [-0.08, 0.5]);

%% Full state feedback with reference input

r = 0.001*ones(size(t));
Nbar = rscale(A, B, C, 0, K);
sys_cl = ss(A-B*K, B, C, 0);

[y, t] = lsim(sys_cl,Nbar*r,t);
figure(5);
plot(t, y)
hold on;
plot(t, r)
legend('$h$', '$h_d$', 'Interpreter', 'latex')
title('$Full$ $State$ $Feedback$ $Control$ $with$ $Reference$ $Input$', 'Interpreter', 'latex')
xlabel('$Time(sec)$', 'Interpreter', 'latex')
y = ylabel('$h(m)$', 'Interpreter', 'latex', 'rotation', 0);
set(y, 'Units', 'Normalized', 'Position', [-0.11, 0.5]);
axis([0 2 0 1.2*10^-3])