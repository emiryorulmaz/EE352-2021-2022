clear ;
clc;
fs = 400 ;
dt = 5;
t1 = 0 : 1/fs : 1;
t2 = 1 : 1/fs : 2;
t3 = 2 : 1/fs : 4;
t4 = 4 : 1/fs : 5;
t = [t1 t2 t3 t4];
x1 = 2*t1;
for i=1:401
    x2(i)=2;
end
x3 = -t3+4;
x4 = 0*t4;
xt = [x1 x2 x3 x4];
figure(1);
plot(t,xt);

t11 = (t1+3)/2; 
t21 = (t2+3)/2;
t31 = (t3+3)/2;
t41 = (t4+3)/2;
tt = [t11 t21 t31 t41];
x11 =2*t11;
for i=1:401
    x21(i)=2;
end
x31 = -t31+4;
x41 = 0*t41;
x2t = [x11 x21 x31 x41];
figure(2);
plot(t,xt);
hold on;
plot(tt,xt);
f = 30;
yt = xt.*cos(2*pi*f*t);
figure(3);
plot(t,yt);

A = 5;
phase = pi/6;
f2 = 100;
Fs = 4000;
phase1 = phase;
phase2 = phase*5;
Fs1 = Fs;
Fs2 = Fs/8;
dt1 = 1/Fs1;
dt2 = 1/Fs2;
tb1 = 0 : dt1 : 0.050;
tb2 = 0 : dt2 : 0.050;
n1 = 0 : 1 : length(tb1);
n2 = 0 : 1 : length(tb2);
xn = A*cos((2*pi*(f/Fs)*n1)+phase1);
xn1 = A*cos((2*pi*(f/Fs2)*n2)+phase2);
figure (4);
plot(n1,xn);
hold on;
plot(n2,xn1);

Ac = 1;
fc = 400;
Fsc= 2000;
dtc = 1/Fsc;
dc = 0.5;
n22 = 0 : 1 : 512;
N = 512;
ff = linspace (-Fsc/2,Fsc/2,N);
xnc = A*cos(2*pi*fc/Fsc*n22);
xnc = fft(xnc,N);
figure(5);
plot(ff,abs(xnc/N));


