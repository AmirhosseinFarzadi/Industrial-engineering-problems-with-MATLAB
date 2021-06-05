function sol2=ImproveSolution(sol1,model,Vars)

    z0=MyCost(sol1,model);

    n=model.n;

    A=randperm(n);
    
    for i=A
        [sol1 z0]=MoveMachine(i,sol1,z0,model,Vars);
    end

    sol2=sol1;
    
end


function [sol2 z2]=MoveMachine(i,sol1,z0,model,Vars)

    dmax=0.1;
    
    % Zero
    newsol(1)=sol1;
    z(1)=z0;
    
    % Move Up
    newsol(2)=sol1;
    dy=unifrnd(0,dmax);
    newsol(2).yhat(i)=sol1.yhat(i)+dy;
    newsol(2).yhat(i)=max(newsol(2).yhat(i),Vars.yhat.Min);
    newsol(2).yhat(i)=min(newsol(2).yhat(i),Vars.yhat.Max);
    z(2)=MyCost(newsol(2),model);
    
    % Move Down
    newsol(3)=sol1;
    dy=unifrnd(0,dmax);
    newsol(3).yhat(i)=sol1.yhat(i)-dy;
    newsol(3).yhat(i)=max(newsol(3).yhat(i),Vars.yhat.Min);
    newsol(3).yhat(i)=min(newsol(3).yhat(i),Vars.yhat.Max);
    z(3)=MyCost(newsol(3),model);
    
    % Move Right
    newsol(4)=sol1;
    dx=unifrnd(0,dmax);
    newsol(4).xhat(i)=sol1.xhat(i)+dx;
    newsol(4).xhat(i)=max(newsol(4).xhat(i),Vars.xhat.Min);
    newsol(4).xhat(i)=min(newsol(4).xhat(i),Vars.xhat.Max);
    z(4)=MyCost(newsol(4),model);
    
    % Move Left
    newsol(5)=sol1;
    dx=unifrnd(0,dmax);
    newsol(5).xhat(i)=sol1.xhat(i)-dx;
    newsol(5).xhat(i)=max(newsol(5).xhat(i),Vars.xhat.Min);
    newsol(5).xhat(i)=min(newsol(5).xhat(i),Vars.xhat.Max);
    z(5)=MyCost(newsol(5),model);


    [z2 ind]=min(z);
    
    sol2=newsol(ind);
    
end