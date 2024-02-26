%% Parameter Identification of a Mass - Spring - Dumping system
%  Course: Adaptive, Robust and Hierarchical Control

clc;
clear;

global k;
global b;
global m;
global flag_proj;
global lambda_1;
global lambda_0;


%% Parameter Settings

m = 15;
b = 0.2;
k = 2;
lambda_1 = 3;
lambda_0 = 2;

m0 = 10;
b0 = 0;
k0 = 0.1;
state0 = [zeros(6,1);k0;m0;b0];
tspan = [0 60];
opt = odeset('RelTol',1e-13,'AbsTol',1e-9);


%% System Simulation
flag_proj = 1;
[t, x] = ode45(@MassSpringDampingIdent, tspan, state0, opt);


%% Plots
figure(1);
clf;

subplot(3,1,1);
plot(t, x(:,7),'r-');
hold on;
yline(k,'b--');
xlabel('$t [sec]$','Interpreter','latex');
ylabel('$k$','interpreter','latex');
legend('$\hat{k}$','$k_d$','Location','northeast','interpreter','latex');
grid on;

subplot(3,1,2);
plot(t, x(:,8), 'r-');
hold on;
yline(m, 'b--');
xlabel('$t [sec]$','Interpreter','latex');
ylabel('$m$','interpreter','latex');
legend('$\hat{m}$','$m_d$','Location','northeast','interpreter','latex');
grid on;

subplot(3,1,3);
plot(t, x(:,9),'r-');
hold on;
yline(b,'b--');
xlabel('$t [sec]$','Interpreter','latex');
ylabel('$b$','interpreter','latex');
legend('$\hat{b}$','$b_d$','Location','northeast','interpreter','latex');
grid on;



%% System Simulation
flag_proj = 2;
[t, x] = ode45(@MassSpringDampingIdent, tspan, state0, opt);

%% Plots
figure(2);
clf;

subplot(3,1,1);
plot(t, x(:,7),'r-');
hold on;
yline(k,'b--');
xlabel('$t [sec]$','Interpreter','latex');
ylabel('$k$','interpreter','latex');
legend('$\hat{k}$','$k_d$','Location','northeast','interpreter','latex');
grid on;

subplot(3,1,2);
plot(t, x(:,8), 'r-');
hold on;
yline(m, 'b--');
xlabel('$t [sec]$','Interpreter','latex');
ylabel('$m$','interpreter','latex');
legend('$\hat{m}$','$m_d$','Location','northeast','interpreter','latex');
grid on;

subplot(3,1,3);
plot(t, x(:,9),'r-');
hold on;
yline(b,'b--');
xlabel('$t [sec]$','Interpreter','latex');
ylabel('$b$','interpreter','latex');
legend('$\hat{b}$','$b_d$','Location','northeast','interpreter','latex');
grid on;