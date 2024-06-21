function static_load_balancing_comparison()
    % Network parameters
    numNodes = 5;
    numDevices = 50; % Number of devices
    maxDevicesPerNode = 10; % Maximum devices per node
    nodeLocations = rand(numNodes, 2) * 100; % Random locations for nodes in a 100x100 grid
    deviceLocations = rand(numDevices, 2) * 100; % Random locations for devices
    nodeConnections = zeros(1, numNodes); % Initialize node connections for LC

    % Response time randomly assigned for LRT
    nodeResponseTime = 0.5 + rand(1, numNodes); % Initial response times between 0.5 and 1.5 seconds

    % Assign devices to nodes using Least Connections method
    fprintf('Assigning devices using Least Connections (LC):\n');
    deviceNodeLC = assignDevicesToNodesLC(nodeConnections, deviceLocations, nodeLocations, maxDevicesPerNode);

    % Assign devices to nodes using Least Response Time method
    fprintf('Assigning devices using Least Response Time (LRT):\n');
    deviceNodeLRT = assignDevicesToNodesLRT(nodeResponseTime, deviceLocations, nodeLocations, maxDevicesPerNode);

    % Plotting the final state for Least Connections
    figure;
    subplot(2, 1, 1);
    hold on;
    scatter(nodeLocations(:,1), nodeLocations(:,2), 'ko', 'filled');
    scatter(deviceLocations(:,1), deviceLocations(:,2), 'b*');
    for i = 1:numDevices
        line([deviceLocations(i,1), nodeLocations(deviceNodeLC(i),1)], ...
             [deviceLocations(i,2), nodeLocations(deviceNodeLC(i),2)], 'Color', 'b');
    end
    title('Least Connections');
    xlabel('X Coordinate');
    ylabel('Y Coordinate');
    axis equal;
    grid on;

    % Plotting the final state for Least Response Time
    subplot(2, 1, 2);
    hold on;
    scatter(nodeLocations(:,1), nodeLocations(:,2), 'ko', 'filled');
    scatter(deviceLocations(:,1), deviceLocations(:,2), 'r*');
    for i = 1:numDevices
        line([deviceLocations(i,1), nodeLocations(deviceNodeLRT(i),1)], ...
             [deviceLocations(i,2), nodeLocations(deviceNodeLRT(i),2)], 'Color', 'r');
    end
    title('Least Response Time');
    xlabel('X Coordinate');
    ylabel('Y Coordinate');
    axis equal;
    grid on;

    hold off;
end

function deviceNode = assignDevicesToNodesLC(currentLoad, deviceLocations, nodeLocations, maxDevicesPerNode)
    numDevices = size(deviceLocations, 1);
    numNodes = size(nodeLocations, 1);
    deviceNode = zeros(numDevices, 1);
    
    for i = 1:numDevices
        distances = vecnorm(nodeLocations - deviceLocations(i,:), 2, 2);
        loadAdjustedDistances = distances + 0.01 * currentLoad';
        validIndices = currentLoad < maxDevicesPerNode;
        loadAdjustedDistances(~validIndices) = inf;
        [~, minIndex] = min(loadAdjustedDistances);
        deviceNode(i) = minIndex;
        currentLoad(minIndex) = currentLoad(minIndex) + 1;
        fprintf('Device %d: Assigned to Node %d, Distance = %.2f, Load = %d\n', i, minIndex, distances(minIndex), currentLoad(minIndex));
    end
end

function deviceNode = assignDevicesToNodesLRT(nodeResponseTime, deviceLocations, nodeLocations, maxDevicesPerNode)
    numDevices = size(deviceLocations, 1);
    numNodes = size(nodeLocations, 1);
    deviceNode = zeros(numDevices, 1);
    currentLoad = zeros(1, numNodes); % Initialize current load for LRT similar to LC
    
    for i = 1:numDevices
        distances = vecnorm(nodeLocations - deviceLocations(i,:), 2, 2);
        responseTimeAdjustedScores = distances .* nodeResponseTime';
        validIndices = currentLoad < maxDevicesPerNode;
        responseTimeAdjustedScores(~validIndices) = inf;
        [~, minIndex] = min(responseTimeAdjustedScores);
        deviceNode(i) = minIndex;
        currentLoad(minIndex) = currentLoad(minIndex) + 1;
        fprintf('Device %d: Assigned to Node %d, Score = %.2f, Response Time = %.2f, Load = %d\n', i, minIndex, responseTimeAdjustedScores(minIndex), nodeResponseTime(minIndex), currentLoad(minIndex));
    end
end
