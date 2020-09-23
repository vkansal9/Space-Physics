load('06778620.mat');
load('iri.txt');
close all;
figure;
plot(r_param(:,1),r_h);
hold on;
plot(ne,h);
ylabel('Altitude (in km)')
xlabel('Electron Density/m^{3}')
hold on;
legend('Experimental data','IRI') 
load('2015-03-20_ipy@42m.eps')