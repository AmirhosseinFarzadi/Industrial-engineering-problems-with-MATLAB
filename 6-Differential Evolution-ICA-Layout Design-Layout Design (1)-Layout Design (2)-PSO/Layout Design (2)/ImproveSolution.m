function sol2=ImproveSolution(sol1,model,Vars)

    n=model.n;

    A=randperm(n);
    
    for i=A
        sol1=MoveMachine(i,sol1,model,Vars);
    end

    sol2=sol1;
    
end


function [sol2 z2]=MoveMachine(i,sol1,model,Vars)

    dmax=0.1;
    
    % Zero
    [newsol(1) z(1)]=RotateMachine(i,sol1,model);
    
    % Move Up
    newsol(2)=sol1;
    dy=unifrnd(0,dmax);
    newsol(2).yhat(i)=sol1.yhat(i)+dy;
    newsol(2).yhat(i)=max(newsol(2).yhat(i),Vars.yhat.Min);
    newsol(2).yhat(i)=min(newsol(2).yhat(i),Vars.yhat.Max);
    [newsol(2) z(2)]=RotateMachine(i,newsol(2),model);
    
    % Move Down
    newsol(3)=sol1;
    dy=unifrnd(0,dmax);
    newsol(3).yhat(i)=sol1.yhat(i)-dy;
    newsol(3).yhat(i)=max(newsol(3).yhat(i),Vars.yhat.Min);
    newsol(3).yhat(i)=min(newsol(3).yhat(i),Vars.yhat.Max);
    [newsol(3) z(3)]=RotateMachine(i,newsol(3),model);
    
    % Move Right
    newsol(4)=sol1;
    dx=unifrnd(0,dmax);
    newsol(4).xhat(i)=sol1.xhat(i)+dx;
    newsol(4).xhat(i)=max(newsol(4).xhat(i),Vars.xhat.Min);
    newsol(4).xhat(i)=min(newsol(4).xhat(i),Vars.xhat.Max);
    [newsol(4) z(4)]=RotateMachine(i,newsol(4),model);
    
    % Move Left
    newsol(5)=sol1;
    dx=unifrnd(0,dmax);
    newsol(5).xhat(i)=sol1.xhat(i)-dx;
    newsol(5).xhat(i)=max(newsol(5).xhat(i),Vars.xhat.Min);
    newsol(5).xhat(i)=min(newsol(5).xhat(i),Vars.xhat.Max);
    [newsol(5) z(5)]=RotateMachine(i,newsol(5),model);

    % Move Up-Right
    newsol(6)=sol1;
    dx=unifrnd(0,dmax);
    newsol(6).xhat(i)=sol1.xhat(i)+dx;
    newsol(6).xhat(i)=max(newsol(6).xhat(i),Vars.xhat.Min);
    newsol(6).xhat(i)=min(newsol(6).xhat(i),Vars.xhat.Max);
    dy=unifrnd(0,dmax);
    newsol(6).yhat(i)=sol1.yhat(i)+dy;
    newsol(6).yhat(i)=max(newsol(6).yhat(i),Vars.yhat.Min);
    newsol(6).yhat(i)=min(newsol(6).yhat(i),Vars.yhat.Max);
    [newsol(6) z(6)]=RotateMachine(i,newsol(6),model);

    % Move Up-Left
    newsol(7)=sol1;
    dx=unifrnd(0,dmax);
    newsol(7).xhat(i)=sol1.xhat(i)-dx;
    newsol(7).xhat(i)=max(newsol(7).xhat(i),Vars.xhat.Min);
    newsol(7).xhat(i)=min(newsol(7).xhat(i),Vars.xhat.Max);
    dy=unifrnd(0,dmax);
    newsol(7).yhat(i)=sol1.yhat(i)+dy;
    newsol(7).yhat(i)=max(newsol(7).yhat(i),Vars.yhat.Min);
    newsol(7).yhat(i)=min(newsol(7).yhat(i),Vars.yhat.Max);
    [newsol(7) z(7)]=RotateMachine(i,newsol(7),model);

    % Move Down-Right
    newsol(8)=sol1;
    dx=unifrnd(0,dmax);
    newsol(8).xhat(i)=sol1.xhat(i)+dx;
    newsol(8).xhat(i)=max(newsol(8).xhat(i),Vars.xhat.Min);
    newsol(8).xhat(i)=min(newsol(8).xhat(i),Vars.xhat.Max);
    dy=unifrnd(0,dmax);
    newsol(8).yhat(i)=sol1.yhat(i)-dy;
    newsol(8).yhat(i)=max(newsol(8).yhat(i),Vars.yhat.Min);
    newsol(8).yhat(i)=min(newsol(8).yhat(i),Vars.yhat.Max);
    [newsol(8) z(8)]=RotateMachine(i,newsol(8),model);

    % Move Down-Left
    newsol(9)=sol1;
    dx=unifrnd(0,dmax);
    newsol(9).xhat(i)=sol1.xhat(i)-dx;
    newsol(9).xhat(i)=max(newsol(9).xhat(i),Vars.xhat.Min);
    newsol(9).xhat(i)=min(newsol(9).xhat(i),Vars.xhat.Max);
    dy=unifrnd(0,dmax);
    newsol(9).yhat(i)=sol1.yhat(i)-dy;
    newsol(9).yhat(i)=max(newsol(9).yhat(i),Vars.yhat.Min);
    newsol(9).yhat(i)=min(newsol(9).yhat(i),Vars.yhat.Max);
    [newsol(9) z(9)]=RotateMachine(i,newsol(9),model);

    [z2 ind]=min(z);
    
    sol2=newsol(ind);
    
end

function [sol2 z2]=RotateMachine(i,sol1,model)

    newsol(1)=sol1;
    newsol(1).rhat(i)=0.1;
    z(1)=MyCost(newsol(1),model);
    
    newsol(2)=sol1;
    newsol(2).rhat(i)=0.35;
    z(2)=MyCost(newsol(2),model);

    newsol(3)=sol1;
    newsol(3).rhat(i)=0.6;
    z(3)=MyCost(newsol(3),model);

    newsol(4)=sol1;
    newsol(4).rhat(i)=0.85;
    z(4)=MyCost(newsol(4),model);
    
    [z2 ind]=min(z);
    
    sol2=newsol(ind);

end
