function [output]=MED(ind, r, v, t, SC, filters)

output = struct;

x = r(:,1);
y = r(:,2);
z = r(:,3);

v_x = v(:,1);
v_y = v(:,2);
v_z = v(:,3);

[sI_x, sF_x] = segment_MED(t, x, v_x, filters);
[sI_y, sF_y] = segment_MED(t, y, v_y, filters);
[sI_z, sF_z] = segment_MED(t, z, v_z, filters);

%Colocar como input da função o que você quer calcular

[~, ~, ~, ~, wHoff_x, rHoff_x, peak_x] = analyze_elements_MED(t, x, v_x, sI_x, sF_x);
[~, ~, ~, ~, wHoff_y, rHoff_y, peak_y] = analyze_elements_MED(t, y, v_y, sI_y, sF_y);
[~, ~, ~, ~, wHoff_z, rHoff_z, peak_z] = analyze_elements_MED(t, z, v_z, sI_z, sF_z);

wHoff_mean = mean([wHoff_x; wHoff_y; wHoff_z]);
rHoff_mean = mean([rHoff_x; rHoff_y; rHoff_z]);
peak_mean = mean([peak_x; peak_y; peak_z]);

output(1, 1).ind = ind;
output(1, 1).SC = SC;
output(1, 1).w_inertial = wHoff_mean;
output(1, 1).r_inertial = rHoff_mean;
output(1, 1).peak_inertial = peak_mean;
end