function child=Mutate(parnet,mu,Vars)

    child=parnet;
    
    q=randi([1 3]);
    
    if q==1 || q==3
        % Apply Mutation to xhat
        child.xhat=NormalMutate(parnet.xhat,mu,Vars.xhat.Min,Vars.xhat.Max);
    end

    if q==2 || q==3
        % Apply Mutation to yhat
        child.yhat=NormalMutate(parnet.yhat,mu,Vars.yhat.Min,Vars.yhat.Max);
    end
    
end

function y=NormalMutate(x,mu,VarMin,VarMax)

    nVar=numel(x);
    
    nmu=ceil(mu*nVar);
    
    j=randsample(nVar,nmu);
    
    sigma=0.1*(VarMax-VarMin);
    
    y=x;
    y(j)=x(j)+sigma*randn(size(j));
    
    y=max(y,VarMin);
    y=min(y,VarMax);

end