from control.matlab import *
import numpy as np
import matplotlib.pyplot as plt

# Define the system transfer function
num = [1]
den = [1, 2, 1]
sys = TransferFunction(num, den)

# Define the SONIC transfer function
K = 10
wn = 1
s = TransferFunction([1, 0], [1])
G = K * (s**2 + wn**2) / s

# Compute the closed-loop transfer function
cl_sys = feedback(sys * G)

# Plot the step response of the closed-loop system
t = np.linspace(0, 10, 1000)
y, t = step(cl_sys, t)
plt.plot(t, y)
plt.xlabel('Time (sec)')
plt.ylabel('Output')
plt.title('Step response of the SONIC-controlled system')
plt.show()
