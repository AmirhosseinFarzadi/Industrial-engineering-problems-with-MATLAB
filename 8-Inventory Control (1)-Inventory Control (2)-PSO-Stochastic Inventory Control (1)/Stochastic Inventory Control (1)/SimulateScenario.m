function result=SimulateScenario(D,X,model)

    H=model.H;
    I0=model.I0;
    Imax=model.Imax;
    a=model.a;
    b=model.b;

    I=zeros(1,H);
    for t=1:H
        if t==1
            PreviousInventory=I0;
        else
            PreviousInventory=I(t-1);
        end
        
        I(t)=PreviousInventory+X(t)-D(t);
    end

    VMIN=mean(max(0,-I));
    VMAX=mean(max(I/Imax-1,0));
    
    SumAX=sum(a.*X);
    SumBI=sum(b.*I);
    
    alpha=100000;
    beta=10;
    z=((SumAX+SumBI)+alpha*VMIN)*(1+beta*VMAX);
    
    result.D=D;
    result.I=I;
    result.SumAX=SumAX;
    result.SumBI=SumBI;
    result.VMIN=VMIN;
    result.VMAX=VMAX;
    result.IsFeasible=double(VMIN==0 && VMAX==0);
    result.z=z;

end