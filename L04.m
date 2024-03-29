clc;
clear;
close all;

fm = 80;
fc = 600;
fs = 10000;
t = 0 : 1/fs : 0.25;
mt = 4*cos(2*pi*fm*t);
ct = cos(2*pi*fc*t);
st = mt.*ct;
figure(1);
subplot(311),plot(t,mt);
ylabel("amplitude");
xlabel("time");
title("mt");
subplot(312),plot(t,ct);
ylabel("amplitude");
xlabel("time");
title("ct");
subplot(313),plot(t,st);
ylabel("amplitude");
xlabel("time");
title("st");

N = length(mt);
f = linspace(-fs/2,fs/2,N);
mtf = fft(mt,N);
mtff = fftshift(abs(mtf)/N);
stf = fft(st,N);
stff = fftshift(abs(stf)/N);
figure(2);
subplot(211),plot(f,mtff);
axis([-2000 2000 0 2]);
ylabel("amplitude");
xlabel("frequency");
title("m(f)");
subplot(212),plot(f,stff);
axis([-2000 2000 0 2]);
ylabel("amplitude");
xlabel("frequency");
title("s(f)");
osc = 2*cos(2*pi*(fc+40)*t);
vt = st.*osc;
vtf = fft(vt,N);
vtff = fftshift(abs(vtf)/N);
figure(3);
plot(f,vtff);
ylabel("amplitude");
xlabel("frequency");
title("vt(f)");
flow = 60;
[b,a] = butter(5, flow/(fs/2),"low");
vt0 = filter(b,a,vt);
vt0f = fft(vt0,N);
vt0ff = fftshift(abs(vt0f)/N);
figure(4);
subplot(211),plot(t,vt0);
ylabel("amplitude");
xlabel("time");
title("vt0");
subplot(212),plot(f,vt0ff);
ylabel("amplitude");
xlabel("frequency");
title("v0(f)");
axis([-2000 2000 0 2]);