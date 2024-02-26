function projectedgrad = robustPr(theta, M0, grad)
    %Projection operation for and Upper bound of the Norm of theta
    
    theta_norm = norm(theta,2);
    
    if(theta_norm < M0)
        projectedgrad = grad;
    elseif(theta_norm == M0) && (grad*theta <= 0)
        projectedgrad = grad;
    else
        projectedgrad = 0;
    end

end