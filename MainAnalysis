clc
%the values already declared in the code is calculated from Standard Atmosphere Data Table(ISA)
%I-Cycle analysis :
T4 = input('maximum temp. (K)=  ');
rp = input('pressure ratio= ');
To = 288;    %kelvin
Po = 101300; %pascal
ao = 295.61; %m/sec
rho = 0.3682; %kg/m^3
gamma = 1.4; %For Isentropic Conditions 
cp = 1003.5; %j/kg.k
mdot = 25;   %kg/s
Mo = (0.1:0.02:0.9);
Cd_Nacelle = (0.01:0.005:0.1);
[CD, MO] = meshgrid(Cd_Nacelle, Mo);
%%1-Diffuser
Tt2 = To.*(1+((gamma-1)/2).*MO.^2);
Pt2 = Po.*(1+((gamma-1)/2).*MO.^2).^(gamma/(gamma-1));
%%2-compressor(2-->3)
Pt3 = rp.*Pt2; 
Tt3 = Tt2.*(Pt3./Pt2).^((gamma-1)/gamma);
%%3-combustion chamber(3-->4)
Pt4 = Pt3.*(T4./Tt3).^(gamma/(gamma-1));
Qin = mdot.*cp.*(T4-Tt3);
%%4-Turbine(4-->5)
Tt9= T4 + Tt2 - Tt3;
Pt9 = Pt4.*(Tt9./T4).^(gamma/(gamma-1));
Wout = mdot.*cp.*(T4-Tt9);
%%5-Heat Exchanger(9-->2)
Te = Tt9.*(Po./Pt9).^((gamma-1)/gamma); %exit temp. 
Qrej = Qin - Wout;
%II-Thrust Calculations :
Ve = sqrt(2.*cp.*(Tt9-Te));             %exit velocity    
Vo = MO.*ao ;                           %Inlet velocity
F = mdot.*(Ve-Vo);                      %Uninstalled Thrust
T = F - 0.5.*rho.*((Vo).^2).*CD.*2;
mid = round(length(Mo)/2);
fprintf('\n--- Results (at Mo=%.2f) ---\n', Mo(mid));
fprintf('Added Heat Value (Qin): %.3f MW\n', Qin(mid, 1)/1e6);
fprintf('Rejected Heat Value (Qrej): %.3f MW\n', Qrej(mid, 1)/1e6);
fprintf('Output turbine work (Wout): %.3f MW\n', Wout(mid, 1)/1e6);
%TSFC data
Qf = 43e6;                              %Heating value of fuel (J/kg)
f = (cp .* (T4 - Tt3)) ./ Qf;           %Fuel-to-air ratio
mdot_f = f .* mdot;                     %Fuel mass flow rate (kg/s)
TSFC = (mdot_f ./ T) .* 3600;           %thrus specific fuel consumption
%III-Plotting:
figure('Name', 'TSFC Analysis', 'Color', [0.15 0.15 0.15]);
s2 = surfc(CD, MO, TSFC);
shading interp;
s2(1).EdgeColor = 'none';
colormap(hot); 
h2 = colorbar;
h2.Color = 'w';
h2.Label.String = 'TSFC (kg/N.hr)';


set(gca, 'Color', [0.15 0.15 0.15], 'XColor', 'w', 'YColor', 'w', 'ZColor', 'w', 'GridColor', [0.5 0.5 0.5]);
xlabel('Drag Coefficient (Cd)');
ylabel('Mach Number (Mo)');
zlabel('TSFC (kg/N.hr)');
title('Thrust Specific Fuel Consumption', 'Color', 'w');
view(135, 35); 

figure('Name', 'Turbojet Map', 'Color', [0.15 0.15 0.15]); 
s = surfc(CD, MO, T);


s(1).EdgeColor = 'none'; 
shading interp; 
colormap jet; 
h = colorbar;
h.Color = 'w'; 
ylabel(h, 'Installed Thrust (T) [N]', 'Color', 'w');

camlight left; 
lighting phong; 
material shiny;
view(-35, 35); 


ax = gca;
ax.Color = [0.2 0.2 0.2];     
ax.XColor = 'w';              
ax.YColor = 'w';             
ax.ZColor = 'w';              
ax.GridColor = [0.5 0.5 0.5]; 
title('Installed Thrust Performance Map', 'Color', 'w');
xlabel('Drag Coefficient (Cd)', 'Color', 'w');
ylabel('Mach Number (Mo)', 'Color', 'w');
zlabel('Installed Thrust (T) [N]', 'Color', 'w');
grid on;

DrawEngine(To, Tt2(2), Tt3(1), T4(1), Tt9(1))
