clear ;
close all;

fm = 30;
d = 0.5;
Fs = 6000;
t = 0 : 1/Fs : 0.5;
mt = cos(2*pi*fm*t);
kp = [pi/2,pi,3*pi/2];
Bp = kp;
Au = 5;
fc = 300;
u1 = Au*cos(2*pi*fc*t+Bp(1)*mt);
u2 = Au*cos(2*pi*fc*t+Bp(2)*mt);
u3 = Au*cos(2*pi*fc*t+Bp(3)*mt);

subplot(411), plot(t,mt);
title("message signal");
ylabel("amplitude");
xlabel("time");
legend()
subplot(412), plot(t,u1);
title("modulated signal");
ylabel("amplitude");
xlabel("time");
legend()
subplot(413), plot(t,u2);
title("modulated signal");
ylabel("amplitude");
xlabel("time");
legend()
subplot(414), plot(t,u3);
title("modulated signal");
ylabel("amplitude");
xlabel("time");
legend()
SNR = 5;
Pt = Au*Au/2;
Y1 = awgn(u1,SNR,"measured");
title("noise signal");
ylabel("amplitude");
xlabel("time");
legend()
Y2 = awgn(u2,SNR,"measured");
title("noise signal");
ylabel("amplitude");
xlabel("time");
legend()
Y3 = awgn(u3,SNR,"measured");
title("noise signal");
ylabel("amplitude");
xlabel("time");
legend()
figure(2);
subplot(311),plot(t,Y1);
title("noisy signal");
ylabel("amplitude");
xlabel("time");
legend()
subplot(312),plot(t,Y2);
title("noisy signal");
ylabel("amplitude");
xlabel("time");
legend()
subplot(313),plot(t,Y3);
title("noisy signal");
ylabel("amplitude");
xlabel("time");
legend()

D1 = pmdemod(u1,fc,Fs,Bp(1));
D2 = pmdemod(u2,fc,Fs,Bp(2));
D3 = pmdemod(u3,fc,Fs,Bp(3));
figure(3);
subplot(311),plot(t,D1);
title("demodulated signal");
ylabel("amplitude");
xlabel("time");
legend('D1');
subplot(312),plot(t,D2);
title("demodulated signal");
ylabel("amplitude");
xlabel("time");
legend('D2');
subplot(313),plot(t,D3);
title("demodulated signal");
ylabel("amplitude");
xlabel("time");
legend('D3');
n = 8;
[bl,al]=butter(n,30/(Fs/2),'low');
s1=filter(bl,al,D1);
s2=filter(bl,al,D2);
s3=filter(bl,al,D3);
figure(4);
subplot(311),plot(t,mt);
title("message signal");
ylabel("amplitude");
xlabel("time");
legend('m(t)');
hold on;
plot(t,s1);
title("recovered signal");
ylabel("amplitude");
xlabel("time");
legend('s1(t)');
subplot(312),plot(t,mt);
title("message signal");
ylabel("amplitude");
xlabel("time");
legend('m(t)');
hold on;
plot(t,s2);
title("recovered signal");
ylabel("amplitude");
xlabel("time");
legend('s2(t)');
subplot(313),plot(t,mt);
title("message signal");
ylabel("amplitude");
xlabel("time");
legend('m(t)');
hold on;
plot(t,s3);
title("recovered signal");
ylabel("amplitude");
xlabel("time");
legend('s3(t)');