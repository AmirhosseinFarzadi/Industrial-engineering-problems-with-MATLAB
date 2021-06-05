function [child1 child2]=Crossover(parent1,parent2,gamma,Vars)

    child1=parent1;
    child2=parent2;

    q=randi([1 3]);
    
    if q==1 || q==3
        % Apply Crossover to xhat
        [child1.xhat child2.xhat]=...
            ArithmeticCrossover(parent1.xhat,parent2.xhat,gamma,Vars.xhat.Min,Vars.xhat.Max);
    end
    
    if q==2 || q==3
        % Apply Crossover to yhat
        [child1.yhat child2.yhat]=...
            ArithmeticCrossover(parent1.yhat,parent2.yhat,gamma,Vars.yhat.Min,Vars.yhat.Max);
    end


end

function [y1 y2]=ArithmeticCrossover(x1,x2,gamma,VarMin,VarMax)

    alpha=unifrnd(-gamma,1+gamma,size(x1));
    
    y1=alpha.*x1+(1-alpha).*x2;
    y2=alpha.*x2+(1-alpha).*x1;
    
    y1=max(y1,VarMin);
    y1=min(y1,VarMax);
    
    y2=max(y2,VarMin);
    y2=min(y2,VarMax);

end