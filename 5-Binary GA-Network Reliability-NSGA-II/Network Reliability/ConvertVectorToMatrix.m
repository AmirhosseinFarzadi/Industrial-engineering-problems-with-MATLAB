function x=ConvertVectorToMatrix(s)

    M=numel(s);
    
    N=(sqrt(8*M+1)+1)/2;
    
    x=zeros(N,N);
    
    for i=1:N-1
        k=N-i;
        x(i,i+1:end)=s(1:k);
        x(i+1:end,i)=s(1:k);
        s(1:k)=[];
    end

end