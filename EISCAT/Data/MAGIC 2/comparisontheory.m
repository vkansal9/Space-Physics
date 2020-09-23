load('06774420.mat');
load('iri2.txt');
close all;
figure;
plot(r_param(:,1),r_h);
hold on;
plot(ne,h);
ylabel('Altitude (in km)')
xlabel('Electron Density/m^{3}')
hold on;
legend('Experimental data','IRI') 
