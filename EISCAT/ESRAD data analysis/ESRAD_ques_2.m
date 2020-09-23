load TXT_20061211_test3.fca;
load TXT_20061211_test4.fca;
load TXT_20061211_test5.fca;
test_3 = TXT_20061211_test3;
test_4 = TXT_20061211_test4;
test_5 = TXT_20061211_test5;

date = ['2006 Dec 11'];

% Barker Coding

Time_3 = unique(test_3(:,1));
Altitude_3 = unique(test_3(:,2));
Size_Time_3 = size(Time_3,1);
Size_Altitude_3 = size(Altitude_3,1);


%SNR Ratio in dB

for i= 1:Size_Altitude_3
    for j= 1: Size_Time_3
        SNR3(i,j) = test_3(i+((j-1)*Size_Altitude_3),4);
    end
end

%Plotting
FigHandle = figure();
hold on
subplot ( 2 , 2 , 1 ) ;
colormap(jet);
pcolor(Time_3,Altitude_3,SNR3);
shading flat;
ylabel('Altitude [km]');
xlabel(['UT/Date: ',date ]);
title('SNR[dB] [ Barker coding]');
set(FigHandle, 'Position', [100, 0, 600, 800]);

c = colorbar ;
c.Label.String = 'SNR[dB]';

% Complementary coding

Time_4 = unique(test_4(:,1));
Altitude_4 = unique(test_4(:,2));
Size_Time_4 = size(Time_4,1);
Size_Altitude_4 = size(Altitude_4,1);


%SNR Ratio in dB

for i= 1:Size_Altitude_4
    for j= 1: Size_Time_4
        SNR4(i,j) = test_4(i+((j-1)*Size_Altitude_4),4);
    end
end

%Plotting
hold on
subplot ( 2 , 2 , 2 ) ;
colormap(jet);
pcolor(Time_4,Altitude_4,SNR4);
shading flat;
ylabel('Altitude [km]');
xlabel(['UT/Date: ',date ]);
title( 'SNR[dB] [Complementary coding]');
c = colorbar ;
c.Label.String = 'SNR[dB]';

% Uncoded data

Time_5 = unique(test_5(:,1));
Altitude_5 = unique(test_5(:,2));
Size_Time_5 = size(Time_5,1);
Size_Altitude_5 = size(Altitude_5,1);


%SNR Ratio in dB

for i= 1:Size_Altitude_5
    for j= 1: Size_Time_5
        SNR5(i,j) = test_5(i+((j-1)*Size_Altitude_5),4);
    end
end

%Plotting
hold on
subplot ( 2 , 2 , 3 ) ;
colormap(jet);
pcolor(Time_5,Altitude_5,SNR5);
shading flat;
ylabel('Altitude [km]');
xlabel(['UT/Date: ',date ]);
title( 'SNR[dB] [Uncoded data]');
c = colorbar ;
c.Label.String = 'SNR[dB]';
hold off

% Values and directions of the horizontal wind 
% Barker Coding
for i= 1:Size_Altitude_3
    for j= 1: Size_Time_3
        Zonal_Wind(i,j)= test_3(i+((j-1)*Size_Altitude_3),5); 
        Meridional_Wind(i,j)= test_3(i+((j-1)*Size_Altitude_3),6);
    end
end
Horizontal_Wind = sqrt((Zonal_Wind .^ 2) + (Meridional_Wind .^ 2));
Direction_angle = atan2(Zonal_Wind, Meridional_Wind);

figure()
subplot(2,2,1);
pcolor(Time_3,Altitude_3,Horizontal_Wind);
shading flat;
colorbar;
title('Horizontal wind speed [m/s], Baker coding signal');
xlabel(['UT/Date:',date]);
ylabel('Altitude [km]');


subplot(2,2,2);
hold on;
whitebg([0.0 .0 .2]);
quiver(Time_3,Altitude_3,Zonal_Wind,Meridional_Wind,'r');
xlabel(['UT/Date:',date]);
title('Horizontal wind Barker Coding');
axis([min(Time_3),max(Time_3),min(Altitude_3),max(Altitude_3)]);

% Complementary Coding
for i= 1:Size_Altitude_4
    for j= 1: Size_Time_4
        Zonal_Wind_2(i,j)= test_4(i+((j-1)*Size_Altitude_4),5); 
        Meridional_Wind_2(i,j)= test_4(i+((j-1)*Size_Altitude_4),6);
    end
end
Horizontal_Wind_2 = sqrt((Zonal_Wind_2 .^ 2) + (Meridional_Wind_2 .^ 2));
Direction_angle_2 = atan2(Zonal_Wind_2, Meridional_Wind_2);

figure()
subplot(2,2,1);
pcolor(Time_4,Altitude_4,Horizontal_Wind_2);
shading flat;
colorbar;
title('Horizontal wind speed [m/s], Complementary coding signal');
xlabel(['UT/Date:',date]);
ylabel('Altitude [km]');


subplot(2,2,2);
hold on;
whitebg([0.0 .0 .2]);
quiver(Time_4,Altitude_4,Zonal_Wind_2,Meridional_Wind_2,'r');
xlabel(['UT/Date:',date]);
title('Horizontal wind Complementary Coding');
axis([min(Time_4),max(Time_4),min(Altitude_4),max(Altitude_4)]);

% Uncoded Data
for i= 1:Size_Altitude_5
    for j= 1: Size_Time_5
        Zonal_Wind_3(i,j)= test_5(i+((j-1)*Size_Altitude_5),5); 
        Meridional_Wind_3(i,j)= test_5(i+((j-1)*Size_Altitude_5),6);
    end
end
Horizontal_Wind_3 = sqrt((Zonal_Wind_3 .^ 2) + (Meridional_Wind_3 .^ 2));
Direction_angle_3 = atan2(Zonal_Wind_3, Meridional_Wind_3);

figure()
subplot(2,2,1);
pcolor(Time_5,Altitude_5,Horizontal_Wind_3);
shading flat;
colorbar;
title('Horizontal wind speed [m/s], Uncoded Data signal');
xlabel(['UT/Date:',date]);
ylabel('Altitude [km]');


subplot(2,2,2);
hold on;
whitebg([0.0 .0 .2]);
quiver(Time_5,Altitude_5,Zonal_Wind_3,Meridional_Wind_3,'r');
xlabel(['UT/Date:',date]);
title('Horizontal wind Uncoded data');
axis([min(Time_5),max(Time_5),min(Altitude_5),max(Altitude_5)]);

