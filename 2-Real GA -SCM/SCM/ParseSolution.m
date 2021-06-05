function sol2=ParseSolution(sol1,model)

    I=model.I;
    J=model.J;
    K=model.K;
    R=model.R;
    D=model.D;
    P=model.P;
    a=model.a;
    b=model.b;

    xhat=sol1.xhat;
    yhat=sol1.yhat;
    
    x=zeros(J,I);
    for i=1:I
        x(:,i)=R(i)*xhat(:,i)/sum(xhat(:,i));
    end
    
    y=zeros(K,J);
    for j=1:J
        y(:,j)=min(D(j),sum(x(j,:)))*yhat(:,j)/sum(yhat(:,j));
    end
    
    u=max(sum(x,2)'./D-1,0);
    umean=mean(u);
    
    v=max(sum(y,2)'./P-1,0);
    vmean=mean(v);
    
    Violation=(umean+vmean)/2;
    
    AX=a.*x;
    SumAX=sum(AX(:));
    
    BY=b.*y;
    SumBY=sum(BY(:));
    
    TotalCost=SumAX+SumBY;
    
    beta=10;
    FinalCost=TotalCost*(1+beta*Violation);
    
    sol2.x=x;
    sol2.y=y;
    sol2.u=u;
    sol2.umean=umean;
    sol2.v=v;
    sol2.vmean=vmean;
    sol2.Violation=Violation;
    sol2.IsFeasible=(Violation==0);
    sol2.SumAX=SumAX;
    sol2.SumBY=SumBY;
    sol2.TotalCost=TotalCost;   % z
    sol2.FinalCost=FinalCost;   % z' (z Prime)
    
end