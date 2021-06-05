function model=CreateModel()

    w=[23 24 12 24 20 11 14 18];
    h=[25 25 12 25 25 17 22 12];
    delta=[1 0 3 0 2 0 3 0];
    rin=[0.1712  0.7060  0.7318  0.2769  0.0462  0.0971  0.4235  0.6948];
    rout=[0.3171  0.9502  0.0344  0.4387  0.3816  0.7655  0.7952  0.1869];
    
    n=numel(w);

    xin=zeros(1,n);
    yin=zeros(1,n);
    
    xout=zeros(1,n);
    yout=zeros(1,n);

    for i=1:n
        if rin(i)>=0 && rin(i)<=0.25
            xin(i)=(4*rin(i)-0.5)*w(i);
            yin(i)=-h(i)/2;
            
        elseif rin(i)>0.25 && rin(i)<=0.5
            xin(i)=w(i)/2;
            yin(i)=(4*rin(i)-1.5)*h(i);
            
        elseif rin(i)>0.5 && rin(i)<=0.75
            xin(i)=(2.5-4*rin(i))*w(i);
            yin(i)=h(i)/2;
            
        else
            xin(i)=-w(i)/2;
            yin(i)=(3.5-4*rin(i))*h(i);
            
        end
        
        if rout(i)>=0 && rout(i)<=0.25
            xout(i)=(4*rout(i)-0.5)*w(i);
            yout(i)=-h(i)/2;
            
        elseif rout(i)>0.25 && rout(i)<=0.5
            xout(i)=w(i)/2;
            yout(i)=(4*rout(i)-1.5)*h(i);
            
        elseif rout(i)>0.5 && rout(i)<=0.75
            xout(i)=(2.5-4*rout(i))*w(i);
            yout(i)=h(i)/2;
            
        else
            xout(i)=-w(i)/2;
            yout(i)=(3.5-4*rout(i))*h(i);
            
        end
        
    end
    
    a=[ 0  50  45  20   0  19  46  15
       28   0  13  15  24  27  25  48
       13  28   0   0  31  12   0  49
        0  14  20   0  26  47  41  33
       47  49  42  33   0  48  25  12
       16  10  27  32  19   0  19   0
       43  41  47  15  15  30   0  24
       32   0  17  44  17  23  13   0];
    
    W=100;
    H=80;
    
    phi=50000;
    
    model.n=n;
    model.w=w;
    model.h=h;
    model.delta=delta;
    model.rin=rin;
    model.xin=xin;
    model.yin=yin;
    model.rout=rout;
    model.xout=xout;
    model.yout=yout;
    model.a=a;
    model.W=W;
    model.H=H;
    model.phi=phi;

end