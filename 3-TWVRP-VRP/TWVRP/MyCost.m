function [z sol]=MyCost(q,model)

    global NFE;
    NFE=NFE+1;

    sol=ParseSolution(q,model);
    
    eta=model.eta;
    
    z1=eta*sol.TotalD+(1-eta)*sol.MaxD;
    
    beta1=2;    % Capacity Constraint
    beta2=10;   % Time Window Constraint
    
    z=z1*(1 + beta1*sol.MeanCV + beta2*sol.MeanTWV);

end