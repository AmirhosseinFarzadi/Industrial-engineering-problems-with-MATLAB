function [z sol]=MyCost(xhat,model)

    sol=ParseSolution(xhat,model);
    
    eta=100;
    
    z=sol.z.Mean+eta*sol.z.Std;

end