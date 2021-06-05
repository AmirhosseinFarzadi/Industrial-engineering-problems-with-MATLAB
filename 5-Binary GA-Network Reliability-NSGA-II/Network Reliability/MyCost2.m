function [z sol]=MyCost2(s,model)

    sol=ParseSolution(s,model);
    
    C0=model.C0;
    C=sol.C;
    
    CV=max(0,C/C0-1);
    
    sol.CV=CV;
    sol.IsFeasible=sol.IsFeasible & (CV==0);
    
    z2=sol.z2;
    
    gamma=10;
    z=z2+gamma*CV;
    
end