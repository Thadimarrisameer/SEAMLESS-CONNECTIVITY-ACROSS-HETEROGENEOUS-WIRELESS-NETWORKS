% Construct FIS
fis = mamfis(Name="fis");
% Input 1
fis = addInput(fis,[0 350],Name="delay");
fis = addMF(fis,"delay","trapmf",[0 0 100 200], ...
    Name="low",VariableType="input");
fis = addMF(fis,"delay","trimf",[100 200 300], ...
    Name="medium",VariableType="input");
fis = addMF(fis,"delay","trapmf",[200 300 350 350], ...
    Name="high",VariableType="input");
% Input 2
fis = addInput(fis,[0 180],Name="jitter");
fis = addMF(fis,"jitter","trapmf",[0 0 50 100], ...
    Name="low",VariableType="input");
fis = addMF(fis,"jitter","trimf",[50 100 150], ...
    Name="medium",VariableType="input");
fis = addMF(fis,"jitter","trapmf",[100 150 180 180], ...
    Name="high",VariableType="input");
% Input 3
fis = addInput(fis,[0 2],Name="packLoss");
fis = addMF(fis,"packLoss","trapmf",[0 0 0.5 1], ...
    Name="low",VariableType="input");
fis = addMF(fis,"packLoss","trimf",[0.5 1 1.5], ...
    Name="medium",VariableType="input");
fis = addMF(fis,"packLoss","trapmf",[1 1.5 2 2], ...
    Name="high",VariableType="input");
% Input 4
fis = addInput(fis,[0 160],Name="monetary");
fis = addMF(fis,"monetary","trapmf",[0 0 45 90], ...
    Name="low",VariableType="input");
fis = addMF(fis,"monetary","trimf",[45 90 145], ...
    Name="medium",VariableType="input");
fis = addMF(fis,"monetary","trapmf",[90 145 160 160], ...
    Name="high",VariableType="input");
% Output 1
fis = addOutput(fis,[0 5],Name="QI");
fis = addMF(fis,"QI","trapmf",[0 0 1 2], ...
    Name="bad",VariableType="output");
fis = addMF(fis,"QI","trimf",[1 2 3], ...
    Name="good",VariableType="output");
fis = addMF(fis,"QI","trimf",[2 3 4], ...
    Name="great",VariableType="output");
fis = addMF(fis,"QI","trapmf",[3 4 5 5], ...
    Name="excellent",VariableType="output");

% Add rules for fis logic
rules = [
"If delay is low and jitter is low and packLoss is low and monetary is low then QI is excellent"
"If delay is low and jitter is low and packLoss is low and monetary is medium then QI is great"
"If delay is low and jitter is low and packLoss is low and monetary is high then QI is great"
"If delay is low and jitter is low and packLoss is medium and monetary is low then QI is great"
"If delay is low and jitter is low and packLoss is medium and monetary is medium then QI is good"
"If delay is low and jitter is low and packLoss is medium and monetary is high then QI is good"
"If delay is low and jitter is low and packLoss is high and monetary is low then QI is great"
"If delay is low and jitter is low and packLoss is high and monetary is medium then QI is good"
"If delay is low and jitter is low and packLoss is high and monetary is high then QI is good"
"If delay is low and jitter is medium and packLoss is low and monetary is low then QI is great"
"If delay is low and jitter is medium and packLoss is low and monetary is medium then QI is good"
"If delay is low and jitter is medium and packLoss is low and monetary is high then QI is good"
"If delay is low and jitter is medium and packLoss is medium and monetary is low then QI is good"
"If delay is low and jitter is medium and packLoss is medium and monetary is medium then QI is bad"
"If delay is low and jitter is medium and packLoss is medium and monetary is high then QI is bad"
"If delay is low and jitter is medium and packLoss is high and monetary is low then QI is good"
"If delay is low and jitter is medium and packLoss is high and monetary is medium then QI is bad"
"If delay is low and jitter is medium and packLoss is high and monetary is high then QI is bad"
"If delay is low and jitter is high and packLoss is low and monetary is low then QI is great"
"If delay is low and jitter is high and packLoss is low and monetary is medium then QI is good"
"If delay is low and jitter is high and packLoss is low and monetary is high then QI is good"
"If delay is low and jitter is high and packLoss is medium and monetary is low then QI is good"
"If delay is low and jitter is high and packLoss is medium and monetary is medium then QI is bad"
"If delay is low and jitter is high and packLoss is medium and monetary is high then QI is bad"
"If delay is low and jitter is high and packLoss is high and monetary is low then QI is good"
"If delay is low and jitter is high and packLoss is high and monetary is medium then QI is bad"
"If delay is low and jitter is high and packLoss is high and monetary is high then QI is bad"
"If delay is medium and jitter is low and packLoss is low and monetary is low then QI is great"
"If delay is medium and jitter is low and packLoss is low and monetary is medium then QI is good"
"If delay is medium and jitter is low and packLoss is low and monetary is high then QI is good"
"If delay is medium and jitter is low and packLoss is medium and monetary is low then QI is good"
"If delay is medium and jitter is low and packLoss is medium and monetary is medium then QI is bad"
"If delay is medium and jitter is low and packLoss is medium and monetary is high then QI is bad"
"If delay is medium and jitter is low and packLoss is high and monetary is low then QI is good"
"If delay is medium and jitter is low and packLoss is high and monetary is medium then QI is bad"
"If delay is medium and jitter is low and packLoss is high and monetary is high then QI is bad"
"If delay is medium and jitter is medium and packLoss is low and monetary is low then QI is good"
"If delay is medium and jitter is medium and packLoss is low and monetary is medium then QI is bad"
"If delay is medium and jitter is medium and packLoss is low and monetary is high then QI is bad"
"If delay is medium and jitter is medium and packLoss is medium and monetary is low then QI is bad"
"If delay is medium and jitter is medium and packLoss is medium and monetary is medium then QI is bad"
"If delay is medium and jitter is medium and packLoss is medium and monetary is high then QI is bad"
"If delay is medium and jitter is medium and packLoss is high and monetary is low then QI is bad"
"If delay is medium and jitter is medium and packLoss is high and monetary is medium then QI is bad"
"If delay is medium and jitter is medium and packLoss is high and monetary is high then QI is bad"
"If delay is medium and jitter is high and packLoss is low and monetary is low then QI is good"
"If delay is medium and jitter is high and packLoss is low and monetary is medium then QI is bad"
"If delay is medium and jitter is high and packLoss is low and monetary is high then QI is bad"
"If delay is medium and jitter is high and packLoss is medium and monetary is low then QI is bad"
"If delay is medium and jitter is high and packLoss is medium and monetary is medium then QI is bad"
"If delay is medium and jitter is high and packLoss is medium and monetary is high then QI is bad"
"If delay is medium and jitter is high and packLoss is high and monetary is low then QI is bad"
"If delay is medium and jitter is high and packLoss is high and monetary is medium then QI is bad"
"If delay is medium and jitter is high and packLoss is high and monetary is high then QI is bad"
"If delay is high and jitter is low and packLoss is low and monetary is low then QI is great"
"If delay is high and jitter is low and packLoss is low and monetary is medium then QI is good"
"If delay is high and jitter is low and packLoss is low and monetary is high then QI is good"
"If delay is high and jitter is low and packLoss is medium and monetary is low then QI is good"
"If delay is high and jitter is low and packLoss is medium and monetary is medium then QI is bad"
"If delay is high and jitter is low and packLoss is medium and monetary is high then QI is bad"
"If delay is high and jitter is low and packLoss is high and monetary is low then QI is good"
"If delay is high and jitter is low and packLoss is high and monetary is medium then QI is bad"
"If delay is high and jitter is low and packLoss is high and monetary is high then QI is bad"
"If delay is high and jitter is medium and packLoss is low and monetary is low then QI is good"
"If delay is high and jitter is medium and packLoss is low and monetary is medium then QI is bad"
"If delay is high and jitter is medium and packLoss is low and monetary is high then QI is bad"
"If delay is high and jitter is medium and packLoss is medium and monetary is low then QI is bad"
"If delay is high and jitter is medium and packLoss is medium and monetary is medium then QI is bad"
"If delay is high and jitter is medium and packLoss is medium and monetary is high then QI is bad"
"If delay is high and jitter is medium and packLoss is high and monetary is low then QI is bad"
"If delay is high and jitter is medium and packLoss is high and monetary is medium then QI is bad"
"If delay is high and jitter is medium and packLoss is high and monetary is high then QI is bad"
"If delay is high and jitter is high and packLoss is low and monetary is low then QI is good"
"If delay is high and jitter is high and packLoss is low and monetary is medium then QI is bad"
"If delay is high and jitter is high and packLoss is low and monetary is high then QI is bad"
"If delay is high and jitter is high and packLoss is medium and monetary is low then QI is bad"
"If delay is high and jitter is high and packLoss is medium and monetary is medium then QI is bad"
"If delay is high and jitter is high and packLoss is medium and monetary is high then QI is bad"
"If delay is high and jitter is high and packLoss is high and monetary is low then QI is bad"
"If delay is high and jitter is high and packLoss is high and monetary is medium then QI is bad"
"If delay is high and jitter is high and packLoss is high and monetary is high then QI is bad"
];


fis = addRule(fis, rules);
function [jitter, delay, packLoss, monetary] = getRandomNetworkConditions()
    jitter = randi([0,180]);
    delay = randi([0, 350]);
    packLoss = randi([0, 20])/10;
    monetary = randi([0, 160]);
end

% Main loop to simulate real-time network selection and plot the result
figure
current=1;
sc=0;
for t = 1:80 % Simulate for 100 time steps
    if mod(t,10) == 1
    [jitter, delay, packLoss, monetary] = getRandomNetworkConditions();
    outpn1 = evalfis(fis, [delay jitter packLoss monetary]);
    [jitter, delay, packLoss, monetary] = getRandomNetworkConditions();
    outpn2 = evalfis(fis, [delay jitter packLoss monetary]);
    [jitter, delay, packLoss, monetary] = getRandomNetworkConditions();
    outpn3 = evalfis(fis, [delay jitter packLoss monetary]);
    [jitter, delay, packLoss, monetary] = getRandomNetworkConditions();
    outpn4 = evalfis(fis, [delay jitter packLoss monetary]);
    % Select network based on fis logic decision
     maxValue = max([outpn1, outpn2, outpn3, outpn4]);

    % Determine the network of the maximum value
    if maxValue == outpn1
        network = 1;
    elseif maxValue == outpn2
        network = 2;
    elseif maxValue == outpn3
        network = 3;
    else
        network = 4;
    end
    current = network;
    end
    subplot(1,1,1);
    plot(t, current, 'b.', 'MarkerSize', 12); % Blue dots for selected network
    hold on;
    ylim([0 5]);
    yticks([1 2 3 4]);
    yticklabels({'wifi 2.4','wifi 5','LTE','5G'});
    xlabel('Time in sec');
    ylabel('network');
    title('Simulation');
    grid on
    pause(0.1);
end