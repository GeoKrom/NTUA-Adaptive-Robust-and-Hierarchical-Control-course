function dstate = UnmodeledDynamics2(t, state)

    global theta
    global M0
    global mi
    global omega
    global lambda
    global sigma0
    global delta0
    global flag_signal
    global q0

    % Input signal
    c0 = 1;
    u = sin(omega*t)+c0*(1-sign(omega));
    
    % System states
    state = state(:);
    eta = state(1:2);
    nd = state(3);
    w1 = state(4);
    w2 = state(5);
    theta_est = state(6);

    % Plant
    theta_star = theta + sin(0.1*t);

    if mi > 0
        deta = [0 1; -1/mi^2 -2/mi]*eta + [10; -30/mi]*u;
    else
        deta = zeros(2,1);
    end
    
    y = theta_star*u + [1,0]*eta;
    
    % Apply Filter
    dw1 = -lambda*w1 + y;
    dw2 = -lambda*w2 + u;
    phi = w2;

    % Dynamic Normalization
    a0 = 0;
    a1 = 0.1;
    delta = 1;
    dnd = -delta0*nd + delta*u.^2;
    
    % Static Normalization
    ms2 = 1 + a0*phi^2 + a1*nd;
    
    % Adaptation laws
    g = 7500;
    z = w1;
    z_est = theta_est*phi;
    e = (z - z_est)/ms2;

    if flag_signal == 1
        dtheta_est = g*(e*phi - switchingSigma(theta_est, M0, sigma0, q0)*theta_est);
    elseif flag_signal == 2
        dtheta_est = robustPr(theta_est, M0, g*e*phi);
    end    

    dstate = [deta; dnd; dw1; dw2; dtheta_est];

end

