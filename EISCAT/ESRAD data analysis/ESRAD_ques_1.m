load TXT_20061211_test1.fca;
load TXT_20061211_test2.fca;
test_1 = TXT_20061211_test1;
test_2 = TXT_20061211_test2;

date = ['2006 Dec 11'];

% SNR at 150m height resolution

Time_1 = unique(test_1(:,1));
Altitude_1 = unique(test_1(:,2));
Size_Time_1 = size(Time_1,1);
Size_Altitude_1 = size(Altitude_1,1);


%SNR Ratio in dB

for i= 1:Size_Altitude_1
    for j= 1: Size_Time_1
        SNR(i,j) = test_1(i+((j-1)*Size_Altitude_1),4);
    end
end

%Plotting
FigHandle = figure();
hold on
subplot ( 2 , 2 , 1 ) ;
colormap(jet);
pcolor(Time_1,Altitude_1,SNR);
shading flat;
ylabel('Altitude [km]');
xlabel(['UT/Date: ',date ]);
title('SNR at 150m height resolution');
set(FigHandle, 'Position', [100, 0, 600, 800]);

c = colorbar ;
c.Label.String = 'SNR[dB]';

% SNR at 1200m height resolution

Time_2 = unique(test_2(:,1));
Altitude_2 = unique(test_2(:,2));
Size_Time_2 = size(Time_2,1);
Size_Altitude_2 = size(Altitude_2,1);


%SNR Ratio in dB

for i= 1:Size_Altitude_2
    for j= 1: Size_Time_2
        SNR2(i,j) = test_2(i+((j-1)*Size_Altitude_2),4);
    end
end

%Plotting
hold on
subplot ( 2 , 2 , 2 ) ;
colormap(jet);
pcolor(Time_2,Altitude_2,SNR2);
shading flat;
ylabel('Altitude [km]');
xlabel(['UT/Date: ',date ]);
title( 'SNR at 1200m height resolution');
c = colorbar ;
c.Label.String = 'SNR[dB]';
