function h=CalcDisconnectivity(A)

    n=size(A,1);

    B=logical((eye(n)+A)^(n-1));
    
    h=1-mean(B(:));

end