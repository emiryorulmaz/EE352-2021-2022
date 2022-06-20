clc ;
clear all;
close all;
Fs = 3000;
dt = 0.6;
N = 512 ;
n1 = 0 : dt : Fs;
f = linspace(-Fs/2,Fs/2,N);
x1n = cos((2*pi*200*n1)/Fs);
x2n = sin((2*pi*500*n1)/Fs);
xn = x1n + x2n;
xnf = fft(xn,N);
xnft = fftshift(abs(xnf)/N);
figure(1);
plot(f,xnft);
title(" X(f)");
legend("x");
xlabel("frequency");
ylabel("amplitude");



Fs2 = 5000;
dt2 = 0.3;
n2 = 0 : dt2 : Fs2;
N2 = 1024;
xn2 = cos(2*pi*500*n2/Fs2) + 0.5*cos(2*pi*1400*n2/Fs2);
fband = [300 700];
[bbp, abp] = butter(10, fband ./ (Fs2 / 2), 'bandpass');
[Hbp, Fbp]=freqz(bbp, abp, Fs/2);
y1 = filter(bbp, abp,xn2);
fhigh = 1000 ;
[bh, ah] = butter(10 ,fhigh / (Fs2 / 2), 'high');
[Hhp, Fhp]=freqz(bh, ah,Fs2/2);
y2 = filter(bh,ah,xn2);
f2 = linspace(-Fs2/2,Fs2/2,N2);
xn2f = fft(xn2,N2);
xn2ft = fftshift(abs(xn2f)/N2);
y1f = fft(y1,N2);
y1ft = fftshift(abs(y1f)/N2);
y2f = fft(y2,N2);
y2ft = fftshift(abs(y2f)/N2);

figure(2);
plot(Fhp,abs(Hhp));
hold on;
plot(Fbp,abs(Hbp));


figure(3);
plot(f2,y1ft);
hold on;
plot(f2,y2ft);
