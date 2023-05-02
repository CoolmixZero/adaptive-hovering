% Define input variables
x = linspace(0,10,101);
y = linspace(0,10,101);

% Define fuzzy sets
%A = [1 0 3; 5 3 8; 2 4 6; 2 5 7; 2 4 7; 7 4 4; 42 36 7; 234 654 2; 324 456 23];
%B = [2 3 7; 9 1 5; 8 8 3; 742 32 4; 123 5 3; 1234 3 4; 45 4 1; 6 132 56; 13 28 92];

A = [1 0 3; 5 3 8; 2 4 6];
B = [2 3 7; 9 1 5; 8 8 3];

%A=[-1.5 -1.5 -.5 1.5 -1.5 -1.5 -1.5 .5 1  -1.5 -1.5 -.5 1.5 -1.5 -1.5 -1.5 .5  1
%   -1.5 -1.5 -.5 1.5 -1.5 -1.5 -1.5 .5 1  -1.5   .5 1.5 1.5  -.5  1.5  1.5 1.5 1
 %  -1.5   .5 1.5 1.5  -.5  1.5  1.5 1.5 1  -1.5 -1.5 -.5 1.5 -1.5 -1.5 -1.5 .5  1
  % -1.5   .5 1.5 1.5  -.5  1.5  1.5 1.5 1  -1.5   .5 1.5 1.5  -.5  1.5  1.5 1.5 1];
%B=[-1 -.9; -.6 -.4; .4 .6; .9 1];

% Define the interval type-2 fuzzy set
for i=1:length(x)
    for j=1:length(y)
        A2(i,j) = max(min(1, (A(1) + (A(2)-A(1))*((x(i)-0)/(10-0))) ...
            * (A(4) + (A(3)-A(4))*((y(j)-0)/(10-0)))),0);
        B2(i,j) = max(min(1, (B(1) + (B(2)-B(1))*((x(i)-0)/(10-0))) ...
            * (B(4) + (B(3)-B(4))*((y(j)-0)/(10-0)))),0);
    end
end

% Define the fuzzy rules
for i=1:length(x)
    for j=1:length(y)
        if A2(i,j) >= B2(i,j)
            R(i,j) = A2(i,j);
        else
            R(i,j) = B2(i,j);
        end
    end
end

% Defuzzify the fuzzy set
z = sum(sum(R.*(x').*y)) / sum(sum(R));

% Plot the fuzzy sets and the result
figure;
subplot(2,2,1);
surf(x,y,A2');
title('A');
subplot(2,2,2);
surf(x,y,B2');
title('B');
subplot(2,2,[3 4]);
surf(x,y,R');
hold on;
plot3([z z],[0 10],[1.1*max(max(R)) 1.1*max(max(R))],'k','LineWidth',2);
plot3([0 10],[z z],[1.1*max(max(R)) 1.1*max(max(R))],'k','LineWidth',2);
title(['Result: ',num2str(z)]);
