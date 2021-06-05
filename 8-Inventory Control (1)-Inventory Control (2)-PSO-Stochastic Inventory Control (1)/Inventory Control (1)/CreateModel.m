function model=CreateModel()

    D=[69    75    27    75    58    25    36    53    78    78];
    
    I0=0;
    
    Imax=70;
    
    a=[123   140   140   130   136   122   128   139   136   140];
    b=[  7     2     9    10     8     8     8     5     7     3];
    
    H=size(D,2);
    
    model.H=H;
    model.D=D;
    model.I0=I0;
    model.Imax=Imax;
    model.a=a;
    model.b=b;

end