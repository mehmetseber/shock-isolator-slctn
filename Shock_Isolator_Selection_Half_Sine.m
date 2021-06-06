%% SHOCK ISOLATOR SELECTION TOOL for HALF SINE SHOCK PULSE METHOD

% by Mehmet Seber
% github.com/mehmetseber
% linkedin.com/in/mehmetseber/

% This tool uses shock characteristics for Half Sine Shock Pulses defined
% in USA Department of Defense Test Method Standard (MIL-STD-810G), Test
% Method #516 to come up with preliminary "static deflection" and
% "stiffness" values for shock isolators to use in processes of possible
% shock isolator choice.

% Metric system is used while developing this tool and required unit type
% for inputs.

% Required inputs:
% - Number of isolators used (Isolator locations are assumed to be
% symmetric)
% - Total Mass of the System
% - Fragility of the Critical Equipment
 
% Referred Inputs:
% - Shock Pulse Magnitude (MIL-STD-810G)
% - Shock Pulse Duration (MIL-STD-810G)
% - Ground Acceleration

clc;
clear;

%% Required Inputs
% num_iso = 0;
% mass = 0;
% fragility = 0;

%% Referred Inputs
spm = 40;                                       % g
spd = 11;                                       % ms
g = 9.81;                                       % m/s^2

%% Input Read
prompt = 'What is the total number of isolators in the system?' ;
num_iso = input(prompt);

prompt = 'What is the total mass of the system in kilograms?' ;
mass = input(prompt);

prompt = 'What is the fragility value of the equipment in g?' ;
fragility = input(prompt);

%% Outputs
delta_v = (2.*g^2*spm.*spd.*0.001)./pi;         % m/s^2
output_g = fragility;                           % g
f_nat = (1.56.*output_g.*g)./delta_v;           % Hz
stiffness = (f_nat^2.*4.*pi^2.*mass)./1000;     % N/mm
def_static = (mass.*g./num_iso)./stiffness;     % mm
def_dynamic = (delta_v.*1000)./(2.*pi.*f_nat);  % mm
min_thickness = def_dynamic./1.5;               % mm
min_shearstatic = mass.*g./num_iso;             % N/mount

%% Results
disp ('Choose an isolator that can support:');
fprintf (' a minimum shear static load of <strong>%.3f N/mount</strong>', min_shearstatic);
fprintf ('\n with <strong>%.3f N/mm</strong> maximum stiffness', stiffness);
fprintf ('\n and <strong>%.3f mm</strong> maximum deflection', def_static);