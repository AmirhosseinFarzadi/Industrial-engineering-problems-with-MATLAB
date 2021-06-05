function emp=DoRevolution(emp)

    global ProblemSettings;
    CostFunction=ProblemSettings.CostFunction;
    nVar=ProblemSettings.nVar;
    VarSize=ProblemSettings.VarSize;
    VarMin=ProblemSettings.VarMin;
    VarMax=ProblemSettings.VarMax;
    
    global ICASettings;
    pRevolution=ICASettings.pRevolution;
    
    nEmp=numel(emp);
    for k=1:nEmp
        
        NewImp=emp(k).Imp;
        NewImp.Position=Mutate(emp(k).Imp.Position);
        NewImp.Cost=CostFunction(NewImp.Position);
        if NewImp.Cost<emp(k).Imp.Cost
            emp(k).Imp = NewImp;
        end
        
        for i=1:emp(k).nCol
            if rand<=pRevolution
                emp(k).Col(i).Position = Mutate(emp(k).Col(i).Position);
                [emp(k).Col(i).Cost emp(k).Col(i).Sol]= CostFunction(emp(k).Col(i).Position);
            end
        end
    end

end