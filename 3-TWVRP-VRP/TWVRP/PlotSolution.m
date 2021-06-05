function PlotSolution(sol,model)

    J=model.J;

    xmin=model.xmin;
    xmax=model.xmax;
    ymin=model.ymin;
    ymax=model.ymax;
    
    x=model.x;
    y=model.y;
    x0=model.x0;
    y0=model.y0;
    
    L=sol.L;
    
    Colors=hsv(J);
    
    for j=1:J
        
        if isempty(L{j})
            continue;
        end
        
        X=[x0 x(L{j}) x0];
        Y=[y0 y(L{j}) y0];
        
        Color=0.8*Colors(j,:);
        
        plot(X,Y,'-o',...
            'Color',Color,...
            'LineWidth',2,...
            'MarkerSize',10,...
            'MarkerFaceColor','white');
        hold on;
        
    end

    plot(x0,y0,'ks',...
        'LineWidth',2,...
        'MarkerSize',18,...
        'MarkerFaceColor','yellow');
    
    hold off;
    
end












