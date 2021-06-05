function [z sol]=MyCost(q,model)

    global NFE;
    NFE=NFE+1;

    sol=ParseSolution(q,model);
    
    eta=model.eta;
    
    z1=eta*sol.TotalD+(1-eta)*sol.MaxD;
    
    beta=10;
    
    z=z1*(1+beta*sol.MeanCV);

end