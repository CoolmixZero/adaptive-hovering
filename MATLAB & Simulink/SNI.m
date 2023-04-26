% Define the parameters for the SNI controller
delta = 1; % DC gain
xi = 0.8; % Damping ratio
wn = 5; % Natural frequency

% Define the transfer function for the SNI controller
s = tf('s');
M = -delta/(s^2 + 2*xi*wn*s + wn^2);

% Define the plant transfer function for the quadcopter
% You will need to replace these values with the actual transfer function for your quadcopter
num = 1;
den = [1 2 1];
P = tf(num, den);

% Define the closed-loop transfer function for the quadcopter with the SNI controller
G = feedback(P*M, 1);

% Define the simulation time and input signal
t = 0:0.01:10;
r = ones(size(t)); % Step input

% Simulate the system and plot the results
[y, t] = lsim(G, r, t);
plot(t, y);
title('Step Response of Quadcopter with Second-Order SNI Controller');
xlabel('Time (s)');
ylabel('Output');
