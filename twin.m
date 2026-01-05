clc;
clear;
close all;
% 1. USER INPUT
V = input('Enter input voltage (e.g. 1 for normal, 0.6 for low): ');
disp(['User Input Voltage = ' num2str(V,'%.2f') ' V']);
% 2. SYSTEM PARAMETERS
R = 10;              
k = 0.5;             
omega = 100;         
% 3. CURRENT CALCULATION
I = V / R;
% 4. TORQUE CALCULATION
Torque = k * I;
% 5. SIMULATED FRICTION (AI FEATURE)
friction = 0.1 + 0.4*rand;   % normal: < 0.3, faulty: > 0.3
% 6. FEATURE VECTOR
X = [friction];
% 7. AI MODEL (LOGIC-BASED SIMULATION)
% Mechanical fault prediction
if friction > 0.3
    current_pred = 1;   
else
    current_pred = 0;   
end
% 8. FIGURE 1: TORQUE
figure;
bar(Torque);
title('Generated Torque');
ylabel('Torque (Nm)');
grid on;
% 9. FIGURE 2: FRICTION LEVEL
figure;
bar(friction);
title('Friction Level');
ylabel('Friction');
grid on;
% 10. ELECTRICAL FAULT CHECK (VOLTAGE)
if V < 0.95 || V > 1.05
    electrical_fault = 1;
else
    electrical_fault = 0;
end
% 11. FINAL FAULT DECISION
if electrical_fault == 1 || current_pred == 1
    system_fault = 1;
else
    system_fault = 0;
end
% 12. FIGURE 3: AI BASED FAULT PREDICTION (FIXED)
if electrical_fault == 1
    healthy_prob = 0;
    faulty_prob  = 1;
else
    healthy_prob = 1 - current_pred;
    faulty_prob  = current_pred;
end
figure;
bar([healthy_prob faulty_prob]);
set(gca,'XTickLabel',{'Healthy','Faulty'});
ylabel('Probability');
title('AI Based Fault Prediction');
grid on;
% 13. FINAL OUTPUT MESSAGE
if system_fault == 0
    disp('SYSTEM HEALTHY: NO MAINTENANCE REQUIRED');
else
    disp(' FAULT DETECTED: MAINTENANCE REQUIRED');
end
