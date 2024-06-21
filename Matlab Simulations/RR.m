function main
    % Simulation parameters
    numAPs = 20;  % Increased number of Access Points for more complexity
    numUEs = 50; % Increased number of User Equipments for more realistic simulation
    maxIterations = 100;

    % Initialize random system parameters
    powerAPs = 10 * rand(numAPs, 1) + 1; % Ensuring non-zero initial power for all APs
    bandwidths = randi([10, 50], numAPs, 1); % Wider range and higher bandwidths for more realistic scenario
    userRequirements = randi([1, 10], numUEs, 1); % Increased range for user requirements

    % Random channel gains matrix expanded for more APs and UEs
    channelGains = rand(numAPs, numUEs);

    % Array to store energy efficiency for each iteration
    energyEfficiency = zeros(maxIterations, 1);
    bestEfficiency = 0; % Best efficiency found during the simulation

    % Begin optimization
    for i = 1:maxIterations
        [powerAllocation, subcarrierAllocation] = allocateResources(powerAPs, bandwidths, userRequirements, channelGains);
        currentEE = evaluateEnergyEfficiency(powerAllocation, channelGains, powerAPs);

        % Update the best efficiency found and keep best allocations
        if currentEE > bestEfficiency
            bestEfficiency = currentEE;
            bestPowerAllocation = powerAllocation;
            bestSubcarrierAllocation = subcarrierAllocation;
        end
        
        energyEfficiency(i) = bestEfficiency;

        % Update resources based on the best allocations found
        [powerAPs, bandwidths] = updateNetworkResources(bestPowerAllocation, bestSubcarrierAllocation, powerAPs, bandwidths);
    end

    % Output results
    disp('Simulation completed.');
    figure; plot(1:maxIterations, energyEfficiency);
    title('Energy Efficiency Over Iterations'); xlabel('Iteration'); ylabel('Energy Efficiency');
    disp('Final Energy Efficiency Metrics:');
    disp(energyEfficiency);
end

function [powerAllocation, subcarrierAllocation] = allocateResources(powerAPs, bandwidths, userRequirements, channelGains)
    numAPs = length(powerAPs);
    numUEs = length(userRequirements);
    powerAllocation = zeros(numAPs, numUEs);
    subcarrierAllocation = zeros(numAPs, numUEs);

    % Simplified allocation still assumes random allocation
    for ap = 1:numAPs
        for ue = 1:numUEs
            if rand > 0.5
                powerAllocation(ap, ue) = rand * powerAPs(ap);
                subcarrierAllocation(ap, ue) = bandwidths(ap);
            end
        end
    end
end

function ee = evaluateEnergyEfficiency(powerAllocation, channelGains, powerAPs)
    effectivePower = sum(sum(powerAllocation .* channelGains));
    totalPower = sum(powerAPs);
    ee = max(0, effectivePower / totalPower); % Prevent negative efficiency
end

function [newPowerAPs, newBandwidths] = updateNetworkResources(powerAllocation, subcarrierAllocation, powerAPs, bandwidths)
    powerUsed = sum(powerAllocation, 2);
    newPowerAPs = max(0, powerAPs - 0.05 * powerUsed); % Gradual reduction to avoid rapid resource depletion
    bandwidthUsed = sum(subcarrierAllocation, 2);
    newBandwidths = max(0, bandwidths - 0.05 * bandwidthUsed);
end
