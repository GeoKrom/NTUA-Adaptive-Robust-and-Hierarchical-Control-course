%% Unmodelled Dynamics Identification 1
%  Course: Adaptive, Robust and Hierarchical Control

clear;
clc;


global a
global b
global mi
global tau
global lambda
global delta0
global sigma
global flag_signal


%% Parameter Settings

a = -5;
b = 100;
mi = 0.001;
tau = 0.01;

lambda = 1;
delta0 = 0.5*lambda;
sigma = 1.0e-05;
state0 = zeros(7,1);
tspan = [0 60];

%% System Simulation 1
flag_signal = 1;
opt = odeset('RelTol',1e-13,'AbsTol',1e-9);
[t, x] = ode45(@UnmodeledDynamics1, tspan, state0, opt);

%% Plots
figure(1);
clf;

subplot(2,1,1);
plot(t, x(:,6), 'r-');
hold on;
yline(a,'b--');
grid on;
xlabel('$t [sec]$','FontSize',15,'interpreter','latex');
ylabel('$a$','FontSize',15,'interpreter','latex');
legend('$\hat{a}$', '$a_d$','Location','northeast','interpreter','latex');

subplot(2,1,2);
plot(t, x(:,7), 'r-');
hold on ;
yline(b,'b--');
grid on;
ylim([0 110]);
xlabel('$t [sec]$','FontSize',15,'interpreter','latex');
ylabel('$b$','FontSize',15,'interpreter','latex');
legend('$\hat{b}$', '$b_d$','Location','northeast','interpreter','latex');


%% System Simulation 2

flag_signal = 2;
[t, x] = ode45(@UnmodeledDynamics1, tspan, state0, opt);

%% Plots
figure(2);
clf;

subplot(2,1,1);
plot(t, x(:,6),'r-');
hold on;
yline(a,'b--');
grid on;
xlabel('$t [sec]$','FontSize',15,'interpreter','latex');
ylabel('$a$','FontSize',15,'interpreter','latex')
legend('$\hat{a}$', '$a_d$','Location','northeast','interpreter','latex');

subplot(2,1,2);
plot(t, x(:,7), 'r-');
hold on;
yline(b,'b--');
grid on;
ylim([0 110]);
xlabel('$t [sec]$','FontSize',15,'interpreter','latex');
ylabel('$b$','FontSize',15,'interpreter','latex');
legend('$\hat{b}$', '$b_d$','Location','northeast','interpreter','latex');

