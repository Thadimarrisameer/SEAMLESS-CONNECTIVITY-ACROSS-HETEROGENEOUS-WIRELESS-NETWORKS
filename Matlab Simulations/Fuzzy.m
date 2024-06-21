% Create a Mamdani Fuzzy Inference System
fis = mamfis('Name', 'network_selection');

% Add input variables to the FIS
fis = addInput(fis, [0 100], 'Name', 'Signal_Strength');
fis = addInput(fis, [0 100], 'Name', 'Data_Speed');
fis = addInput(fis, [0 100], 'Name', 'Reliability');

% Add output variable to the FIS
fis = addOutput(fis, [0 100], 'Name', 'Network_Selection');

% Add membership functions to input variables
fis = addMF(fis, 'Signal_Strength', 'trimf', [0 0 50], 'Name', 'poor');
fis = addMF(fis, 'Signal_Strength', 'trimf', [0 50 100], 'Name', 'average');
fis = addMF(fis, 'Signal_Strength', 'trimf', [50 100 100], 'Name', 'good');

fis = addMF(fis, 'Data_Speed', 'trimf', [0 0 50], 'Name', 'slow');
fis = addMF(fis, 'Data_Speed', 'trimf', [0 50 100], 'Name', 'medium');
fis = addMF(fis, 'Data_Speed', 'trimf', [50 100 100], 'Name', 'fast');

fis = addMF(fis, 'Reliability', 'trimf', [0 0 50], 'Name', 'low');
fis = addMF(fis, 'Reliability', 'trimf', [0 50 100], 'Name', 'medium');
fis = addMF(fis, 'Reliability', 'trimf', [50 100 100], 'Name', 'high');

% Add membership functions to output variable
fis = addMF(fis, 'Network_Selection', 'trimf', [0 0 50], 'Name', 'low');
fis = addMF(fis, 'Network_Selection', 'trimf', [0 50 100], 'Name', 'medium');
fis = addMF(fis, 'Network_Selection', 'trimf', [50 100 100], 'Name', 'high');

% Define fuzzy rules
rules = [
    "if Signal_Strength is good and Data_Speed is fast and Reliability is high then Network_Selection is high";
    "if Signal_Strength is average and Data_Speed is medium and Reliability is medium then Network_Selection is medium";
    "if Signal_Strength is poor or Data_Speed is slow or Reliability is low then Network_Selection is low"
];

% Add rules to the FIS
for rule = rules
    fis = addRule(fis, rule);
end

% Define input ranges for simulation
signal_range = 0:1:100;
data_speed_range = 0:1:100;
reliability_range = 0:1:100;

% Initialize variables for simulation results
network_selection_signal = zeros(size(signal_range));
network_selection_speed = zeros(size(data_speed_range));
network_selection_reliability = zeros(size(reliability_range));

% Simulate the effect of varying each input individually
for i = 1:length(signal_range)
    network_selection_signal(i) = evalfis(fis, [signal_range(i) 50 50]);
end

for i = 1:length(data_speed_range)
    network_selection_speed(i) = evalfis(fis, [50 data_speed_range(i) 50]);
end

for i = 1:length(reliability_range)
    network_selection_reliability(i) = evalfis(fis, [50 50 reliability_range(i)]);
end

% Plot simulation results
figure;
subplot(3,1,1);
plot(signal_range, network_selection_signal);
title('Network Selection vs. Signal Strength');
xlabel('Signal Strength');
ylabel('Network Selection');

subplot(3,1,2);
plot(data_speed_range, network_selection_speed);
title('Network Selection vs. Data Speed');
xlabel('Data Speed');
ylabel('Network Selection');

subplot(3,1,3);
plot(reliability_range, network_selection_reliability);
title('Network Selection vs. Reliability');
xlabel('Reliability');
ylabel('Network Selection');
