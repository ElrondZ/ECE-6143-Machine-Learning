transition_p = [0.8, 0.2; 0.2, 0.8]';
emission_p = [0.4, 0.1; 0.1, 0.4; 0.3, 0.2; 0.2, 0.3]';
observed_states = [1,4,2,2,3];
initial_p = emission_p(:,observed_states(1)).*[1;0];
state = [0,1]; 
observe = [1,2,3,4]; 
H = myfunction_p5(transition_p, emission_p, observed_states, initial_p);
result = state(H);
disp(result);