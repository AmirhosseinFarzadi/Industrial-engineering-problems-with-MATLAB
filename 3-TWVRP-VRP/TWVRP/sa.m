clc;
clear;
close all;

global NFE;
NFE=0;

%% Problem Definition

model=SelectModel();        % Select Model of the Problem

model.eta=0.1;

CostFunction=@(q) MyCost(q,model);       % Cost Function


%% SA Parameters

MaxIt=1200;      % Maximum Number of Iterations

MaxIt2=80;      % Maximum Number of Inner Iterations

T0=100;          % Initial Temperature

alpha=0.99;     % Temperature Damping Rate


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
    if BestSol.Sol.IsFeasible
        FLAG=' *';
    else
        FLAG='';
    end
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it)) FLAG]);
    
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

