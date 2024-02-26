function sigma = switchingSigma(val, M0, sigma_fixed, q0)
    
    %switchingSigma operation for an Upper bound M0 and integer q0
    q0 = abs(q0);
    val = val(:);
    
    theta_norm = norm(val,2);
    if(theta_norm <= M0)
        sigma = 0;
    elseif (theta_norm > M0) && (theta_norm <= 2*M0)
        sigma = sigma_fixed*(theta_norm/M0-1)^q0;
    else
        sigma = sigma_fixed;
    end

end