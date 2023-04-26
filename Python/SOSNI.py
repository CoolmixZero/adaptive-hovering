import numpy as np
import control as ctrl

# Define the SNI controller parameters
delta = 1.0   # dc gain
xi = 0.5      # damping ratio
wn = 1.0      # natural frequency

# Define the transfer function of the SNI controller
num = [-delta, 0, 0]
den = [1, 2*xi*wn, wn**2]
sni_tf = ctrl.tf(num, den)

# Define the Type-2 fuzzy mechanism


def fuzzy_controller(pos_error):
    # Define the membership functions for the input variables
    pos_error_mf = ctrl.trapmf(pos_error, [-10, -5, 5, 10])

    # Define the membership functions for the output variables
    delta_mf = ctrl.trimf(delta, [0.8, 1.0, 1.2])
    xi_mf = ctrl.trimf(xi, [0.4, 0.5, 0.6])
    wn_mf = ctrl.trimf(wn, [0.8, 1.0, 1.2])

    # Define the fuzzy rules
    rule1 = ctrl.Rule(pos_error_mf, (delta_mf, xi_mf, wn_mf))

    # Define the fuzzy system
    sni_fuzzy = ctrl.ControlSystem([rule1])

    # Define the controller using the fuzzy system
    sni_ctrl = ctrl.ControlSystemSimulation(sni_fuzzy)

    # Evaluate the output of the fuzzy controller
    sni_ctrl.input['pos_error'] = pos_error
    sni_ctrl.compute()

    # Extract the SNI controller parameters
    delta_fuzzy = sni_ctrl.output['delta']
    xi_fuzzy = sni_ctrl.output['xi']
    wn_fuzzy = sni_ctrl.output['wn']

    # Return the SNI controller transfer function
    num_fuzzy = [-delta_fuzzy, 0, 0]
    den_fuzzy = [1, 2*xi_fuzzy*wn_fuzzy, wn_fuzzy**2]
    sni_tf_fuzzy = ctrl.tf(num_fuzzy, den_fuzzy)
    return sni_tf_fuzzy
