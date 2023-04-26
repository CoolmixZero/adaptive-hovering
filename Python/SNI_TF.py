import numpy as np
import control.matlab as ctrl

# Vertical Loop Transfer Function
dz = np.array([0.0126, 2.534])
bz = np.array([1.725, 0.0431])
cz = np.array([0.0724])
A = np.polymul([1, -dz[0]], [1, -dz[1]])
B = np.polymul([1, -bz[0]], [1, -bz[1]])
C = cz
D = [0]
Vloop_tf = ctrl.tf(B, A)

# X-Axis Loop Transfer Function
dx = np.array([3.312, 195.264])
bx = np.array([174.657, 0.0179])
cx = np.array([3.123])
A = np.polymul([1, -dx[0]], [1, -dx[1]])
B = np.polymul([1, -bx[0]], [1, -bx[1]])
C = cx
D = [0]
Xloop_tf = ctrl.tf(B, A)

# Y-Axis Loop Transfer Function
dy = np.array([0.00472, 0.945])
by = np.array([0.85, 0.4248])
cy = np.array([0.232])
A = np.polymul([1, -dy[0]], [1, -dy[1]])
B = np.polymul([1, -by[0]+0.227j], [1, -by[0]-0.227j])
C = cy
D = [0]
Yloop_tf = ctrl.tf(B, A)

# Simulating load mass variations
bx_low, bx_high = 157.191, 192.122
cx_low, cx_high = 2.81088, 3.4355
by_low, by_high = 0.765, 0.935
cy_low, cy_high = 0.2088, 0.2552
bz_low, bz_high = 1.5525, 1.8975
cz_low, cz_high = 0.06516, 0.07964

Vloop_tf_den = Vloop_tf.den[0][0]
Vloop_tf_den_low = np.array([1, -dz[0]*1.1, -dz[1]*1.1])
Vloop_tf_den_high = np.array([1, -dz[0]*0.9, -dz[1]*0.9])
Vloop_tf_low = ctrl.tf(B, Vloop_tf_den_low)
Vloop_tf_high = ctrl.tf(B, Vloop_tf_den_high)

Xloop_tf_den = Xloop_tf.den[0][0]
Xloop_tf_den_low = np.array([1, -dx[0]*1.1, -dx[1]*1.1])
Xloop_tf_den_high = np.array([1, -dx[0]*0.9, -dx[1]*0.9])
Xloop_tf_low = ctrl.tf(B, Xloop_tf_den_low)
Xloop_tf_high = ctrl.tf(B, Xloop_tf_den_high)

Yloop_tf_den = Yloop_tf.den[0][0]
Yloop_tf_den_low = np.array([1, -dy[0]*1.1, -dy[1]*1.1])
Yloop_tf_den_high = np.array([1, -dy[0]*0.9, -dy[1]*0.9])
Yloop_tf_low = ctrl.tf(B, Yloop_tf_den_low)
Yloop_tf_high = ctrl.tf(B, Yloop_tf_den_high)

print("Yloop_tf_low:", Yloop_tf_low)
print("Yloop_tf_high:", Yloop_tf_high)
