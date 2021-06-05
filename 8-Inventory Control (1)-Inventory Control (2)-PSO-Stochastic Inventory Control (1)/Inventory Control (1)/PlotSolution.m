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
    stairs(0:H,[I0 I],'LineWidth',2);
    hold on;
    plot([0 H],[Imax Imax],'r:','LineWidth',2);
    hold off;
    xlabel('Time');
    ylabel('Inventory');

end