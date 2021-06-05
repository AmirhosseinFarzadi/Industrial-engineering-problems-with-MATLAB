function sol2=ParseSolution(sol1,model)

    n=model.n;
    delta=model.delta;
    W=model.W;
    H=model.H;
    a=model.a;

    rhat=sol1.rhat;
    r=min(floor(4*rhat),3);
    theta=r*pi/2;
    
    w=abs(cos(theta)).*model.w+abs(sin(theta)).*model.h;
    h=abs(cos(theta)).*model.h+abs(sin(theta)).*model.w;
    
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
    
    xin=x+cos(theta).*model.xin-sin(theta).*model.yin;
    yin=y+cos(theta).*model.yin+sin(theta).*model.xin;
    xout=x+cos(theta).*model.xout-sin(theta).*model.yout;
    yout=y+cos(theta).*model.yout+sin(theta).*model.xout;
    
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
    
    XMIN=min(xl);
    YMIN=min(yl);
    XMAX=max(xu);
    YMAX=max(yu);
    
    ContainerArea=(XMAX-XMIN)*(YMAX-YMIN);
    MachinesArea=sum(w.*h);
    UnusedArea=max(ContainerArea-MachinesArea,0);
    UnusedAreaRatio=UnusedArea/ContainerArea;
    UnusedAreaCost=model.phi*UnusedAreaRatio;
    
    %beta=100;
    %z=SumAD*(1+beta*v);
    
    alpha=1e12;
    z=SumAD+UnusedAreaCost+alpha*v;

    sol2.r=r;
    sol2.theta=theta;
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
    sol2.XMIN=XMIN;
    sol2.YMIN=YMIN;
    sol2.XMAX=XMAX;
    sol2.YMAX=YMAX;
    sol2.ContainerArea=ContainerArea;
    sol2.MachinesArea=MachinesArea;
    sol2.UnusedArea=UnusedArea;
    sol2.UnusedAreaRatio=UnusedAreaRatio;
    sol2.UnusedAreaCost=UnusedAreaCost;
    sol2.V=V;
    sol2.v=v;
    sol2.IsFeasible=(v==0);
    sol2.z=z;
    
end