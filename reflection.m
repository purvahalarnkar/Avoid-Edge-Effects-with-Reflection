clc
clear all
close all

%create a signal with random numbers within frequency boundaries
N=500; 
hz=linspace(0,1,N);
nyquist=0.5;

%generate gaussian
g=exp(-(4*log(2)*(hz-0.1)/0.1).^2)*N/2; 
%Pointwise multiply gaussian by random phase value 
%Insert them into Euler's formula to generate complex unit length random vectors
signal=real(ifft(g.*exp(1i*rand(1,N)*2*pi)))+ rand(1,N);

%plot the signal
subplot(321)
plot(1:N,signal,'k')
set(gca,'xlim',[0 N+1])
title('Original signal')
xlabel('Time points')

%power spectrum
subplot(322)
plot(hz,abs(fft(signal)).^2,'k')
set(gca,'xlim',[0 nyquist],'ylim',[0 2e4]) %sampling rate 0.5*2= 1 Hz
xlabel('Frequency (Hz)')
title('Power spectrum of original signal')

%Apply low pass zero phase-shift fliter
order=150;
cutoff=0.3/nyquist;
fkern=fir1(order,cutoff,'low');
fsignal=filter(fkern,1,signal);
fsignal=filter(fkern,1,fsignal(end:-1:1));
fisgnal=fsignal(end:-1:1);

%plot
subplot(323)
plot(1:N,signal,'k')
hold on
plot(1:N,fsignal,'m')
title('Filtered signal, no reflection')
xlabel('Time points')
legend('Original signal','Fileterd, no reflection')

%power spectrum
subplot(324)
plot(hz,abs(fft(signal)).^2,'k')
hold on
plot(hz,abs(fft(fsignal)).^2,'m')
set(gca,'xlim',[0 nyquist],'ylim',[0 2e4]) %sampling rate 0.5*2= 1 Hz
xlabel('Frequency (Hz)')
title('Power spectrum of filtered signal')
legend('Original signal','Fileterd, no reflection')

%reflection by filter order
reflectsig=[signal(order:-1:1) signal signal(end:-1:end-order+1)];

%zero phase-shift filter on the reflected signal
reflectsig=filter(fkern,1,reflectsig);
reflectsig=filter(fkern,1,reflectsig(end:-1:1));
reflectsig=reflectsig(end:-1:1);

%cut off reflected part
fsignalref=reflectsig(order+1:end-order);
%plot
subplot(325)
plot(1:N,signal,'k')
hold on
plot(1:N,fsignalref,'m')
title('Filtered signal with reflection')
xlabel('Time points')
legend('Original signal','Fileterd, with reflection')

%power spectrum
subplot(326)
plot(hz,abs(fft(signal)).^2,'k')
hold on
plot(hz,abs(fft(fsignalref)).^2,'m')
set(gca,'xlim',[0 nyquist],'ylim',[0 2e4]) %sampling rate 0.5*2= 1 Hz
xlabel('Frequency (Hz)')
title('Power spectrum of filtered signal with reflection')
legend('Original signal','Fileterd, with reflection')



