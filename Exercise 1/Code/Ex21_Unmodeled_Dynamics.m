%% Unmodelled Dynamics Identification 2
%  Course: Adaptive, Robust and Hierarchical Control

clear;
clc;

global theta
global M0
global mi
global omega
global lambda
global sigma0
global delta0
global flag_signal
global q0


%% Parameter Settings

mi_matrix = [0,0.1,0.01];
omega_matrix = [0,1,10,100];
lambda = 1;
delta0 = 1;
sigma0 = 3;
M0 = 6;
q0 = 2;
theta = 5;
state0 = zeros(6,1);
tspan = [0 120];
opt = odeset('RelTol',1e-13,'AbsTol',1e-9);


%% System Simulation with Switching Modification Algorithm
flag_signal = 1;

for mi = mi_matrix
    for  omega = 100 
        [t,x] = ode45(@UnmodeledDynamics2, tspan, state0, opt);
        figure;
        clf;
        
        plot(t, x(:,6), 'r-')
        hold on;
        plot(t, theta+sin(0.1*t),'b-');
        grid on;
        xlabel('$t [sec]$','FontSize',15,'interpreter','latex');
        ylabel('$\theta$','FontSize',15,'interpreter','latex');
        legend('$\hat{\theta}$', '$\theta_d$', 'Location', 'northeast', 'interpreter', 'latex');
    end
end



%% System Simulation with Robust Projection Algorithm

flag_signal = 2;

for mi = mi_matrix
    for  omega = 100 
        [t,x] = ode45(@UnmodeledDynamics2, tspan, state0, opt);
        figure;
        clf;
        
        plot(t, x(:,6), 'r-')
        hold on;
        plot(t, theta+sin(0.1*t),'b-');
        grid on;
        xlabel('$t [sec]$','FontSize',15,'interpreter','latex');
        ylabel('$\theta$','FontSize',15,'interpreter','latex');
        legend('$\hat{\theta}$', '$\theta_d$', 'Location', 'northeast', 'interpreter', 'latex');
    end
end