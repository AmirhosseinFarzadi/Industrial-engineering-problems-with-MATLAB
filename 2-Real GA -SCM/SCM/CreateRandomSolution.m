function sol1=CreateRandomSolution(model)

    I=model.I;
    J=model.J;
    K=model.K;
    
    sol1.xhat=rand(J,I);
    sol1.yhat=rand(K,J);
    
end