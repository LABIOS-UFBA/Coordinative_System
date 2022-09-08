function [segI, segF]=segment_MED(t, r, v, filters)

limD = filters(1);
limT = filters(2);
limV = filters(3);

[~, pkM] = findpeaks(v);
[~, pkm] = findpeaks(-v);
pk(:, 1) = sort([pkm; pkM]);
pk(:, 2) = nan(length(pk), 1);
pk(v(pk(:, 1)) > limV, 2) = 1;
pk(v(pk(:, 1)) < -limV, 2) = -1;
pk(and(v(pk(:, 1)) < limV, v(pk(:, 1)) > -limV), 2) = 0;
endpk = size(pk, 1);
i = 1;

if endpk < 3          %precisa de pelo menos 3 picos para funcionar o findpeaks
    segI = 1;
    segF = length(r);
    return;
end

while 1
    if i == endpk
        break;
    end
    if pk(i, 2) - pk(i + 1, 2) == -2 || pk(i ,2) - pk(i + 1, 2) == 2
        [~, ind] = min(abs(v(pk(i) : pk(i + 1, 1), 1)));
        ind = ind + pk(i, 1) - 1;
        pk = [pk(1 : i, :); [ind, 0]; pk(i + 1 : end, :)];
        endpk = endpk + 1;
    end
    i = i + 1;
end

pk(:, 2) = abs(pk(:, 2));

[~, segI] = findpeaks(pk(:, 2));
[~, segF] = findpeaks(flip(pk(:, 2)));
segF = sort(length(pk) - segF + 1);

segI = segI - 1;
segF = segF + 1;

segI = pk(segI, 1);
segF = pk(segF, 1);

auxI = nan(size(segI));
auxF = auxI;
j = 1;

for i = 1 : length(segI) - 1
    disp = r(segF(i)) - r(segI(i));
    dura = t(segF(i)) - t(segI(i));
    if abs(disp) >= limD && abs(dura) >= limT
        auxI(j) = segI(i);
        auxF(j) = segF(i);
        j = j + 1;
    end
end

segI = (auxI(~isnan(auxI)));
segF = (auxF(~isnan(auxF)));
end

