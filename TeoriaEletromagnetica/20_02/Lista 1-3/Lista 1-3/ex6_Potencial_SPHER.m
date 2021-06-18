%% Questão 6
% Uma densidade superficial de carga, ?s, está distribuída em uma casca 
% esférica de raio b, centrada na origem e imersa no espaço livre. Calcule, 
% numericamente, a energia armazenada na esfera por meio da consideração da 
% densidade de carga e do potencial. Calcule também a energia armazenada no 
% campo elétrico e mostre que esses dois resultados são idênticos. Avalie 
% sua resposta considerando 

%% Variáveis
clc
clear all
close all

e0=8.854*10^-12; %permissividade do espaço livre (em F/m)

raio = 5.1; %raio
ps = 10*10^-6; %densidade superficial de carga (em C/m^3)

lim = 4*raio;

dp = raio/15;
dphi = pi/15; %rad %passo da variação da coordenada phi que indica a posição de um elmento de carga.
dtheta = pi/15; %rad % idem para coordenada theta

p = [0:dp:lim];
phi = [dphi/2:dphi:2*pi-dphi/2]; % variação da coordenada theta onde está a carga (já em radianos)
theta = [dtheta/2:dtheta:pi-dtheta/2];  % variação da coordenada phi onde está a carga (já em radianos)

phil = [dphi/2:dphi:2*pi-dphi/2]; % variação da coordenada theta onde está a carga (já em radianos)
thetal = [dtheta/2:dtheta:pi-dtheta/2];  % variação da coordenada phi onde está a carga (já em radianos)

V(:,:,:) = zeros (length(p), length(phi), length(theta));

midp = int64(length(p)/2);

We=0;

%% Desenvolvimento

for i = 1:length(p)% varre a coordenada x onde v será calculado
    disp(i);
    for j = 1: length(phi)  % varre a coordenada z onde V será calculado
        for k = 1:length(theta) % varre a coordenada z onde V será calculado
            
            for n=1:length(phil) % varre a coordenada  phil da carga
                for o=1:length(thetal) %varre a coordenada  thetal da carga

                    r = [p(i),phi(j),theta(k)]; %vetor posição apontando para onde estamos calculando V
                    rl =[raio,phil(n),thetal(o)];% vetor posição apontando para um elemento de superficie dS.

                    dS = (raio^2)*sin(thetal(o))*dphi*dtheta; %elemento de volume na posição rl, phil, thetal.

                    if (sqrt((r-rl)*(r-rl)')>0.05) %remove os pontos muito próximos das cargas.
                        V(i,j,k) = V(i,j,k)  + (ps*dS/sqrt(((r-rl)*(r-rl)')*(sin(theta(k))*sin(thetal(o))*cos(phi(j)-phil(n)))+(cos(theta(k))*cos(thetal(o))) ))';
                    end

                end
            end
                
        end
    end
end
V= V/(4*pi*e0);

for j = 1: length(phil)  % varre a coordenada phi
    for k = 1:length(thetal) % varre a coordenada theta

        dS = (raio^2)*sin(thetal(k))*dphi*dtheta;
        We = We + V(midp,j,k)*dS;    

    end
end
We = 0.5*We*ps;

disp(We);
disp(imag(We));       %A resposta correta é: 9413,49 J.     %Resp: 9.4545e+03