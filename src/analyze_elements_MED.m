function [N, D, V, T, wHoff, r2Hoff, peak] = analyze_elements_MED(t, x, v, sI, sF)

N = length(sI);
nan_vec = nan(N, 1);
D = nan_vec; V = nan_vec; T = nan_vec; wHoff = nan_vec; r2Hoff = nan_vec; peak = nan_vec;

for i = 1 : N
    
    D(i) = x(sF(i)) - x(sI(i));
    T(i) = t(sF(i)) - t(sI(i));
    V(i) = mean(v(sI(i) : sF(i)));
    
    [wHoff(i), r2Hoff(i)] = fit_Hoff_MED(t(sI(i) : sF(i)), v(sI(i) : sF(i)));
    
    [~,pk] = findpeaks(abs(v(sI(i) : sF(i))));
    peak(i) = length(pk);

end

end