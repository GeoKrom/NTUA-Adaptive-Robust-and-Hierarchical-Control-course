function dstate = UnmodeledDynamics1(t, state)
    
    global a
    global b
    global mi
    global tau
    global lambda
    global delta0
    global sigma
    global flag_signal


    input_time = max(t - tau, 0);

    if flag_signal == 1
        u_real = 4*sin(2*input_time);
        u = 4*sin(2*t);
    elseif flag_signal == 2
        u_real = 2*sin(100*input_time);
        u = 2*sin(100*t);
    end


    % States
    state = state(:);
    x = state(1:2);
    nd = state(3);
    w1 = state(4);
    w2 = state(5);
    a_est = state(6);
    b_est = state(7);


    % Plant
    dx = [0 1; a/mi a-1/mi]*x + [0;b/mi]*u_real;
    y = x(1);

    % Dynamic Normalization
    delta = .2;
    dnd = -delta0*nd + delta*u.^2;

    % Apply Filter
    dw1 = -lambda*w1 + y;
    dw2 = -lambda*w2 + u;
    phi = [w1; w2];
    
    % Static Normalization
    a0 = .01;
    a1 = .1;
    ms2 = 1 + a0*(phi(1).^2 + phi(2).^2) + a1*nd;
    
    % Adaptation laws
    g1 = 25;
    g2 = 25;
    
    z = y - lambda*w1;
    z_est = a_est*phi(1) + b_est*phi(2);
    e = (z - z_est)/ms2;

    da_est = g1*(e*phi(1) - sigma*a_est);
    db_est = g2*(e*phi(2) - sigma*b_est);
    
    dstate = [dx; dnd; dw1; dw2; da_est; db_est];
end