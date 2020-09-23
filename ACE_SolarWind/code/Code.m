clear all;
close all;
load('20020509_data.mat')
s = size(BX);

A(:,1) = BX';
A(:,2) = BY';
A(:,3) = BZ';

zerotime=matlab_time-matlab_time(1);

miu_zero=1.2566370614*10^(-6); % permeability of vacuum
echarge=1.602677*10^(-19);
Boltzk=1.3806488*10^(-23);
Bx=BX/10^9;
By=BY/10^9;
Bz=BZ/10^9;
xgse=X_gse*6378000;
ygse=Y_gse*6378000;
zgse=Z_gse*6378000;

% temperature recalculation, T still in eV, needs to be in K. T is tensor
% so (Tpar+2Tperp)/3 happens
T=(Tpar_H+2*Tperp_H)/3*echarge/(Boltzk); % for temeprature /3 , for plasma_Beta /2

figure(1); % plot the velocity, density, temperature
xlim1=0.0043;
xlim2=0.25046;
ylim1=-50;
ylim2=50;

subplot(4,1,1);
plot(matlab_time,n_H);
datetick('x','HH:MM:SS');
xlabel('Time [hh:mm:ss]');
ylabel('n_{prot} [#/cm^3]');
title('Proton Number density')
subplot(4,1,2);
plot(matlab_time,vpar_H);
datetick('x','HH:MM:SS');
xlabel('Time [hh:mm:ss]');
ylabel('v_{par} [km/s]');
title('Proton bulk velocity parallel to B')
subplot(4,1,3);
plot(matlab_time,vperp_H);
datetick('x','HH:MM:SS');
xlabel('Time [hh:mm:ss]');
ylabel('v_{perp} [km/s]');
title('Proton bulk velocity perpendicular to B')
subplot(4,1,4);
plot(matlab_time,T);
datetick('x','HH:MM:SS');
xlabel('Time [hh:mm:ss]');
ylabel('T_{prot} [K]');
title('Proton temperature')

% plasma Beta
% change according to basic units - n_H (cm to m), B (nT to T), Temperature
% (eV to J) and again (Tpar+2Tperp)/2 this time, B = sqrt(BX^2+BY^2+BZ^2), but sqrt goes away with power2 in
% equation for plasmaBeta
plasma_Beta=(10^6*n_H.*(Tpar_H+2*Tperp_H)/2*echarge)./((BX.^2+BY.^2+BZ.^2)*10^(-18)/(2*miu_zero));

figure(2); % plot of the plasma beta and mag field

subplot(4,1,1);
plot(matlab_time,plasma_Beta);
datetick('x','HH:MM:SS');
xlabel('Time [hh:mm:ss]');
ylabel('Pl. Beta [-]');
title('Plasma Beta')
subplot(4,1,2);
plot(matlab_time,BX);
datetick('x','HH:MM:SS');
xlabel('Time [hh:mm:ss]');
ylabel('BX [nT]');
title('Magnetic field in X-dir.')
subplot(4,1,3);
plot(matlab_time,BY);
datetick('x','HH:MM:SS');
xlabel('Time [hh:mm:ss]');
ylabel('BY [nT]');
title('Magnetic field in Y-dir.')
subplot(4,1,4);
plot(matlab_time,BZ);
datetick('x','HH:MM:SS');
xlabel('Time [hh:mm:ss]');
ylabel('BZ [nT]');
title('Magnetic field in Z-dir.')
TickDownUp = [  
                295 300;
                430 455;
                506 513;
                660 704;
                764 795;
                863 895;
                944 984;
                1465 1500;
                1542 1581;
                1640 1677;
                1677 1713;
                          ];
        
t=size(TickDownUp);

for tick=1:t(1)
    for i=1:3;
        for j=1:3;
            M(i,j)=mean(A(TickDownUp(tick,1):TickDownUp(tick,2),i).*A(TickDownUp(tick,1):TickDownUp(tick,2),j))-mean(A(TickDownUp(tick,1):TickDownUp(tick,2),i))*mean(A(TickDownUp(tick,1):TickDownUp(tick,2),j));
        end;
    end;
    
    [V,D]=eig(M)
    f(1)=D(1);
    f(2)=D(5);
    f(3)=D(9);
    
    eigen=min(f);
    Index=find(f==eigen);
    switch(Index)
        case 1
            Normal(tick,1)=V(1);
            Normal(tick,2)=V(2);
            Normal(tick,3)=V(3);
        case 2
            Normal(tick,1)=V(4);
            Normal(tick,2)=V(5);
            Normal(tick,3)=V(6);
        case 3
            Normal(tick,1)=V(7);
            Normal(tick,2)=V(8);
            Normal(tick,3)=V(9);
    end;
end;

for i=1:t
    LocAtTics(i,1)=X_gse(round(mean(TickDownUp(i,:),2)));
    LocAtTics(i,2)=Y_gse(round(mean(TickDownUp(i,:),2)));
    LocAtTics(i,3)=Z_gse(round(mean(TickDownUp(i,:),2)));
end

figure(3);
plot3(X_gse,Y_gse,Z_gse,'LineWidth',2), hold on
xlabel('X_{gse} [RE]');
ylabel('Y_{gse} [RE]');
zlabel('Z_{gse} [RE]');
title('Sat. poss. in Space in GSE coord. + Magnetopause normal for each crossing')
for i=1:t
    plot3([LocAtTics(i,1),LocAtTics(i,1)+Normal(i,1)],[LocAtTics(i,2),LocAtTics(i,2)+Normal(i,2)],[LocAtTics(i,3),LocAtTics(i,3)+Normal(i,3)])
%     jj=num2str(zerotime(round(mean(TickDownUp(i,:),2))));
%     text(LocAtTics(i,1),LocAtTics(i,2),LocAtTics(i,3),jj)
    nmbr=num2str(i);
    text(LocAtTics(i,1)+Normal(i,1),LocAtTics(i,2)+Normal(i,2),LocAtTics(i,3)+Normal(i,3),nmbr);
end
grid on;
hold off;


% J calculation

for i=1:t
    Bfield(i,1) = (Bz(TickDownUp(i,2))-Bz(TickDownUp(i,1)))/(ygse(TickDownUp(i,2))-ygse(TickDownUp(i,1)))-(By(TickDownUp(i,2))-By(TickDownUp(i,1)))/(zgse(TickDownUp(i,2))-zgse(TickDownUp(i,1)));
    Bfield(i,2) = (Bx(TickDownUp(i,2))-Bx(TickDownUp(i,1)))/(zgse(TickDownUp(i,2))-zgse(TickDownUp(i,1)))-(Bz(TickDownUp(i,2))-Bz(TickDownUp(i,1)))/(xgse(TickDownUp(i,2))-xgse(TickDownUp(i,1)));
    Bfield(i,3) = (By(TickDownUp(i,2))-By(TickDownUp(i,1)))/(xgse(TickDownUp(i,2))-xgse(TickDownUp(i,1)))-(Bx(TickDownUp(i,2))-Bx(TickDownUp(i,1)))/(ygse(TickDownUp(i,2))-ygse(TickDownUp(i,1)));
J(i)=sqrt(Bfield(i,1).^2+Bfield(i,2).^2+Bfield(i,3).^2)/miu_zero;

end
J'

 % additional pics
 subplot(2,1,1);
plot(matlab_time(1:1100),n_H(1:1100)), hold on
datetick('x','HH:MM:SS');
axis([matlab_time(1) matlab_time(1100) 0 13]);
xlabel('Time [hh:mm:ss]');
ylabel('n_{prot} [#/cm^3]');
title('Proton Number density until 09:12:30');
for i=1:7
    nmbr=num2str(i);
    plot(matlab_time(round(mean(TickDownUp(i,:),2))),n_H(round(mean(TickDownUp(i,:)))),'*');
    text(matlab_time(7+round(mean(TickDownUp(i,:),2))),n_H(round(mean(TickDownUp(i,:),2))),nmbr,'FontSize',15);
    cross(i)=(matlab_time(round(mean(TickDownUp(i,:),2))));
end;
hold off;
subplot(2,1,2);
plot(matlab_time(1101:2209),n_H(1101:2209)), hold on
datetick('x','HH:MM:SS');
axis([matlab_time(1101) matlab_time(2209) 0 17]);
xlabel('Time [hh:mm:ss]');
ylabel('n_{prot} [#/cm^3]');
title('Proton Number density from 09:12:30')
for i=8:11
    nmbr=num2str(i);
    plot(matlab_time(round(mean(TickDownUp(i,:),2))),n_H(round(mean(TickDownUp(i,:)))),'*');
    text(matlab_time(7+round(mean(TickDownUp(i,:),2))),n_H(round(mean(TickDownUp(i,:),2))),nmbr,'FontSize',15);
    cross(i)=(matlab_time(round(mean(TickDownUp(i,:),2))));
end;
hold off; 
