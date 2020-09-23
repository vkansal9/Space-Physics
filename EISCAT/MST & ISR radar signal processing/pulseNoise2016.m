dt=0.5;
t=-5:dt:5;

RxPulse=zeros(1,length(t)*40+1);
N=length(RxPulse);
n=length(t);
sigma=1;whan=0.5+0.5*cos(pi*abs(t)/(max(t)));
pulse=ones(1,n)*3;
%pulse=3*exp(-(abs(t))/sigma^2/2).*whan;
DC=ones(1,N)*0.01;
RxPulse(floor(N/2)-floor(n/2):floor(N/2)+floor(n/2))=pulse;

stdev=0.2;


xInt=0;
rInt=0;
Xint=0;
for k=1:1000
    noise=randn(1,N)*stdev;
    x1=RxPulse;
    x2=RxPulse+noise+DC;
    X1=abs(fft(x1)).^2/N;
    X=abs(fft(x1).*conj(fft(x2)))/N;
    Xint=Xint+X;
    xInt=xInt+x2;
    r=convn(x1,fliplr(x2),'same');
    rInt=r+rInt;
    k
end;

Xint=Xint/k;
rInt=rInt/k;
xInt=xInt/k;
S=fft(rInt)/N;
    
close all
figure(1)
%subplot(3,1,1)
plot(x2,'blue')
hold
plot(xInt,'r')
legend('One realization', 'Integrated pulse including noise and DC')
figure(2)
%subplot(3,1,2)
plot(r,'blue')
hold
plot(rInt,'red')
r1=convn(x1,fliplr(x1),'same');;
plot(r1,'k')
legend('Auto-correlation of one realization', 'Integrated auto-correlation including noise and DC','Auto-correlation of the rectangular pulse')
figure(3)
%subplot(3,1,3)

%Since MATLAB assumes the origin and our function has the origin in the middle, S is complex and we need to take the magnitude (abs)
plot(fftshift(X),'b')
hold
plot(fftshift(abs(S)),'r')
plot(fftshift(abs(Xint)),'g')
plot(fftshift(abs(X1)),'k')
legend('Spectral density  from auto-correlation of one realization (including noise and DC)', 'Spectral density  from integrated auto-correlation (including noise and DC)','Integrated spectral density  from auto-correlation of many realizations (including noise and DC)','(Spectral density for rectangular pulse')
