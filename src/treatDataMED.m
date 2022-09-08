function [r, v, t] = treatDataMED(file_path, marker, filters)

btk_acq = btkReadAcquisition(file_path);
btk_markers = btkGetMarkers(btk_acq);
btk_unit = btkGetPointsUnit(btk_acq, 'marker');
sample_rate = btkGetPointFrequency(btk_acq);

[b,a] = butter(filters(5), (2*filters(4)) / sample_rate, 'low'); %low pass filter

r = btk_markers.(marker);
if isequal(btk_unit, 'mm')
    r = r / 1000;
elseif isequal(btk_unit, 'cm')
    r = r / 100; 
end

r = filtfilt(b, a, r);

v = diff(r) * sample_rate;

r = r(1 : end - 1, :);

size = length(v);
t = (1 : size) / sample_rate; t = t';

end