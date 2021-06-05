function model=CreateModel()

    r=10;
    theta=linspace(0,2*pi,21);
    theta(end)=[];
    
    x=r*cos(theta);
    y=r*sin(theta);
    
    N=numel(x);
    
    d=zeros(N,N);
    for i=1:N
        for j=i+1:N
            d(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            d(j,i)=d(i,j);
        end
    end
    
    UnitDistaceCost=10;
    
    c=UnitDistaceCost*d;
    
    p=0.9;
    
    R0=0.85;

    Cmean=mean(c(:))*N*(N-1)/2;
    C0=round(0.7*Cmean);
    
    model.N=N;
    model.x=x;
    model.y=y;
    model.d=d;
    model.c=c;
    model.p=p;
    model.R0=R0;
    model.C0=C0;

end