function PlotSolution(sol,model)

    H=model.H;
    I0=model.I0;
    Imax=model.Imax;
    
    
    X=sol.X;
    I=sol.I;

    subplot(2,1,1);
    stairs(0:H,[X 0],'LineWidth',2);
    xlabel('Time');
    ylabel('Order Amount');
    
    subplot(2,1,2);
    stairs(0:H,[I0 I.Mean],'LineWidth',2);
    hold on;
    stairs(0:H,[I0 I.Mean+I.Std],'k--','LineWidth',1);
    stairs(0:H,[I0 I.Mean-I.Std],'k--','LineWidth',1);
    stairs(0:H,[I0 I.Mean+3*I.Std],'m:','LineWidth',1);
    stairs(0:H,[I0 I.Mean-3*I.Std],'m:','LineWidth',1);
    plot([0 H],[Imax Imax],'r:','LineWidth',2);
    hold off;
    xlabel('Time');
    ylabel('Inventory');

end