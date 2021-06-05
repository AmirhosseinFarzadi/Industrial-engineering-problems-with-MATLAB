function sol2=ParseSolution(sol1,model)

    n=model.n;
    w=model.w;
    h=model.h;
    delta=model.delta;
    W=model.W;
    H=model.H;
    a=model.a;

    xhat=sol1.xhat;
    xmin=w/2+delta;
    xmax=W-xmin;
    x=xmin+(xmax-xmin).*xhat;
    
    yhat=sol1.yhat;
    ymin=h/2+delta;
    ymay=H-ymin;
    y=ymin+(ymay-ymin).*yhat;
    
    xl=x-w/2;
    yl=y-h/2;
    xu=x+w/2;
    yu=y+h/2;
    
    xin=x+model.xin;
    yin=y+model.yin;
    xout=x+model.xout;
    yout=y+model.yout;
    
    d=zeros(n,n);
    V=zeros(n,n);
    for i=1:n
        for j=i+1:n
            d(i,j)=norm([xout(i)-xin(j) yout(i)-yin(j)],1);
            d(j,i)=norm([xout(j)-xin(i) yout(j)-yin(i)],1);
            
            DELTA=max(delta(i),delta(j));
            
            XVij=max(0,1-abs(x(i)-x(j))/((w(i)+w(j))/2+DELTA));
            YVij=max(0,1-abs(y(i)-y(j))/((h(i)+h(j))/2+DELTA));
            
            V(i,j)=min(XVij,YVij);
            V(j,i)=V(i,j);
        end
    end
    
    v=mean(V(:));
    
    ad=a.*d;
    
    SumAD=sum(ad(:));
    
    beta=10;
    z=SumAD*(1+beta*v);

    sol2.x=x;
    sol2.y=y;
    sol2.xl=xl;
    sol2.yl=yl;
    sol2.xu=xu;
    sol2.yu=yu;
    sol2.xin=xin;
    sol2.yin=yin;
    sol2.xout=xout;
    sol2.yout=yout;
    sol2.d=d;
    sol2.ad=ad;
    sol2.SumAD=SumAD;
    sol2.V=V;
    sol2.v=v;
    sol2.IsFeasible=(v==0);
    sol2.z=z;
    
end