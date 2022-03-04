set(0,'DefaultFigureWindowStyle','docked')
close all; clear all;


%% Constant and parameters
R1 = 1;
R2 = 2;
R3 = 10;
R4 = 0.1;
Ro = 1000;
C1 = 0.25;
L1 = 0.2;
alpha = 100;
Vin = linspace(-10,10,20);

N = 5;      % number of node


global G B C;

%% Define matrices
G = zeros(N,N); 
C = zeros(N,N); 
B = zeros(N,1); 


%% Stamping - Component list
Vsource(1,0,Vin(1))
Resistor(1,2,R1)
Capacitor(1,2,C1)
Resistor(2,0,R2)
Inductor(2,3,L1)
Resistor(3,0,R3)
VCVSource(4,0,3,0,alpha/R3);
Resistor(4,5,R4)
Resistor(5,0,Ro)


%% DC sweep case
for n = 1:20
    B(6) = Vin(n);  % adding new column in B matrix to accommodate Vin
    V = G\B;
    Vout(n) = V(N);     % output voltage at node N
    V3(n) = V(3);       % output voltage at node 3
end

subplot(2,2,1)
plot(Vin,Vout)
hold on
plot(Vin,V3)
xlabel('Vin (V)')
ylabel('Vout (V)')
legend('Vout','V3');


%% AC sweep case 
B(6) = 10;   % Vin = 10
w = linspace(0,100,100);

for n = 1:100
    V = (G + i*w(n)*C)\B;
    Vout(n) = V(N);
end

gain = 20 * log(abs(Vout/B(6)));

subplot(2,2,2)
plot(w,abs(Vout))
hold on
plot(w,gain)
xlabel('w')
ylabel('|Vout (V)|')
legend('|Vout|','gain (dB)')


w = pi;
stdev = 0.05;

for n = 1:100
    C_pertubation = stdev * randn + C1;
    
    % only adding pertubation at row/column 1 & 2 because everywhere
    % else is C = 0 
    C(1,1) = C1 + C_pertubation;
    C(1,2) = C1 + C_pertubation;
    C(2,1) = - (C1 + C_pertubation);
    C(2,2) = - (C1 + C_pertubation);
    pertubation(n) = C_pertubation;
    
    V = (G + i*w*C)\B;
    Vout(n) = V(N);
    
end

gain = abs(Vout/B(6));

subplot(2,2,3)
histogram(pertubation)
xlabel('C')
ylabel('Number')

subplot(2,2,4)
histogram(gain)
xlabel('Gain')
ylabel('Number')




