function [z sol]=MyCost(q,model)

    global NFE;
    NFE=NFE+1;

    sol=ParseSolution(q,model);
    
    z=sol.Cmax;

end