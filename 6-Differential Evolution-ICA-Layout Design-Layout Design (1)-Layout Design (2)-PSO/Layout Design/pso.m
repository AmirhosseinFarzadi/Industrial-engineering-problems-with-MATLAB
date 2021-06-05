clc;
clear;
close all;

%% Problem Definition

model=CreateModel();                        % Create Model

CostFunction=@(sol1) MyCost(sol1,model);	% Cost Function

Vars.xhat.Min=0;
Vars.xhat.Max=1;
Vars.xhat.Size=[1 model.n];
Vars.xhat.Count=prod(Vars.xhat.Size);
Vars.xhat.VelMax=0.1*(Vars.xhat.Max-Vars.xhat.Min);
Vars.xhat.VelMin=-Vars.xhat.VelMax;

Vars.yhat.Min=0;
Vars.yhat.Max=1;
Vars.yhat.Size=[1 model.n];
Vars.yhat.Count=prod(Vars.yhat.Size);
Vars.yhat.VelMax=0.1*(Vars.yhat.Max-Vars.yhat.Min);
Vars.yhat.VelMin=-Vars.yhat.VelMax;


%% PSO Parameters

MaxIt=500;      % Maximum Number of Iterations

nPop=100;        % Population Size (Swarm Size)

w=0.4;          % Inertia Weight
wdamp=1;        % Inertia Weight Damping Ratio
c1=1.5;         % Personal Learning Coefficient
c2=2;         % Global Learning Coefficient

% % Constriction Coefficients
% phi1=2.05;
% phi2=2.05;
% phi=phi1+phi2;
% chi=2/(phi-2+sqrt(phi^2-4*phi));
% w=chi;          % Inertia Weight
% wdamp=1;        % Inertia Weight Damping Ratio
% c1=chi*phi1;    % Personal Learning Coefficient
% c2=chi*phi2;    % Global Learning Coefficient


%% Initialization

empty_particle.Position=[];
empty_particle.Cost=[];
empty_particle.Sol=[];
empty_particle.Velocity=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];
empty_particle.Best.Sol=[];

particle=repmat(empty_particle,nPop,1);

GlobalBest.Cost=inf;

for i=1:nPop
    
    % Initialize Position
    particle(i).Position=CreateRandomSolution(model);
    
    % Initialize Velocity
    particle(i).Velocity.xhat=zeros(Vars.xhat.Size);
    particle(i).Velocity.yhat=zeros(Vars.yhat.Size);
    
    % Evaluation
    [particle(i).Cost particle(i).Sol]=CostFunction(particle(i).Position);
    
    % Update Personal Best
    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost;
    particle(i).Best.Sol=particle(i).Sol;
    
    % Update Global Best
    if particle(i).Best.Cost<GlobalBest.Cost
        
        GlobalBest=particle(i).Best;
        
    end
    
end

BestCost=zeros(MaxIt,1);


%% PSO Main Loop

for it=1:MaxIt
    
    for i=1:nPop
        
        % ---- Motion on xhat
        
        % Update Velocity
        particle(i).Velocity.xhat = w*particle(i).Velocity.xhat ...
            +c1*rand(Vars.xhat.Size).*(particle(i).Best.Position.xhat-particle(i).Position.xhat) ...
            +c2*rand(Vars.xhat.Size).*(GlobalBest.Position.xhat-particle(i).Position.xhat);
        
        % Apply Velocity Limits
        particle(i).Velocity.xhat = max(particle(i).Velocity.xhat,Vars.xhat.VelMin);
        particle(i).Velocity.xhat = min(particle(i).Velocity.xhat,Vars.xhat.VelMax);
        
        % Update Position
        particle(i).Position.xhat = particle(i).Position.xhat + particle(i).Velocity.xhat;
        
        % Velocity Mirror Effect
        IsOutside=(particle(i).Position.xhat<Vars.xhat.Min | particle(i).Position.xhat>Vars.xhat.Max);
        particle(i).Velocity.xhat(IsOutside)=-particle(i).Velocity.xhat(IsOutside);
        
        % Apply Position Limits
        particle(i).Position.xhat = max(particle(i).Position.xhat,Vars.xhat.Min);
        particle(i).Position.xhat = min(particle(i).Position.xhat,Vars.xhat.Max);
        
        % ---- Motion on yhat
        
        % Update Velocity
        particle(i).Velocity.yhat = w*particle(i).Velocity.yhat ...
            +c1*rand(Vars.yhat.Size).*(particle(i).Best.Position.yhat-particle(i).Position.yhat) ...
            +c2*rand(Vars.yhat.Size).*(GlobalBest.Position.yhat-particle(i).Position.yhat);
        
        % Apply Velocity Limits
        particle(i).Velocity.yhat = max(particle(i).Velocity.yhat,Vars.yhat.VelMin);
        particle(i).Velocity.yhat = min(particle(i).Velocity.yhat,Vars.yhat.VelMax);
        
        % Update Position
        particle(i).Position.yhat = particle(i).Position.yhat + particle(i).Velocity.yhat;
        
        % Velocity Mirror Effect
        IsOutside=(particle(i).Position.yhat<Vars.yhat.Min | particle(i).Position.yhat>Vars.yhat.Max);
        particle(i).Velocity.yhat(IsOutside)=-particle(i).Velocity.yhat(IsOutside);
        
        % Apply Position Limits
        particle(i).Position.yhat = max(particle(i).Position.yhat,Vars.yhat.Min);
        particle(i).Position.yhat = min(particle(i).Position.yhat,Vars.yhat.Max);

        % Evaluation
        [particle(i).Cost particle(i).Sol] = CostFunction(particle(i).Position);
        
        % Apply Mutation
        NewParticle=particle(i);
        NewParticle.Position=Mutate(particle(i).Position,Vars);
        [NewParticle.Cost NewParticle.Sol]=CostFunction(NewParticle.Position);
        if NewParticle.Cost<=particle(i).Cost || rand<0.1
            particle(i)=NewParticle;
        end
        
        % Update Personal Best
        if particle(i).Cost<particle(i).Best.Cost
            
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
            particle(i).Best.Sol=particle(i).Sol;
            
            % Update Global Best
            if particle(i).Best.Cost<GlobalBest.Cost
                
                GlobalBest=particle(i).Best;
                
            end
            
        end
        
    end
    
    BestCost(it)=GlobalBest.Cost;
    
    if GlobalBest.Sol.IsFeasible
        FLAG=' *';
    else
        FLAG='';
    end
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it)) FLAG]);
    
    w=w*wdamp;
    
    % Plot Solution
    figure(1);
    PlotSolution(GlobalBest.Sol,model);
    
end

%% Results

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');

