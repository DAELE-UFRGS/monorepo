%% Questão 4
% Uma esfera de raio a contém uma densidade volumétrica de carga uniforme ?0.
% Encontre, numericamente, a energia total armazenada de duas formas (usando
% a densidade de carga e o potencial e usando o campo elétrico devido a
% distribuição de carga). Avalie sua resposta considerando  ?0 = 2,7 ?C/m³
% e a = 5,7 m.

%% Variáveis Dadas
clc
clear all
close all

e0=8.854*10^(-12); %permissividade do espaço livre (em F/m)

a = 5.7; %raio a
pv = 2.7*10^-6; 

%% Variáveis Criadas

passo = a/5;
lim = 2*a;

%Espaço
x=[-lim:passo:lim]; %variação da coordenada x onde será calculado E
y=[-lim:passo:lim]; %variação da coordenada y onde será calculado E
z=[-lim:passo:lim]; %variação da coordenada z onde será calculado E

dphi = pi/10;    %rad %passo da variação da coordenada phi que indica a posição de um elmento de carga.
dr = a/10;        %idem para coordenada radial
dtheta = pi/10;  %rad % idem para coordenada theta

pl = [0:dr:a];
thetal = [dtheta/2:dtheta:pi-dtheta/2];   % variação da coordenada theta onde está a carga (já em radianos)
phil = [dphi/2:dphi:2*pi-dphi/2];         % variação da coordenada phi onde está a carga (já em radianos)

%Potencial
V(:,:,:) = zeros (length(x), length(y), length(z));

%% Calcula Potencial Esfera INTERNA
for i = 1:length(x)% varre a coordenada x onde v será calculado
    disp(i);
    for j = 1: length(y)  % varre a coordenada z onde V será calculado
        for k = 1:length(z) % varre a coordenada z onde V será calculado
            
            for m = 1:length(pl)
                for n = 1:length(phil) % varre a coordenada  phil da carga
                    for o = 1:length(thetal) %varre a coordenada  thetal da carga
                        
                        r = [x(i),y(j),z(k)]; %vetor posição apontando para onde estamos calculando V
                        [rl(1),rl(2),rl(3)] = sph2cart(phil(n), pi/2-thetal(o),pl(m));% vetor posição apontando para um elemento de superficie dS.
                        
                        dV = pl(m)^2*sin(thetal(o))*dr*dphi*dtheta; %elemento de volume na posição rl, phil, thetal.
                        
                        if (sqrt((r-rl)*(r-rl)')>0.001*a) %remove os pontos muito próximos das cargas.
                            V(i,j,k) = V(i,j,k)  + (pv*dV/sqrt((r-rl)*(r-rl)'))';
                            
                        end
                        
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
            if((sqrt(x(i)^2+y(j)^2+z(k)^2)<a)) %raio phi e theta
                We = We + (pv*V(i,j,k)*passo^3);
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

disp(We);       %Resp: 4150,31 J.