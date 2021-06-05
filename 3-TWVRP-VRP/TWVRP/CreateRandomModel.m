function model=CreateRandomModel(I,J)

    rmin=10;
    rmax=25;
    r=randi([rmin rmax],1,I);
    
    TotalDemand=sum(r);
    cmean=TotalDemand/J;
    cmin=round(cmean);
    cmax=round(1.25*cmean);
    c=randi([cmin cmax],1,J);
    
    vmin=10;
    vmax=20;
    v=randi([vmin vmax],1,J);
    
    xmin=0;
    xmax=200;
    dx=xmax-xmin;
    
    ymin=0;
    ymax=100;
    dy=ymax-ymin;
    
    H=sqrt(dx^2+dy^2);
    T=H/mean(v);
    MaxTourTime=I/J*T;
    t1min=0;
    t1max=round(0.1*MaxTourTime);
    t2min=round(0.5*MaxTourTime);
    t2max=round(0.6*MaxTourTime);
    t1=randi([t1min t1max],1,I);
    t2=randi([t2min t2max],1,I);
    
    x=randi([xmin xmax],1,I);
    y=randi([ymin ymax],1,I);
    
    alpha_x=0.1;
    xm=(xmin+xmax)/2;
    x0min=round(xm-alpha_x*dx);
    x0max=round(xm+alpha_x*dx);
    
    alpha_y=0.1;
    ym=(ymin+ymax)/2;
    y0min=round(ym-alpha_y*dy);
    y0max=round(ym+alpha_y*dy);
    
    x0=randi([x0min x0max]);
    y0=randi([y0min y0max]);
    
    d=zeros(I,I);
    d0=zeros(1,I);
    for i=1:I
        for i2=i+1:I
            d(i,i2)=sqrt((x(i)-x(i2))^2+(y(i)-y(i2))^2);
            d(i2,i)=d(i,i2);
        end
        
        d0(i)=sqrt((x(i)-x0)^2+(y(i)-y0)^2);
    end
    
    eta=0.5;
    
    model.I=I;
    model.J=J;
    model.r=r;
    model.c=c;
    model.xmin=xmin;
    model.xmax=xmax;
    model.ymin=ymin;
    model.ymax=ymax;
    model.x=x;
    model.y=y;
    model.x0=x0;
    model.y0=y0;
    model.d=d;
    model.d0=d0;
    model.v=v;
    model.t1=t1;
    model.t2=t2;
    model.eta=eta;

end