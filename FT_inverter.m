% Parametros Circuito

P = 120;
Vd = 60;
Vr = 60/sqrt(2);
f = 50;
w = 2*pi*f;
s = tf('s');
Cdc = 500e-6;
C = 600e-6;
L = 0.01688;
R1 = 0.0;
R2 = 0.0;
R = 5.3052;
Zeq = (s^2*L*C*(R+R2)+s*(L+C*(R1*R+R1*R2+R2*R))+R+R1)/(1+s*C*(R+R2));

SensC = 0.2;
SensV = 0.006;

I0 = sqrt(2)*P/Vr;
D0 = 1/2+sqrt(Vr^2+(w*L*P/Vr)^2)/(sqrt(2)*Vd)*cos(atan(w*L*P/Vr^2));

G_vdc_d = -(Zeq*2*I0+D0*2*Vd)/(s*Cdc*Zeq+D0^2);
G_il_d = (s*Cdc*2*Vd-2*I0*D0)/(s*Cdc*Zeq+D0^2);
Bode_Vdc = figure;
Bode_IL = figure;
% figure(Bode_Vdc);
% bode(G_vdc_d)
figure(Bode_IL);
% bode(G_il_d)

% Filtros
% PR
Kp = L*2*1700*pi/(2*Vd);
Kr = 200*pi*s/(s^2+2*pi+w^2);
PR = Kp+Kr;
CLoopIL = series(G_il_d,PR);
bode(CLoopIL)
G_il_vc = CLoopIL/(SensC*(1+CLoopIL));
G_vdc_vc = G_vdc_d*G_il_vc/G_il_d;
rltool(G_vdc_vc)



