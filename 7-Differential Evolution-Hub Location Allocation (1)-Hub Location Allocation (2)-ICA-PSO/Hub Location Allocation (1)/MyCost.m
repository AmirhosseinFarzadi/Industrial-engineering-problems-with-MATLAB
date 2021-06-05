function [z sol]=MyCost(xhat,model)

    sol=ParseSolution(xhat,model);

    w1=1;
    w2=1;
    
    z=w1*sol.SumOCR+w2*sol.SumXF;

end