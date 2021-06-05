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


%% ICA Parameters

MaxIt=400;          % Maximum Number of Iterations

nPop=100;           % Population Size
nEmp=10;            % Number of Empires/Imperialists

alpha=1;            % Selection Pressure

beta=2;             % Assimilation Coefficient

pRevolution=0.3;    % Revolution Probability
mu=0.05;            % Revolution Rate

zeta=0.1;           % Colonies Mean Cost Coefficient

ShareSettings;


%% Initialization

% Initialize Empires
emp=CreateInitialEmpires();

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);


%% ICA Main Loop

for it=1:MaxIt
    
    % Assimilation
    emp=AssimilateColonies(emp);
    
    % Revolution
    emp=DoRevolution(emp);
    
    % Intra-Empire Competition
    emp=IntraEmpireCompetition(emp);
    
    % Update Total Cost of Empires
    emp=UpdateTotalCost(emp);
    
    % Inter-Empire Competition
    emp=InterEmpireCompetition(emp);
    
    % Update Best Solution Ever Found
    imp=[emp.Imp];
    [~, BestImpIndex]=min([imp.Cost]);
    BestSol=imp(BestImpIndex);
    
    % Update Best Cost
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Plot Best Solution
    figure(1);
    PlotSolution(BestSol.Sol,model);

end

%% Results

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');


