% Define the parameters for the SNI controller
delta = 1; % DC gain
xi = 0.8; % Damping ratio
wn = 5; % Natural frequency

% Define the transfer function for the SNI controller
s = tf('s');
M = -(delta/(s^2 + 2*xi*wn + wn^2));

out = sim('Quadrotor_UAV_Trajectory_and_Control_Design.slx');

% Define the plant transfer function for the quadcopter
% You will need to replace these values with the actual transfer function for your quadcopter
num = 1;
%den = [1 2 1];
den = [0.85, 1.3, 1.2];
P = tf(num, den);

sys_z = tf([0.0126, 0, 2.534], [1, 1.725, 0.0724]);
sys_x = tf([3.312, 195.264], [1, 174.657 3.123]);
sys_y = tf([0.00472, 0.945], [1, 0.85, 0.232]);

% Define the closed-loop transfer function for the quadcopter with the SNI controller
G = feedback(P*M, 1);
%G = feedback(P*M, 1);

% Define the simulation time and input signal
t = 0:0.01:100;
r = ones(size(t)); % Step input

% Simulate the system and plot the results
[y, t] = lsim(G, r, t);
plot(t, y)
%plot(out.simout.Time, out.simout.Data);
title('Step Response of Quadcopter with Second-Order SNI Controller');
xlabel('Time (s)');
ylabel('Output');
