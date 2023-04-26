%%%%%%%%%%% STATE SPACE REPRESENTATION OF THE SYSTEM
% Define the state-space matrices A, B, C, and D
A = [0 1; 0 0];
B = [0; 1];
C = [1 0];
D = 0;

% Create the state-space model
sys = ss(A, B, C, D);

%%%%%%%%%%% The second-order adaptive algorithm

% Define the initial values for the adaptive algorithm
theta_hat = [1; 1];
gamma1 = 0.1;
gamma2 = 0.1;
lambda = 0.1;
k1 = 1;
k2 = 1;

% Define the adaptive algorithm
N = 100;
for i = 1:N
    % Get the current state and input measurements
    x = x_data(:,i);
    u = u_data(:,i);
    
    % Calculate the estimated system parameters
    theta_dot = -gamma1 * x * u' * theta_hat + gamma2 * (k1 * x * x' * theta_hat + k2 * u * u' * theta_hat);
    theta_hat = theta_hat + lambda * theta_dot;
    
    % Use the estimated parameters to update the controller gains
    K = [-theta_hat(1) - theta_hat(2)*s^2, -2*theta_hat(2)*s];
end

%%%%%%%%%%% CONTROLLER

% Define the initial values for the controller
x0 = [0; 0];
K = [-1; -1];
T = 10;
dt = 0.01;

% Define the reference input
t = 0:dt:T;
r = sin(t);

% Simulate the system and controller
x_data = zeros(2, length(t));
u_data = zeros(1, length(t));
x_data(:,1) = x0;

for i = 1:length(t)-1
    % Get the current state measurement
    x = x_data(:,i);
    
    % Calculate the control input using the estimated parameters
    u = -K * x;
    u_data(:,i) = u;
    
    % Apply the control input and simulate the system
    x_dot = A*x + B*u;
    x_data(:,i+1) = x + x_dot*dt;
end