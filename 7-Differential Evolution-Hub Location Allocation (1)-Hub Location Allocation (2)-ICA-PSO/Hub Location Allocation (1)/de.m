clc;
clear;
close all;

%% Problem Definition

model=SelectModel();                        % Select Model

CostFunction=@(xhat) MyCost(xhat,model);    % Cost Function

VarSize=[model.N model.N];      % Decision Variables Matrix Size

nVar=prod(VarSize);             % Number of Decision Variables

VarMin=0;          % Lower Bound of Decision Variables
VarMax=1;          % Upper Bound of Decision Variables


%% DE Parameters

MaxIt=500;      % Maximum Number of Iterations

nPop=200;        % Population Size

beta_min=0.8;   % Lower Bound of Scaling Factor
beta_max=1.5;   % Upper Bound of Scaling Factor

pCR=0.2;        % Crossover Probability

%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.Sol=[];

BestSol.Cost=inf;

pop=repmat(empty_individual,nPop,1);

for i=1:nPop

    pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    [pop(i).Cost pop(i).Sol]=CostFunction(pop(i).Position);
    
    if pop(i).Cost<BestSol.Cost
        BestSol=pop(i);
    end
    
end

BestCost=zeros(MaxIt,1);

%% DE Main Loop

for it=1:MaxIt
    
    for i=1:nPop
        
        x=pop(i).Position;
        
        A=randperm(nPop);
        
        A(A==i)=[];
        
        a=A(1);
        b=A(2);
        c=A(3);
        
        % Mutation
        beta=unifrnd(beta_min,beta_max,VarSize);
        y=pop(a).Position+beta.*(pop(b).Position-pop(c).Position);
        
        % Apply Variables Bound
        y=max(y,VarMin);
        y=min(y,VarMax);
        
        % Crossover
        z=zeros(size(x));
        j0=randi([1 numel(x)]);
        for j=1:numel(x)
            if j==j0 || rand<=pCR
                z(j)=y(j);
            else
                z(j)=x(j);
            end
        end
        
        NewSol.Position=z;
        [NewSol.Cost NewSol.Sol]=CostFunction(NewSol.Position);
        
        % Mutation
        NewSol2=NewSol;
        NewSol2.Position=Mutate(NewSol.Position);
        [NewSol2.Cost NewSol2.Sol]=CostFunction(NewSol2.Position);
        if NewSol2.Cost<=NewSol.Cost
            NewSol=NewSol2;
        end
        
        if NewSol.Cost<pop(i).Cost
            pop(i)=NewSol;
            
            if pop(i).Cost<BestSol.Cost
               BestSol=pop(i);
            end
        end
        
    end
    
    % Local Search using Mutation
    for k=1:10
        
        NewSol=BestSol;
        NewSol.Position=Mutate(BestSol.Position);
        [NewSol.Cost NewSol.Sol]=CostFunction(NewSol.Position);
        
        if NewSol.Cost<=BestSol.Cost
            BestSol=NewSol;
        end
        
    end
    
    % Update Best Cost
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Plot Best Solution
    figure(1);
    PlotSolution(BestSol.Sol,model);
    
end

%% Show Results

figure;
plot(BestCost);

