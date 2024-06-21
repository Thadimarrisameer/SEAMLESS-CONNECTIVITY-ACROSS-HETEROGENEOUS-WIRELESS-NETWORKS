%% Load Balancing Simulation in Heterogeneous Wireless Networks

% Clear workspace and figures
clear; close all; clc;

% Number of access points and devices
numAPs = 5;    % Number of Access Points
numDevices = 50;  % Number of Devices

% Generate random positions for APs and Devices in a 2D area
APs = 100 * rand(numAPs, 2);       % AP coordinates
Devices = 100 * rand(numDevices, 2); % Device coordinates

% Capacity of each Access Point
APCapacity = repmat(15, numAPs, 1);  % Each AP can handle 15 devices

% Assign Devices to Access Points based on proximity and capacity
APLoad = zeros(numAPs, 1);   % Current load on each AP
DeviceAP = zeros(numDevices, 1);  % AP each device is connected to

for i = 1:numDevices
    distances = sqrt(sum((APs - Devices(i, :)).^2, 2));  % Euclidean distance to each AP
    [sortedDistances, sortedIndices] = sort(distances);  % Sort distances

    % Find the closest AP with available capacity
    for j = 1:numAPs
        closestAP = sortedIndices(j);
        if APLoad(closestAP) < APCapacity(closestAP)
            DeviceAP(i) = closestAP;
            APLoad(closestAP) = APLoad(closestAP) + 1;
            break;
        end
    end
end

% Plotting
figure;
hold on;
grid on;
axis equal;
colors = lines(numAPs);  % Generate different colors for each AP

% Plot Access Points
for k = 1:numAPs
    plot(APs(k, 1), APs(k, 2), 'o', 'MarkerSize', 10, 'MarkerFaceColor', colors(k, :));
    text(APs(k, 1), APs(k, 2), [' AP' num2str(k)], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end

% Plot Devices and connect them to their APs
for i = 1:numDevices
    apIndex = DeviceAP(i);
    plot(Devices(i, 1), Devices(i, 2), '*', 'Color', colors(apIndex, :));
    line([Devices(i, 1) APs(apIndex, 1)], [Devices(i, 2) APs(apIndex, 2)], 'Color', colors(apIndex, :));
end

title('Load Balancing in Heterogeneous Wireless Networks');
xlabel('X Coordinate');
ylabel('Y Coordinate');
legend('Access Point Locations', 'Location', 'best');
hold off;

%% Display Load Information
disp('Load on each AP:');
for i = 1:numAPs
    disp(['AP ' num2str(i) ': ' num2str(APLoad(i)) ' devices']);
end
