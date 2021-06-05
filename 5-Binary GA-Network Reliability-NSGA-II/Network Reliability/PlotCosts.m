function PlotCosts(pop)

    Costs=[pop.Cost];
    
    semilogy(Costs(1,:),Costs(2,:),'r*','MarkerSize',8);
    xlabel('1st Objective');
    ylabel('2nd Objective');
    grid on;

end