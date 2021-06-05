function [z sol]=MyCost1(s,model)

    sol=ParseSolution(s,model);
    
    R0=model.R0;
    R=sol.R;
    
    RV=max(0,1-R/R0);
    
    sol.RV=RV;
    sol.IsFeasible=sol.IsFeasible & (RV==0);
    
    z1=sol.z1;
    
    gamma=10;
    z=z1*(1+gamma*RV);
    
end