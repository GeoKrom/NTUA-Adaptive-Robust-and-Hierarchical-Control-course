function dstate = SSPM(t, state)

    global Ap
    global Am
    global Bp
    global P

   state = state(:);
   G1 = [1 0;
         0 1];
   G2 = [1 0;
         0 1];
    
   % States
   x = state(1:2);
   x_est = state(3:4);
   Ap_est = [state(5) state(7);
             state(6) 0];
   Bp_est = state(8:9);

   % Estimated Error
   e = x - x_est;

   % Input signal
   u = 10*sin(2*t);
   % u = 10*sin(2*t) + 7*cos(3.6*t);
   
   dx = Ap*x +Bp*u;
   dx_est = -Am*e + Ap_est*x + Bp_est*u;
   
   dA = G1*P*e*x';
   dB = G2*P*e*u;

   dstate = [dx; dx_est; dA(1,1); dA(2,1); dA(1,2); dB];

end