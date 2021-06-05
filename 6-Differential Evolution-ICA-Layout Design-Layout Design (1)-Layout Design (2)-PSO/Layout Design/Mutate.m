function newsol=Mutate(sol,Vars)

    newsol=sol;

    sigma=0.1*(Vars.xhat.Max-Vars.xhat.Min);
    j=randi([1 Vars.xhat.Count]);
    dxhat=sigma*randn;
    newsol.xhat(j)=sol.xhat(j)+dxhat;
    newsol.xhat=max(newsol.xhat,Vars.xhat.Min);
    newsol.xhat=min(newsol.xhat,Vars.xhat.Max);

    sigma=0.1*(Vars.yhat.Max-Vars.yhat.Min);
    j=randi([1 Vars.yhat.Count]);
    dyhat=sigma*randn;
    newsol.yhat(j)=sol.yhat(j)+dyhat;
    newsol.yhat=max(newsol.yhat,Vars.yhat.Min);
    newsol.yhat=min(newsol.yhat,Vars.yhat.Max);
    
end