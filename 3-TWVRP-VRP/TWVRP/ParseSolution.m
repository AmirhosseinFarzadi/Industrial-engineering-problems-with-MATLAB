function sol=ParseSolution(q,model)

    I=model.I;
    J=model.J;
    d=model.d;
    d0=model.d0;
    r=model.r;
    c=model.c;
    v=model.v;
    t1=model.t1;
    t2=model.t2;
    
    DelPos=find(q>I);
    
    From=[0 DelPos]+1;
    To=[DelPos I+J]-1;
    
    L=cell(J,1);
    D=zeros(1,J);
    UC=zeros(1,J);
    AT=zeros(1,I);
    for j=1:J
        L{j}=q(From(j):To(j));
        
        if ~isempty(L{j})
            
            D(j)=d0(L{j}(1));
            
            for k=1:numel(L{j})
                AT(L{j}(k))=D(j)/v(j);
                
                if k<numel(L{j})
                    D(j)=D(j)+d(L{j}(k),L{j}(k+1));
                end
            end
            
            D(j)=D(j)+d0(L{j}(end));
            
            
            UC(j)=sum(r(L{j}));
        end
    end
    
    CV=max(UC./c-1,0);
    MeanCV=mean(CV);
    
    TWV=zeros(1,I);
    for i=1:I
        TWV(i)=max([0 1-AT(i)/t1(i) AT(i)/t2(i)-1]);
    end
    MeanTWV=mean(TWV);
    
    sol.L=L;
    sol.D=D;
    sol.MaxD=max(D);
    sol.TotalD=sum(D);
    sol.AT=AT;
    sol.UC=UC;
    sol.CV=CV;
    sol.MeanCV=MeanCV;
    sol.TWV=TWV;
    sol.MeanTWV=MeanTWV;
    sol.IsFeasible=(MeanCV==0 && MeanTWV==0);
    
end