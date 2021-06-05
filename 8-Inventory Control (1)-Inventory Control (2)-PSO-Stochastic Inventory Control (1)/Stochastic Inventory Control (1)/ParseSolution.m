function sol=ParseSolution(xhat,model)

    H=model.H;
    Dmin=model.Dmin;
    Dmax=model.Dmax;

    Xmin=0;
    Xmax=3*model.Imax;
    X=min(floor(Xmin+(Xmax-Xmin+1)*xhat),Xmax);

    nSim=model.nSim;
    
    results=cell(nSim,1);
    
    for s=1:nSim
        D=unifrnd(Dmin,Dmax);
        results{s}=SimulateScenario(D,X,model);
    end
    
    results=cell2mat(results);
    
    sol.X=X;
    
    D=reshape([results.D],H,[])';
    sol.D.Mean=mean(D);
    sol.D.Std=std(D);
    sol.D.Min=min(D);
    sol.D.Max=max(D);
    
    I=reshape([results.I],H,[])';
    sol.I.Mean=mean(I);
    sol.I.Std=std(I);
    sol.I.Min=min(I);
    sol.I.Max=max(I);

    sol.SumAX.Mean=mean([results.SumAX]);
    sol.SumAX.Std=std([results.SumAX]);
    sol.SumAX.Min=min([results.SumAX]);
    sol.SumAX.Max=max([results.SumAX]);
    
    sol.SumBI.Mean=mean([results.SumBI]);
    sol.SumBI.Std=std([results.SumBI]);
    sol.SumBI.Min=min([results.SumBI]);
    sol.SumBI.Max=max([results.SumBI]);
    
    sol.VMIN.Mean=mean([results.VMIN]);
    sol.VMIN.Std=std([results.VMIN]);
    sol.VMIN.Min=min([results.VMIN]);
    sol.VMIN.Max=max([results.VMIN]);

    sol.VMAX.Mean=mean([results.VMAX]);
    sol.VMAX.Std=std([results.VMAX]);
    sol.VMAX.Min=min([results.VMAX]);
    sol.VMAX.Max=max([results.VMAX]);
    
    sol.Feasibility=mean([results.IsFeasible]);
    
    sol.z.Mean=mean([results.z]);
    sol.z.Std=std([results.z]);
    sol.z.Min=min([results.z]);
    sol.z.Max=max([results.z]);
    
    sol.results=results;
    
end