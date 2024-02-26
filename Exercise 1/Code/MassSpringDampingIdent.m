function dstate = MassSpringDampingIdent(t, state)

    global k;
    global b;
    global m;
    global flag_proj;
    global lambda_1;
    global lambda_0;
    
    
    state = state(:);
    % gain parameters
    g = [1;0];
    g1 = 0.1;
    g2 = 550;
    g3 = 90;
    
    L = [-lambda_1,-lambda_0;
         1,0];

    u = 5*sin(2*t)+10.5;

    % States
    y2 = state(1);
    dy2 = state(2);
    w1 = state(3:4);
    w2 = state(5:6);
    k_est = state(7);
    m_est = state(8);
    b_est = state(9);

    
    % Plant Equations
    y1 = y2 + u/k;
    dstatey2 = [0,1;0,-b/m]*[y2; dy2] + [0;1/m]*u;
    dw1 = L*w1 + g*y2;
    dw2 = L*w2 + g*u;
    
    % Identification
    phi1 = y1 - y2;
    z1 = u;
    z1_est = k_est*phi1;
    phi2 = [y2 - [lambda_1,lambda_0]*w1; w1(1)];
    z2 = w2(2);
    z2_est = [m_est,b_est]*phi2;
    
    % Error estimation
    
    a = 1;
    e1 = z1 - z1_est;
    e2 = (z2 - z2_est)/(1 + a*(phi2(1).^2 + phi2(2).^2));

    % Adaptation Laws

    dk = g1*e1*phi1;
    dm = g2*e2*phi2(1);
    db = g3*e2*phi2(2);
    

    if flag_proj == 2

        dk = Pr(k_est,0.1,inf,dk);
        dm = Pr(m_est,10,inf,dm);
        db = Pr(b_est,0,1,db);
    end

    dstate = [dstatey2; dw1; dw2; dk; dm; db];
end

