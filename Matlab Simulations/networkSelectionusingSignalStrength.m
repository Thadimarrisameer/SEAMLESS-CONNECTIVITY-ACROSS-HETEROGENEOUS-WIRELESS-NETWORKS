% MATLAB Script for Network Selection Based on Signal Strength

% Define a set of available networks with their signal strengths (in dBm)
networks = [
    1, -85;  % Network ID 1, Signal Strength -85 dBm
    2, -60;  % Network ID 2, Signal Strength -60 dBm
    3, -75;  % Network ID 3, Signal Strength -75 dBm
    4, -55;  % Network ID 4, Signal Strength -55 dBm
    5, -65   % Network ID 5, Signal Strength -65 dBm
];

% Display the available networks and their signal strengths
disp('Available networks and their signal strengths (in dBm):');
disp('Network ID | Signal Strength');
disp(networks);

% Choose the network with the strongest signal strength
[strongestSignal, idx] = max(networks(:,2));

% Display the chosen network
chosenNetworkID = networks(idx, 1);
fprintf('The chosen network is Network ID %d with a signal strength of %d dBm.\n', chosenNetworkID, strongestSignal);

% Plot the signal strengths of the available networks
figure;
bar(networks(:, 1), networks(:, 2));
title('Signal Strengths of Available Networks');
xlabel('Network ID');
ylabel('Signal Strength (dBm)');
grid on;

% Highlight the network with the strongest signal strength
hold on;
bar(chosenNetworkID, strongestSignal, 'r');
legend('Available Networks', 'Chosen Network');
