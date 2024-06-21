% MATLAB Script for Network Selection Based on User Input of Signal Strength

% Ask the user for the number of networks
numNetworks = input('Enter the number of networks: ');

% Initialize an array to hold the network IDs and signal strengths
networks = zeros(numNetworks, 2);

% Loop to get user input for each network's signal strength
for i = 1:numNetworks
    networks(i, 1) = i; % Assign network ID
    fprintf('Enter the signal strength for Network %d (in dBm, e.g., -70): ', i);
    networks(i, 2) = input('');
end

% Display the available networks and their signal strengths
disp('Available networks and their signal strengths (in dBm):');
disp(array2table(networks, 'VariableNames', {'Network_ID', 'Signal_Strength'}));

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

% Dynamically set the y-axis to extend beyond the highest signal strength
ylim([1.2 * min(networks(:, 2)) 0]); % 20% more than the highest negative strength

% Highlight the network with the strongest signal strength with a red bar
hold on;
bar(chosenNetworkID, strongestSignal, 'r');
legend('Available Networks', 'Chosen Network');
