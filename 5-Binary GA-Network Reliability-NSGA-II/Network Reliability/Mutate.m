function y=Mutate(x,mu)

    Q=randi([1 3]);
    
    switch Q
        case 1
            y=BinaryMutate(x,mu);
            
        case 2
            y=Swap(x);
            
        case 3
            y=Reversion(x);
    end

end

function y=BinaryMutate(x,mu)

    nVar=numel(x);
    
    nmu=ceil(mu*nVar);
    
    j=randsample(nVar,nmu);
    
    y=x;
    y(j)=1-x(j);

end

function y=Swap(x)

    n=numel(x);
    
    i=randsample(n,2);
    i1=i(1);
    i2=i(2);

    y=x;
    y([i1 i2])=x([i2 i1]);
    
end

function y=Reversion(x)

    n=numel(x);
    
    i=randsample(n,2);
    i1=min(i);
    i2=max(i);

    y=x;
    y(i1:i2)=x(i2:-1:i1);
    
end