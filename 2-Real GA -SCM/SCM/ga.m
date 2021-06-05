clc;
clear;
close all;

%% Problem Definition

model=CreateModel();             % Create Model

CostFunction=@(sol) MyCost(sol,model);     % Cost Function

Vars.xhat.Size=[model.J model.I];
Vars.xhat.Count=prod(Vars.xhat.Size);
Vars.xhat.Min=0;
Vars.xhat.Max=1;

Vars.yhat.Size=[model.K model.J];
Vars.yhat.Count=prod(Vars.yhat.Size);
Vars.yhat.Min=0;
Vars.yhat.Max=1;

%% GA Parameters

MaxIt=1200;      % Maximum Number of Iterations

nPop=100;        % Population Size

pc=0.8;                 % Crossover Percentage
nc=2*round(pc*nPop/2);  % Number of Offsprings (Parnets)

pm=0.3;                 % Mutation Percentage
nm=round(pm*nPop);      % Number of Mutants

beta=10;                % Selection Pressure

gamma=0.05;

mu=0.02;         % Mutation Rate

%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.Sol=[];

pop=repmat(empty_individual,nPop,1);

for i=1:nPop
    
    % Initialize Position
    pop(i).Position=CreateRandomSolution(model);
    
    % Evaluation
    [pop(i).Cost pop(i).Sol]=CostFunction(pop(i).Position);
    
end

% Sort Population
Costs=[pop.Cost];
[Costs, SortOrder]=sort(Costs);
pop=pop(SortOrder);

% Store Best Solution
BestSol=pop(1);

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

% Store Cost
WorstCost=pop(end).Cost;


%% Main Loop

for it=1:MaxIt
    
    % Calculate Selection Probabilities
    P=exp(-beta*Costs/WorstCost);
    P=P/sum(P);
    
    % Crossover
    popc=repmat(empty_individual,nc/2,2);
    for k=1:nc/2
        
        % Select Parents Indices
        i1=RouletteWheelSelection(P);
        i2=RouletteWheelSelection(P);

        % Select Parents
        p1=pop(i1);
        p2=pop(i2);
        
        % Apply Crossover
        [popc(k,1).Position popc(k,2).Position]=...
            Crossover(p1.Position,p2.Position,gamma,Vars);
        
        % Evaluate Offsprings
        [popc(k,1).Cost popc(k,1).Sol]=CostFunction(popc(k,1).Position);
        [popc(k,2).Cost popc(k,2).Sol]=CostFunction(popc(k,2).Position);
        
    end
    popc=popc(:);
    
    
    % Mutation
    popm=repmat(empty_individual,nm,1);
    for k=1:nm
        
        % Select Parent
        i=randi([1 nPop]);
        p=pop(i);
        
        % Apply Mutation
        popm(k).Position=Mutate(p.Position,mu,Vars);
        
        % Evaluate Mutant
        [popm(k).Cost popm(k).Sol]=CostFunction(popm(k).Position);
        
    end
    
    % Create Merged Population
    pop=[pop
         popc
         popm];
     
    % Sort Population
    Costs=[pop.Cost];
    [Costs, SortOrder]=sort(Costs);
    pop=pop(SortOrder);
    
    % Update Worst Cost
    WorstCost=max(WorstCost,pop(end).Cost);
    
    % Truncation
    pop=pop(1:nPop);
    Costs=Costs(1:nPop);
    
    % Store Best Solution Ever Found
    BestSol=pop(1);
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    if BestSol.Sol.IsFeasible
        FLAG=' *';
    else
        FLAG=[', V = ' num2str(BestSol.Sol.Violation)];
    end
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it)) FLAG]);
    
end

%% Results

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Cost');
