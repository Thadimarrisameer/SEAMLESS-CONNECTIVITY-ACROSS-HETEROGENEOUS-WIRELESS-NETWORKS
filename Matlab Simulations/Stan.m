function standardNetworkQualitySimulation()
    % Number of simulation steps
    numSteps = 80;
    
    % Initialize figure
    figure;
    h1 = subplot(2,1,1); % Subplot for selected network
    hold on;
    h2 = subplot(2,1,2); % Subplot for Quality Index
    hold on;

    % Main simulation loop
    for t = 1:numSteps
        % Generate random network conditions
        [jitter, delay, packLoss, monetary] = getRandomNetworkConditions();
        
        % Calculate Quality Index for four hypothetical networks
        QI = zeros(1,4);
        for i = 1:4
            [jitter, delay, packLoss, monetary] = getRandomNetworkConditions();
            QI(i) = calculateQualityIndex(delay, jitter, packLoss, monetary);
        end

        % Determine the network with the highest Quality Index
        [maxValue, idx] = max(QI);
        fprintf('Time %d: Max QI = %f\n', t, maxValue); % Debug output
        
        % Update plots
        subplot(h1);
        plot(t, idx, 'b.', 'MarkerSize', 15); % Plot current network
        title('Network Selection');
        ylabel('Network');
        ylim([0 5]);
        yticks([1 2 3 4]);
        yticklabels({'wifi 2.4','wifi 5','LTE','5G'});
        grid on;
        
        subplot(h2);
        plot(t, maxValue, 'r.', 'MarkerSize', 15); % Plot Quality Index
        title('Quality Index Over Time');
        xlabel('Time (sec)');
        ylabel('Quality Index');
        ylim([0 5]); % Fixed y-axis range from 0 to 5
        grid on;

        pause(0.1); % Pause to update the plots dynamically
    end
    hold off;
end

function [jitter, delay, packLoss, monetary] = getRandomNetworkConditions()
    jitter = randi([0,180]);
    delay = randi([0, 350]);
    packLoss = randi([0, 20])/10;
    monetary = randi([0, 160]);
end

function QI = calculateQualityIndex(delay, jitter, packLoss, monetary)
    % Simple linear model for Quality Index calculation
    QI = 1000 / (delay + 1) + 1000 / (jitter + 1) + 100 / (packLoss + 0.1) + 100 / (monetary + 1);
    % Normalize QI to a scale of 0 to 5
    QI = (5 * QI) / (1000 + 1000 + 100 + 100); % Adjust normalization as necessary
end
