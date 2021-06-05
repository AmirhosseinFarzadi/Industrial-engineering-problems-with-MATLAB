function sol=ParseSolution(q,model)

    I=model.I;
    J=model.J;
    d=model.d;
    d0=model.d0;
    r=model.r;
    c=model.c;
    
    DelPos=find(q>I);
    
    From=[0 DelPos]+1;
    To=[DelPos I+J]-1;
    
    L=cell(J,1);
    D=zeros(1,J);
    UC=zeros(1,J);
    for j=1:J
        L{j}=q(From(j):To(j));
        
        if ~isempty(L{j})
            
            D(j)=d0(L{j}(1));
            
            for k=1:numel(L{j})-1
                D(j)=D(j)+d(L{j}(k),L{j}(k+1));
            end
            
            D(j)=D(j)+d0(L{j}(end));
            
            
            UC(j)=sum(r(L{j}));
        end
    end
    
    CV=max(UC./c-1,0);
    
    MeanCV=mean(CV);
    
    sol.L=L;
    sol.D=D;
    sol.MaxD=max(D);
    sol.TotalD=sum(D);
    sol.UC=UC;
    sol.CV=CV;
    sol.MeanCV=MeanCV;
    sol.IsFeasible=(MeanCV==0);
    
end