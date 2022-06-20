clc ;
clear all;
close all;


IMG = imread("cameraman.tif");

A = im2double(IMG);
FS = size(A,1)*size(A,2);
IMGMatrix = reshape(A,1,[]);
t = 0:(1/FS):(numel(IMGMatrix)-1)/FS;
f = linspace(-FS/2,FS/2,length(t));
Mt = fftshift(fft(IMGMatrix,length(t)))/length(t);
plot(f,abs(Mt))

% modulation
kf = 27000;
fcdsb = 16000;
fcfm = 4000;
dt = 1/FS;
ct = cos(2*pi*fcdsb*t);
fm = cos(2*pi*4000*t+2*pi*kf*cumsum(IMGMatrix*dt));
x = ct.*IMGMatrix;
SNR = [0 5 10 20 30];

x_1 = awgn(x,SNR(1));
x_2 = awgn(x,SNR(2));
x_3 = awgn(x,SNR(3));
x_4 = awgn(x,SNR(4));
x_5 = awgn(x,SNR(5));

xfm_1 = awgn(fm,SNR(1));
xfm_2 = awgn(fm,SNR(2));
xfm_3 = awgn(fm,SNR(3));
xfm_4 = awgn(fm,SNR(4));
xfm_5 = awgn(fm,SNR(5));

% demodulation 
[b,a] = butter(2,(13500)/((FS/2)));
filtered1 = 2*filter(b,a,x_1);
filtered2 = 2*filter(b,a,x_2);
filtered3 = 2*filter(b,a,x_3);
filtered4 = 2*filter(b,a,x_4);
filtered5 = 2*filter(b,a,x_5);

demod1 = fmdemod(xfm_1,fcfm,FS,kf);
demod2 = fmdemod(xfm_2,fcfm,FS,kf);
demod3 = fmdemod(xfm_3,fcfm,FS,kf);
demod4 = fmdemod(xfm_4,fcfm,FS,kf);
demod5 = fmdemod(xfm_5,fcfm,FS,kf);

%figure(2);
%filtered3_fft = fftshift(fft(filtered3,length(t)))/length(t);
%demod3_fft = fftshift(fft(demod3,length(t)))/length(t);
%subplot(211),plot(f,abs(filtered3_fft));
%subplot(212),plot(f,abs(demod3_fft));

figure(3);
reshaped1 = reshape(filtered1,256,256);
reshaped2 = reshape(filtered2,256,256);
reshaped3 = reshape(filtered3,256,256);
reshaped4 = reshape(filtered4,256,256);
reshaped5 = reshape(filtered5,256,256);

reshaped11 = reshape(demod1,256,256);
reshaped12 = reshape(demod2,256,256);
reshaped13 = reshape(demod3,256,256);
reshaped14 = reshape(demod4,256,256);
reshaped15 = reshape(demod5,256,256);

subplot(251);
imshow(reshaped1);
title(num2str(psnr(reshaped1,A)));
subplot(252);
imshow(reshaped2);
title(num2str(psnr(reshaped2,A)));
subplot(253);
imshow(reshaped3);
title(num2str(psnr(reshaped3,A)));
subplot(254);
imshow(reshaped4);
title(num2str(psnr(reshaped4,A)));
subplot(255);
imshow(reshaped5);
title(num2str(psnr(reshaped5,A)));
subplot(256);
imshow(reshaped11);
title(num2str(psnr(reshaped11,A)));
subplot(257);
imshow(reshaped12);
title(num2str(psnr(reshaped12,A)));
subplot(258);
imshow(reshaped13);
title(num2str(psnr(reshaped13,A)));
subplot(259);
imshow(reshaped14);
title(num2str(psnr(reshaped14,A)));
subplot(2,5,10);
imshow(reshaped15);
title(num2str(psnr(reshaped15,A)));
