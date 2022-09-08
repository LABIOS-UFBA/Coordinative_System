function [wHoff,rHoff]=fit_Hoff_MED(t,v)

v_mean = mean(v);

t_Hoff=linspace(0,1,length(t));

Hoff=v_mean*30*( (t_Hoff.^4) -2*(t_Hoff.^3) + (t_Hoff.^2));

dvHoff=Hoff'-v;

wHoff=std(dvHoff)/abs(v_mean);

rHoff=corrcoef(Hoff,v);
rHoff=rHoff(1,2).^2;
end
