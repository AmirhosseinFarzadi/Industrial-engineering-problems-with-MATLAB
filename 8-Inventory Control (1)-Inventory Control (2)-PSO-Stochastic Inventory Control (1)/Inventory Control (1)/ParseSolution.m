function sol=ParseSolution(xhat,model)

    H=model.H;
    D=model.D;
    I0=model.I0;
    Imax=model.Imax;
    a=model.a;
    b=model.b;
    
    Xmin=0;
    Xmax=3*Imax;

    X=min(floor(Xmin+(Xmax-Xmin+1)*xhat),Xmax);
    
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
    
    sol.X=X;
    sol.I=I;
    sol.SumAX=SumAX;
    sol.SumBI=SumBI;
    sol.VMIN=VMIN;
    sol.VMAX=VMAX;
    sol.IsFeasible=(VMIN==0 && VMAX==0);
    
end