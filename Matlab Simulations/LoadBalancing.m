% Number of base stations and users
numBaseStations = randi([3, 7]);  % Random number of base stations
numUsers = randi([20, 50]);       % Random number of users

% Initialize capacities for each base station
baseStationCapacities = randi([10, 30], numBaseStations, 1);

% Initialize current load for each base station
baseStationLoad = zeros(numBaseStations, 1);

% User demands (randomly generated within a realistic range)
userDemands = randi([1, 5], numUsers, 1);

% Function to allocate users to base stations
function [baseStationLoad, allocation] = allocateUsers(baseStationLoad, baseStationCapacities, userDemands)
    allocation = zeros(length(userDemands), 1);
    for i = 1:length(userDemands)
        % Calculate available capacity of each base station
        availableCapacity = baseStationCapacities - baseStationLoad;
        
        % Filter out base stations that cannot accommodate the new user demand
        feasibleIndices = find(availableCapacity >= userDemands(i));
        
        % Allocate to the base station with the highest available capacity
        if ~isempty(feasibleIndices)
            [~, idx] = max(availableCapacity(feasibleIndices));
            chosenStation = feasibleIndices(idx);
            baseStationLoad(chosenStation) = baseStationLoad(chosenStation) + userDemands(i);
            allocation(i) = chosenStation;
        else
            % If no base stations can accommodate, leave the user unallocated
            allocation(i) = -1;  % Indicative of no allocation
        end
    end
end

% Allocate users to base stations
[baseStationLoad, allocation] = allocateUsers(baseStationLoad, baseStationCapacities, userDemands);

% Display and visualize results
fprintf('Final load on each base station:\n');
disp(baseStationLoad);
fprintf('Base station capacities:\n');
disp(baseStationCapacities);

% Check for unallocated users
unallocatedUsers = find(allocation == -1);
fprintf('%d users unallocated due to capacity limits.\n', numel(unallocatedUsers));

% Plotting the load versus capacity for each base station
figure;
hold on;
bar(baseStationLoad, 'b', 'DisplayName', 'Current Load');
bar(baseStationCapacities, 0.4, 'r', 'DisplayName', 'Capacity');
legend('show');
title('Load vs. Capacity in Base Stations');
xlabel('Base Station Index');
ylabel('Load/Capacity (units)');
hold off;
