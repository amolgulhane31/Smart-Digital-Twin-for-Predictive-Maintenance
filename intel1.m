clc;
clear;
close all;

%% ================================
% 1. USER INPUT
%% ================================
V = input('Enter input voltage (e.g. 1 for normal, 0.6 for low): ');

%% ================================
% 2. SYSTEM PARAMETERS (DC MOTOR)
%% ================================
J  = 0.01;    
B  = 0.1;     % Healthy friction
Kt = 0.01;    
Ke = 0.01;    
R  = 1;       
L  = 0.5;     

%% ================================
% 3. FULL ORDER MODEL (HEALTHY)
%% ================================
A = [-B/J    Kt/J;
     -Ke/L  -R/L];

B_mat = [0; 1/L];
C = eye(2);
D = [0; 0];

sys_healthy = ss(A,B_mat,C,D);

%% ================================
% 4. REDUCED ORDER MODEL (DIGITAL TWIN)
%% ================================
sys_bal = balreal(sys_healthy);
sys_rom = balred(sys_bal,1);

%% ================================
% 5. SIMULATION TIME
%% ================================
t = 0:0.01:10;

%% ================================
% 6. SIMULATE SYSTEM AT USER INPUT VOLTAGE
%% ================================
u = V*ones(size(t));

% Current run for Healthy
[y_current,~] = lsim(sys_healthy,u,t);

% Faulty system simulation
B_fault = 0.3;
A_fault = [-B_fault/J  Kt/J;
           -Ke/L      -R/L];
sys_faulty = ss(A_fault,B_mat,C,D);
[y_faulty,~] = lsim(sys_faulty,u,t);

%% ================================
% 7. FIGURE 1: DIGITAL TWIN VALIDATION
%% ================================
[y_rom,~] = lsim(sys_rom,u,t);

figure;
plot(t,y_current(:,1),'b','LineWidth',1.5); hold on;
plot(t,y_rom(:,1),'r--','LineWidth',1.5);
xlabel('Time (s)');
ylabel('Speed (rad/s)');
legend('Full Order','Reduced Order');
title('Digital Twin Validation');
grid on;

%% ================================
% 8. FIGURE 2: FAULT EFFECT ON SYSTEM
%% ================================
figure;
plot(t,y_current(:,1),'g','LineWidth',1.5); hold on;
plot(t,y_faulty(:,1),'r','LineWidth',1.5);
xlabel('Time (s)');
ylabel('Speed (rad/s)');
legend('Healthy','Faulty');
title('Fault Effect on System');
grid on;

%% ================================
% 9. FEATURE EXTRACTION FOR AI
%% ================================
% Healthy (current input)
feat_current = [mean(y_current(:,1));
                rms(y_current(:,1));
                mean(y_current(:,2));
                rms(y_current(:,2))];

% Faulty features for training
speed_f = y_faulty(:,1);
current_f = y_faulty(:,2);

%% ================================
% 10. CREATE TRAINING DATA
%% ================================
numSamples = 50;
X = [];
Y = [];

for k = 1:numSamples
    % Healthy
    sh = y_current(:,1) + 0.02*randn(size(y_current(:,1)));
    ih = y_current(:,2) + 0.02*randn(size(y_current(:,2)));
    feat_h = [mean(sh); rms(sh); mean(ih); rms(ih)];
    X = [X feat_h];
    Y = [Y 0];

    % Faulty
    sf = speed_f + 0.02*randn(size(speed_f));
    ift = current_f + 0.02*randn(size(current_f));
    feat_f = [mean(sf); rms(sf); mean(ift); rms(ift)];
    X = [X feat_f];
    Y = [Y 1];
end

%% ================================
% 11. TRAIN NEURAL NETWORK
%% ================================
net = patternnet(10);
net.trainParam.showWindow = false;  % Hide training window
net = train(net,X,Y);

%% ================================
% 12. AI PREDICTION FOR CURRENT INPUT
%% ================================
current_pred = net(feat_current);  % probability of fault (0-1)

%% ================================
% 13. FIGURE 3: AI FAULT PREDICTION
%% ================================
healthy_prob = 1 - current_pred;
faulty_prob  = current_pred;

figure;
bar([healthy_prob faulty_prob]);
set(gca,'XTickLabel',{'Healthy','Faulty'});
ylabel('Probability');
title('AI Based Fault Prediction');
grid on;

%% ================================
% 14. FINAL DECISION WITH VOLTAGE RANGE CHECK
%% ================================
fprintf('\nUser Input Voltage = %.2f V\n',V);

% Define healthy voltage range
if V >= 0.95 && V <= 1.05 && current_pred < 0.5
    disp('✅ SYSTEM HEALTHY: NO MAINTENANCE REQUIRED');
else
    disp('⚠️ FAULT DETECTED: MAINTENANCE REQUIRED');
end


