clc;
clear;
close all;

global NFE;
NFE=0;

%% Problem Definition

model=CreateModel();        % Create Model of the Problem

CostFunction=@(q) MyCost(q,model);       % Cost Function

nVar=model.nVar;        % Number of Decision Variables

VarSize=[1 nVar];       % Size of Decision Variables Matrix


%% SA Parameters

MaxIt=250;      % Maximum Number of Iterations

MaxIt2=20;      % Maximum Number of Inner Iterations

T0=10;          % Initial Temperature

alpha=0.98;     % Temperature Damping Rate


%% Initialization

% Create Initial Solution
x.Position=CreateRandomSolution(model);
[x.Cost x.Sol]=CostFunction(x.Position);

% Update Best Solution Ever Found
BestSol=x;

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

% Array to Hold NFEs
nfe=zeros(MaxIt,1);

% Set Initial Temperature
T=T0;


%% SA Main Loop

for it=1:MaxIt
    for it2=1:MaxIt2
        
        % Create Neighbor
        xnew.Position=CreateNeighbor(x.Position);
        [xnew.Cost xnew.Sol]=CostFunction(xnew.Position);
        
        if xnew.Cost<=x.Cost
            % xnew is better, so it is accepted
            x=xnew;
            
        else
            % xnew is not better, so it is accepted conditionally
            delta=xnew.Cost-x.Cost;
            p=exp(-delta/T);
            
            if rand<=p
                x=xnew;
            end
            
        end
        
        % Update Best Solution
        if x.Cost<=BestSol.Cost
            BestSol=x;
        end
        
    end
    
    % Store Best Cost
    BestCost(it)=BestSol.Cost;
    
    % Store NFE
    nfe(it)=NFE;
    
    % Display Iteration Information
    disp(['Iteration ' num2str(it) ': NFE = ' num2str(nfe(it)) ', Best Cost = ' num2str(BestCost(it))]);
    
    % Reduce Temperature
    T=alpha*T;
    
    % Plot Solution
    figure(1);
    PlotSolution(BestSol.Sol,model);
    
end

%% Results

figure;
plot(nfe,BestCost,'LineWidth',2);
xlabel('NFE');
ylabel('Best Cost');

