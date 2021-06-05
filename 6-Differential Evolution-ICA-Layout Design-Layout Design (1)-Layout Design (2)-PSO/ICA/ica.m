clc;
clear;
close all;

%% Problem Definition

CostFunction=@(x) Sphere(x);        % Cost Function

nVar=5;             % Number of Decision Variables

VarSize=[1 nVar];   % Decision Variables Matrix Size

VarMin=-10;         % Lower Bound of Variables
VarMax= 10;         % Upper Bound of Variables


%% ICA Parameters

MaxIt=500;          % Maximum Number of Iterations

nPop=50;            % Population Size
nEmp=10;            % Number of Empires/Imperialists

alpha=1;            % Selection Pressure

beta=2;             % Assimilation Coefficient

pRevolution=0.1;    % Revolution Probability
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
    
end

%% Results

figure;
semilogy(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');


