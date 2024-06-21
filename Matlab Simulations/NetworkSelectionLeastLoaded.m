% MATLAB Script for Enhanced Network Selection Based on User Preferences

% Ask the user for the number of networks
numNetworks = input('Enter the number of networks: ');

% Initialize arrays to hold the network IDs, signal strengths, and loads
networks = zeros(numNetworks, 3); % Adding an extra column for network load

% Loop to get user input for each network's signal strength and load
for i = 1:numNetworks
    networks(i, 1) = i; % Assign network ID
    fprintf('Enter the signal strength for Network %d (in dBm, e.g., -70): ', i);
    networks(i, 2) = input('');
    fprintf('Enter the load for Network %d (as a percentage, e.g., 50): ', i);
    networks(i, 3) = input('');
end

% Display the available networks, their signal strengths, and loads
disp('Available networks, their signal strengths (in dBm), and loads (%):');
disp(array2table(networks, 'VariableNames', {'Network_ID', 'Signal_Strength', 'Load'}));

% Ask the user for their selection criterion
disp('Select the criterion for choosing the network:');
disp('1 - Strongest Signal Strength');
disp('2 - Least Load');
disp('3 - Optimized Solution (Weighted Combination of Signal Strength and Load)');
selectionCriterion = input('Enter your choice (1, 2, or 3): ');

% Additional input for optimized solution
weights = [0.5, 0.5]; % Default weights for signal and load
if selectionCriterion == 3
    fprintf('Enter the weight for signal strength (0-1): ');
    weights(1) = input('');
    fprintf('Enter the weight for network load (0-1): ');
    weights(2) = input('');
    % Ensure weights sum to 1
    weights = weights / sum(weights);
end

% Normalize signal strength and load
signalStrengthNormalized = (networks(:,2) - min(networks(:,2))) / (max(networks(:,2)) - min(networks(:,2)));
loadNormalized = 1 - ((networks(:,3) - min(networks(:,3))) / (max(networks(:,3)) - min(networks(:,3))));

% Apply selection criterion
switch selectionCriterion
    case 1
        [~, idx] = max(networks(:,2));
    case 2
        [~, idx] = min(networks(:,3));
    case 3
        % Calculate a weighted score for each network
        scores = weights(1) * signalStrengthNormalized + weights(2) * loadNormalized;
        [~, idx] = max(scores);
    otherwise
        disp('Invalid selection. Defaulting to Strongest Signal Strength.');
        [~, idx] = max(networks(:,2));
end

% Display the chosen network
chosenNetworkID = networks(idx, 1);
fprintf('The chosen network is Network ID %d with a signal strength of %d dBm and a load of %d%%.\n', chosenNetworkID, networks(idx, 2), networks(idx, 3));

% Plotting
figure;
% Signal Strength Plot
subplot(2,1,1);
bar(networks(:, 1), networks(:, 2), 'b');
hold on;
bar(chosenNetworkID, networks(idx, 2), 'g'); % Highlight the chosen network
title('Signal Strengths of Available Networks');
xlabel('Network ID');
ylabel('Signal Strength (dBm)');
grid on;
legend('Available Networks', 'Chosen Network', 'Location', 'best');

% Network Load Plot
subplot(2,1,2);
bar(networks(:, 1), networks(:, 3), 'r');
hold on;
bar(chosenNetworkID, networks(idx, 3), 'g'); % Highlight the chosen network
title('Loads of Available Networks (%)');
xlabel('Network ID');
ylabel('Load (%)');
grid on;
ylim([0, 100]); % Load percentages, so the limit is 0 to 100%
