%% State Space Parametric Model Example
%  Parameter Identification
%  Course: Adaptive, Robust and Hierarchical Control

clc
clear

global Ap
global Bp
global Am
global P

%% Set Parameters

Ap = [-0.25 3;
     -5    0];
Bp = [1;
     2.2];
Am = [-5 0;
      0 -5];

Q = eye(2);
P = lyap(Am',Q);

%% Simulation

state0 = zeros(9,1);
tspan = [0 60];
opt = odeset('RelTol',1e-11,'AbsTol',1e-8);

[t, x] = ode45(@SSPM, tspan, state0, opt);


figure(1);
clf;

subplot(2,1,1);
plot(t, x(:,1),'r-');
xlabel('$t [sec]$','interpreter','latex');
ylabel('$x_1$','interpreter','latex');
grid on;

subplot(2,1,2);
plot(t, x(:,2),'r-');
grid on;
xlabel('$t [sec]$','interpreter','latex');
ylabel('$x_2$','interpreter','latex');


figure(2);
clf;

subplot(2,1,1);
plot(t, x(:,3),'r-');
xlabel('$t [sec]$','interpreter','latex');
ylabel('$\hat{x}_1$','interpreter','latex');
grid on;

subplot(2,1,2);
plot(t, x(:,4),'r-');
grid on;
xlabel('$t [sec]$','interpreter','latex');
ylabel('$\hat{x}_2$','interpreter','latex');


figure(3);
clf;

subplot(2,1,1);
plot(t, x(:,1)-x(:,3),'r-');
xlabel('$t [sec]$','interpreter','latex');
ylabel('$e_1$','interpreter','latex');
grid on;

subplot(2,1,2);
plot(t, x(:,2)-x(:,4),'r-');
grid on;
xlabel('$t [sec]$','interpreter','latex');
ylabel('$e_2$','interpreter','latex');

figure(4);
clf;

subplot(5,1,1)
plot(t, x(:,5),'r-')
hold on
yline(Ap(1,1),'b--');
xlabel('$t [sec]$','interpreter','latex');
ylabel('$a_{11}$','interpreter','latex');
grid on;
legend('$\hat{a}_{11}$','$a_{11}$','Location','northeast','interpreter','latex');

subplot(5,1,2);
plot(t, x(:,6),'r-');
hold on;
yline(Ap(2,1),'b--');
xlabel('$t [sec]$','interpreter','latex');
ylabel('$a_{21}$','interpreter','latex');
grid on;
legend('$\hat{a}_{21}$','$a_{21}$','Location','northeast','interpreter','latex');

subplot(5,1,3);
plot(t, x(:,7),'r-');
hold on;
yline(Ap(1,2),'b--');
xlabel('$t [sec]$','interpreter','latex');
ylabel('$a_{12}$','interpreter','latex');
grid on;
legend('$\hat{a}_{12}$','$a_{12}$','Location','southeast','interpreter','latex');

subplot(5,1,4);
plot(t, x(:,8),'r-');
hold on;
yline(Bp(1),'b--');
xlabel('$t [sec]$','interpreter','latex');
ylabel('$b_{1}$','interpreter','latex');
grid on;
legend('$\hat{b}_1$','$b_1$','Location','southeast','interpreter','latex');

subplot(5,1,5);
plot(t, x(:,9),'r-');
hold on;
yline(Bp(2),'b--');
xlabel('$t [sec]$','interpreter','latex');
ylabel('$b_{2}$','interpreter','latex');
grid on;
legend('$\hat{b}_2$','$b_2$','Location','southeast','interpreter','latex');