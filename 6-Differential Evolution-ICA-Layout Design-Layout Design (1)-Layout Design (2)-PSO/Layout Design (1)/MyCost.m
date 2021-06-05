function [z sol]=MyCost(sol1,model)

    sol=ParseSolution(sol1,model);
    
    z=sol.z;

end