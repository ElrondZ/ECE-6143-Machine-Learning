function [H] = myfuction_p5(transition_p, emission_p, observed_states, initial_p)
    t = size(transition_p, 1);
    n = size(observed_states, 2);
    psi= zeros(t, t, n);
    phi = zeros(t, n);
    phi(:,1) = initial_p;
    for i=2:n
        k=observed_states(1,i);
        psi(:, :, i) = diag(phi(:, i - 1)) * transition_p * diag(emission_p(:,k));
        phi(:, i) = max(psi(:, :, i));
    end
    for i= n-1 : -1 : 1
        phi_new = max(psi(:, :, i + 1), [], 2);
        psi(:, :, i) = psi(:, :, i) * diag(phi_new ./ phi(:, i));
        phi(:, i) = phi_new;
    end
        [~, H] = max(phi);
end
