function main
    % Simulation parameters
    numAPs = 5;  % Number of Access Points
    numUEs = 10; % Number of User Equipments
    maxIterations = 100;

    % Initialize random system parameters
    powerAPs = 10 * rand(numAPs, 1); % Maximum power available at each AP
    bandwidths = randi([5, 20], numAPs, 1); % Bandwidths available at each AP
    userRequirements = randi([1, 5], numUEs, 1); % Data rate requirements for each UE

    % Random channel gains matrix for APs to UEs
    channelGains = rand(numAPs, numUEs);

    % Array to store energy efficiency per iteration
    energyEfficiency = zeros(maxIterations, 1);
    bestEfficiency = 0; % Best efficiency observed
    bestPowerAllocation = zeros(numAPs, numUEs); % Best power allocation matrix
    bestBandwidthAllocation = zeros(numAPs, numUEs); % Best bandwidth allocation matrix

    % Begin optimization
    for i = 1:maxIterations
        [powerAllocation, subcarrierAllocation] = allocateResources(powerAPs, bandwidths, userRequirements, channelGains, bestPowerAllocation, bestBandwidthAllocation, bestEfficiency);

        % Evaluate the current energy efficiency
        energyEfficiency(i) = evaluateEnergyEfficiency(powerAllocation, channelGains, powerAPs);

        % Store best allocation if current efficiency is better
        if energyEfficiency(i) > bestEfficiency
            bestEfficiency = energyEfficiency(i);
            bestPowerAllocation = powerAllocation;
            bestBandwidthAllocation = subcarrierAllocation;
        end

        % Update the power and bandwidth based on allocation feedback
        [powerAPs, bandwidths] = updateNetworkResources(powerAllocation, subcarrierAllocation, powerAPs, bandwidths);
    end

    % Output results
    disp('Simulation completed.');
    figure; plot(energyEfficiency); title('Energy Efficiency Over Iterations'); xlabel('Iteration'); ylabel('Energy Efficiency');
    disp('Energy Efficiency Metrics:');
    disp(energyEfficiency);
end

function [powerAllocation, subcarrierAllocation] = allocateResources(powerAPs, bandwidths, userRequirements, channelGains, bestPowerAllocation, bestBandwidthAllocation, bestEfficiency)
    numAPs = length(powerAPs);
    numUEs = length(userRequirements);
    powerAllocation = zeros(numAPs, numUEs);
    subcarrierAllocation = zeros(numAPs, numUEs);

    % Allocation logic: Use best allocation as a base if it was good, otherwise random
    if bestEfficiency > 0
        % Use historical best allocations as a baseline
        powerAllocation = bestPowerAllocation;
        subcarrierAllocation = bestBandwidthAllocation;
    else
        % Random allocation as before
        for ap = 1:numAPs
            for ue = 1:numUEs
                if rand > 0.5
                    powerAllocation(ap, ue) = rand * powerAPs(ap);
                    subcarrierAllocation(ap, ue) = 1;
                end
            end
        end
    end
end

function ee = evaluateEnergyEfficiency(powerAllocation, channelGains, powerAPs)
    if isequal(size(powerAllocation), size(channelGains))
        energyUsed = sum(sum(powerAllocation .* channelGains));
        totalPower = sum(powerAPs);
        ee = energyUsed / totalPower;
    else
        error('Dimension mismatch between powerAllocation and channelGains.');
    end
end

function [newPowerAPs, newBandwidths] = updateNetworkResources(powerAllocation, subcarrierAllocation, powerAPs, bandwidths)
    powerUsed = sum(powerAllocation, 2);
    newPowerAPs = powerAPs - powerUsed * 0.1; % Reduce power by 10% of the used power
    bandwidthUsed = sum(subcarrierAllocation, 2);
    newBandwidths = bandwidths - bandwidthUsed * 0.1; % Reduce bandwidth by 10% of the used bandwidth
end
