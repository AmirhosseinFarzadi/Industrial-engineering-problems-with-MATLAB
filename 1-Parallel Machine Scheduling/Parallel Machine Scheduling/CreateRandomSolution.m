function q=CreateRandomSolution(model)

    nVar=model.nVar;
    
    q=randperm(nVar);

end