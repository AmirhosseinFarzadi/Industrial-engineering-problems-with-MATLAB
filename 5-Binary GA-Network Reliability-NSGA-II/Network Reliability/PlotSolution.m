function PlotSolution(sol,model)

    N=model.N;
    x=sol.x;
    
    for i=1:N
        for j=i+1:N
            if x(i,j)==1
                plot([model.x(i) model.x(j)],...
                    [model.y(i) model.y(j)],...
                    'b:','LineWidth',2);
                hold on;
            end
        end
    end
    
    plot(model.x,model.y,'ko','MarkerFaceColor','y','MarkerSize',16);
    
    hold off;

    axis equal;
    
end