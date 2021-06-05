function model=CreateModel()

    PredList={[],[],[],[],[1 2 4],[2 3 4],4,5,5,[6 7],7,[8 10],[9 10 11],[12 13]};
    
    t=[21 23 13 11 15 12 25 10 22 30 22 20 13 23];

    N=numel(t);
    
    R=[6     7
       5     6
       5     4
       0     6
       6     4
       6     3
       0     1
       5     2
       1     1
       5     1
       2     0
       5     8
       5     6
       7     1];
    
    nR=size(R,2);
    
    Rmax=[8 10];
    
    model.N=N;
    model.t=t;
    model.PredList=PredList;
    model.nR=nR;
    model.R=R;
    model.Rmax=Rmax;
    
end