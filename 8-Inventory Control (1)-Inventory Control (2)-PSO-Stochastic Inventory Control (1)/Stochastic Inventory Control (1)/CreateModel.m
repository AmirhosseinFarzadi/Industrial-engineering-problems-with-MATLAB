function model=CreateModel()

    Dmin=[80    75    62    75    76    79    79    68    78    72];
    Dmax=[85    85    98    82    94    83    95    85    94    99];
    
    I0=0;
    
    Imax=70;
    
    a=[123   140   140   130   136   122   128   139   136   140];
    b=[  7     2     9    10     8     8     8     5     7     3];
    
    H=size(Dmin,2);
    
    nSim=20;
    
    model.H=H;
    model.Dmin=Dmin;
    model.Dmax=Dmax;
    model.I0=I0;
    model.Imax=Imax;
    model.a=a;
    model.b=b;
    model.nSim=nSim;

end