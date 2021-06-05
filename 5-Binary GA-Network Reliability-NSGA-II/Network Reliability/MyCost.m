function [z sol]=MyCost(s,model)

    sol=ParseSolution(s,model);
    
    z1=sol.z1;
    z2=sol.z2;
    
    z=[z1
       z2];

end