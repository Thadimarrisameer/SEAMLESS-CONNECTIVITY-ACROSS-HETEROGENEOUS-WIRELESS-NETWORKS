% Create a new fuzzy inference system
fis = mamfis('Name', 'NetworkSelector');

% Add input variables for signal strengths with ranges from 0 to 100
fis = addInput(fis, [0 100], 'Name', 'signalStrengthA');
fis = addMF(fis, 'signalStrengthA', 'trapmf', [0 0 30 70], 'Name', 'weakA');
fis = addMF(fis, 'signalStrengthA', 'trapmf', [30 70 100 100], 'Name', 'strongA');

fis = addInput(fis, [0 100], 'Name', 'signalStrengthB');
fis = addMF(fis, 'signalStrengthB', 'trapmf', [0 0 30 70], 'Name', 'weakB');
fis = addMF(fis, 'signalStrengthB', 'trapmf', [30 70 100 100], 'Name', 'strongB');

% Add input variables for bandwidths with ranges from 0 to 100 Mbps
fis = addInput(fis, [0 100], 'Name', 'bandwidthA');
fis = addMF(fis, 'bandwidthA', 'trapmf', [0 0 20 80], 'Name', 'lowA');
fis = addMF(fis, 'bandwidthA', 'trapmf', [20 80 100 100], 'Name', 'highA');

fis = addInput(fis, [0 100], 'Name', 'bandwidthB');
fis = addMF(fis, 'bandwidthB', 'trapmf', [0 0 20 80], 'Name', 'lowB');
fis = addMF(fis, 'bandwidthB', 'trapmf', [20 80 100 100], 'Name', 'highB');

% Add output variable for network selection (1 for Network A, 2 for Network B)
fis = addOutput(fis, [1 2], 'Name', 'network');
fis = addMF(fis, 'network', 'trimf', [1 1 1], 'Name', 'NetworkA');
fis = addMF(fis, 'network', 'trimf', [2 2 2], 'Name', 'NetworkB');

% Define the rule matrix
% Columns: [input1MF input2MF input3MF input4MF outputMF weight connectionType]

ruleMatrix = [
    2 0 2 0 1 1 1; % If signalStrengthA is strongA and bandwidthA is highA then network is NetworkA (AND)
    0 2 0 2 2 1 1; % If signalStrengthB is strongB and bandwidthB is highB then network is NetworkB (AND)
    1 0 1 0 2 1 1; % If signalStrengthA is weakA and bandwidthA is lowA and signalStrengthB is weakB and bandwidthB is lowB then network is NetworkB (AND)
    1 0 1 0 2 1 1; % If signalStrengthA is weakA and signalStrengthB is weakB then network is NetworkB (AND)
    2 0 2 0 1 1 1; % If signalStrengthA is strongA and signalStrengthB is strongB then network is NetworkA (AND)
];

% Add the rules to the fuzzy inference system
for i = 1:size(ruleMatrix, 1)
    fis = addRule(fis, ruleMatrix(i, :));
end

% Main loop to simulate real-time network selection
for t = 1:100 % Simulate for 100 time steps
    [signalStrengthA, bandwidthA] = getDynamicNetworkConditions();
    [signalStrengthB, bandwidthB] = getDynamicNetworkConditions();
    
    % Evaluate the fuzzy system
    networkDecision = evalfis(fis, [signalStrengthA bandwidthA signalStrengthB bandwidthB]);
    
    % Select network based on fuzzy logic decision
    selectedNetwork = round(networkDecision); % 1 for Network A, 2 for Network B
    
    % Display the selected network
    fprintf('Time: %d, Signal Strength A: %d, Bandwidth A: %d, Signal Strength B: %d, Bandwidth B: %d, Selected Network: %d\n', ...
        t, signalStrengthA, bandwidthA, signalStrengthB, bandwidthB, selectedNetwork);
end

% Function to simulate dynamic network conditions
function [signal, bandwidth] = getDynamicNetworkConditions()
    % Simulate dynamic signal strength and bandwidth
    signal = randi([0, 100]);
    bandwidth = randi([0, 100]);
end
