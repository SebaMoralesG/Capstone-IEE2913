% Parametros Circuito

L = 0.02533;
C = 100e-6;
Rd = 25;
R = 15.92;
Cv = 500e-6;
P = 96;
Vd = 60;
Vr = 60/sqrt(2);
f = 50;
w = 2*pi*f;
s = tf('s');
Il = (sqrt(2)*P*cos(0))/Vr;
D = (1/2+sqrt(Vr^2+(w*L*P/Vr)^2)*cos(atan(w*L*P/Vr)));
Z0 = (s^2*L*C*Rd*R+s*C*Rd*R+R)/(s*C*Rd*R+1);

Kp = 2.5;
Ki = 4.5;

% F.T. Vdc y IL
Hvd = (-Z0*2*Il-2*D*Vd)/(s*Cv*Z0+D^2);
Hil = (s*2*Cv*Vd-2*Il*D)/(s*Cv*Z0+D^2);

% Controladores

PIv = (Kp*s+Ki)/s;
PRc = ((s^2+2*pi*s+(2*pi*50)^2)*1.0446)+1000*pi/(s^2+2*pi*s+(2*pi*50)^2);

% Lazos de control

Ti = Hil*PRc;
Hvi = Ti/(1+Ti);
Hvv = Hvd*Hvi/Hil;

% rltool(Hil)

q = -0.47393*(1+0.00025*s)*(1-0.0015*s)*(1+0.041*s)/(s*(1+2.1e-10*s)*(1+0.003*s)*(1+0.04*s));


% 
% bodeHv = figure;
% bodeHi = figure;
% NyHv = figure;
% NyHi = figure;
% 
% figure(bodeHv);
% bode(Hvd);
% grid on
% title("Bode funcion transferencia Vdc");
% figure(bodeHi);
% bode(Hil);
% grid on
% title("Bode funcion transferencia IL");
% 
% figure(NyHv);
% nyquist(Hv);
% 
% figure(NyHi);
% nyquist(Hi);

rltool(Hvd)
rltool(Hil)
