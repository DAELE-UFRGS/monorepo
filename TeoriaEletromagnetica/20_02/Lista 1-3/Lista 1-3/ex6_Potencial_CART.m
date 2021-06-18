%% Questão 6
% Uma densidade superficial de carga, ?s, está distribuída em uma casca esférica de raio b, 
% centrada na origem e imersa no espaço livre. Calcule, numericamente, a energia armazenada 
% na esfera por meio da consideração da densidade de carga e do potencial. Calcule também a 
% energia armazenada no campo elétrico e mostre que esses dois resultados são idênticos. 
% Avalie sua resposta considerando  ?s = 10,0 ?C/m² e b = 5,1 m. 

%% Variáveis Dadas
clc
clear all
close all

e0=8.854*10^(-12); %permissividade do espaço livre (em F/m)

b = 5.1; %raio a
ps = 10*10^-6; 

%% Variáveis Criadas

passo = b/5;
lim = 2*b;

%Espaço
x=[-lim:passo:lim]; %variação da coordenada x onde será calculado E
y=[-lim:passo:lim]; %variação da coordenada y onde será calculado E
z=[-lim:passo:lim]; %variação da coordenada z onde será calculado E

dphi = pi/10;    %rad %passo da variação da coordenada phi que indica a posição de um elmento de carga.
dr = b/10;        %idem para coordenada radial
dtheta = pi/10;  %rad % idem para coordenada theta

thetal = [dtheta/2:dtheta:pi-dtheta/2];   % variação da coordenada theta onde está a carga (já em radianos)
phil = [dphi/2:dphi:2*pi-dphi/2];         % variação da coordenada phi onde está a carga (já em radianos)

%Potencial
V(:,:,:) = zeros (length(x), length(y), length(z));

%% Calcula Potencial Esfera INTERNA
for i = 1:length(x)% varre a coordenada x onde v será calculado
    disp(i);
    for j = 1: length(y)  % varre a coordenada z onde V será calculado
        for k = 1:length(z) % varre a coordenada z onde V será calculado
            
                for n = 1:length(phil) % varre a coordenada  phil da carga
                    for o = 1:length(thetal) %varre a coordenada  thetal da carga
                        
                        r = [x(i),y(j),z(k)]; %vetor posição apontando para onde estamos calculando V
                        [rl(1),rl(2),rl(3)] = sph2cart(phil(n), pi/2-thetal(o),b);% vetor posição apontando para um elemento de superficie dS.
                        
                        dV = b^2*sin(thetal(o))*dphi*dtheta; %elemento de volume na posição rl, phil, thetal.
                        
                        if (sqrt((r-rl)*(r-rl)')>0.001*b) %remove os pontos muito próximos das cargas.
                            V(i,j,k) = V(i,j,k)  + (ps*dV/sqrt((r-rl)*(r-rl)'))';
                            
                        end
                        
                    end
                end
        end
    end
end

V= V/(4*pi*e0);

%% CALCULAR ENERGIA TOTAL ARMAZENADA A PARTIR DO CAMPO ELETRICO
We=0; %energia total armazenada

for i = 1:length(x)% varre a coordenada x do E
    disp(i);
    for j = 1: length(y)  % varre a coordenada y do E
        for k = 1:length(z) % varre a coordenada z do E
            if((sqrt(x(i)^2+y(j)^2+z(k)^2)<b)) %raio phi e theta
                We = We + (ps*V(i,j,k)*passo^3);
            else
                We = We + 0;
            end
        end
    end
end

We = We/2;

%% Plot
midz = int64(length(z)/2);
[X,Y] = meshgrid(x,y);
figure
contour(X,Y,squeeze(V(:,:,midz)),50)
colorbar
xlabel('eixo x (m)')
ylabel('eixo y (m)')
hold

disp(We);       %Resp: 9413,49 J.