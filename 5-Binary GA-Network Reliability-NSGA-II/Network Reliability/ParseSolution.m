function sol=ParseSolution(s,model)

    N=model.N;
    c=model.c;
    p=model.p;
    q=1-p;

    x=ConvertVectorToMatrix(s);

    C=0;
    for i=1:N
        for j=i+1:N
            C=C+c(i,j)*x(i,j);
        end
    end

    u=CalcDisconnectivity(x);   % Connectivity Violation
    
    d=sum(x,1);                 % Graph Degree Sequence
    
    v=mean(d<2);                % 2-Connectivity Violation
    
    % H is the Jan's Upper Bound
    H=1;
    for i=1:N
        
        mi=min(d(i),i-1);
        
        dH=q^d(i);
        
        if mi>=1
            dH=dH*(1-q^(d(i)-1))^mi;
        end
        
        if i-1>=mi+1
            dH=dH*(1-q^d(i))^(i-1-mi);
        end
        
        H=H-dH;
        
    end
    
    % Approximate Reliability
    R=H;
    
    Violation=u+v;
    
    alpha=sum(c(:));
    z1=C+alpha*Violation;
    
    beta=5;
    z2=(1-R)+beta*Violation;
    
    sol.x=x;
    sol.C=C;
    sol.R=R;
    sol.u=u;
    sol.d=d;
    sol.v=v;
    sol.IsFeasible=(Violation==0);
    sol.z1=z1;
    sol.z2=z2;
    
end