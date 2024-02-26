function projectedgrad = Pr(val, lbound, ubound, grad)
    
    % Projection operation for and Upper and a Lower bound
    if(val > lbound) && (val < ubound)
        projectedgrad = grad;
    elseif(val == lbound) && (grad >= 0)
        projectedgrad = grad;
    elseif(val == ubound) && (grad <= 0)
        projectedgrad = grad;
    else
        projectedgrad = 0;
    end

end