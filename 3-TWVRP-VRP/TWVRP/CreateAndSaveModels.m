function CreateAndSaveModels()

    I=[8 10 14 20 25 30 40 50 60 70];
    J=[3  3  4  4  5  5  6  7  7  8];
    
    nModel=numel(I);
    
    for k=1:nModel
        
        model=CreateRandomModel(I(k),J(k));
        
        ModelName=['vrp_' num2str(model.I) 'x' num2str(model.J)];
        
        save(ModelName,'model');
        
    end

end