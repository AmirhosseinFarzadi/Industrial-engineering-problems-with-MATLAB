function sol1=CreateRandomSolution(model)

    n=model.n;
    
    sol1.xhat=rand(1,n);
    sol1.yhat=rand(1,n);
    sol1.rhat=rand(1,n);

end