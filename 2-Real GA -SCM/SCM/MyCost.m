function [z sol2]=MyCost(sol1,model)

    sol2=ParseSolution(sol1,model);
    
    z=sol2.FinalCost;

end