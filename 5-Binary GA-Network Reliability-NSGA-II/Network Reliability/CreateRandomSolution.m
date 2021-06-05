function s=CreateRandomSolution(model)

    N=model.N;
    
    s=randi([0 1],1,N*(N-1)/2);

end