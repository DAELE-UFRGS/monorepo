%% Questão 2
%Sabendo uma carga Q está distribuída uniformemente na superfície da esfera
%de raio a e que um carga -Q está  distribuída na casca condutora de raio b.
%Numericamente, determine o potencial eletrostático e a intensidade de
%campo elétrico entre os dois condutores. Determine, numericamente, a energia
%armazenada no campo eletrostático (integrando D.E/2).
%Considere a = 1 mm, b = 2 mm, Q = 1 pC e epr = 4.

%% Variáveis Dadas
clc
clear all
close all

e0=8.854*10^(-12); %permissividade do espaço livre (em F/m)

a = 1*10^(-3); %raio a
b = 2*10^(-3); %raio b
Q = 1*10^(-12); %carga uniforme
er=4; %permissividade relativa do meio

%% Variáveis Criadas
pSa = Q/(4*pi*a^2);  %desnsidade superficial de cargas em a
pSb = -Q/(4*pi*b^2); %desnsidade superficial de cargas em b

passo = a/5;
lim = 2*b;

%Espaço
x=[-lim:passo:lim]; %variação da coordenada x onde será calculado E
y=[-lim:passo:lim]; %variação da coordenada y onde será calculado E
z=[-lim:passo:lim]; %variação da coordenada z onde será calculado E

dphi = pi/10;    %rad %passo da variação da coordenada phi que indica a posição de um elmento de carga.
dr = a/5;        %idem para coordenada radial
dtheta = pi/10;  %rad % idem para coordenada theta

thetal = [dtheta/2:dtheta:pi-dtheta/2];   % variação da coordenada theta onde está a carga (já em radianos)
phil = [dphi/2:dphi:2*pi-dphi/2];         % variação da coordenada phi onde está a carga (já em radianos)

%Potencial
V(:,:,:) = zeros (length(x), length(y), length(z));

%Campo Elétrico
xn=(x(2:end-1)); % Variação da coordenada x onde será calculado E tirando as extremidades
yn=(y(2:end-1)); % Variação da coordenada y onde será calculado E tirando as extremidades
zn=(z(2:end-1)); % Variação da coordenada z onde será calculado E tirando as extremidades

E(1,:,:,:) = zeros (length(xn),length(yn),length(zn)); 
E(2,:,:,:) = zeros (length(xn),length(yn),length(zn));
E(3,:,:,:) = zeros (length(xn),length(yn),length(zn));

%% Calcula Potencial Esfera INTERNA
for i = 1:length(x)% varre a coordenada x onde v será calculado
    disp(i);
    for j = 1: length(y)  % varre a coordenada z onde V será calculado
        for k = 1:length(z) % varre a coordenada z onde V será calculado
            
            for n = 1:length(phil) % varre a coordenada  phil da carga
                for o = 1:length(thetal) %varre a coordenada  thetal da carga
                    
                    r = [x(i),y(j),z(k)]; %vetor posição apontando para onde estamos calculando V
                    [rl(1),rl(2),rl(3)] = sph2cart(phil(n), pi/2-thetal(o),a);% vetor posição apontando para um elemento de superficie dS.
                    
                    dSa = a^2*sin(thetal(o))*dphi*dtheta; %elemento de volume na posição rl, phil, thetal.
                    
                    if (sqrt((r-rl)*(r-rl)')>0.001*a) %remove os pontos muito próximos das cargas.
                        V(i,j,k) = V(i,j,k)  + (pSa*dSa/sqrt((r-rl)*(r-rl)'))';
                        
%                         if ((sqrt(x(i)^2+y(j)^2+z(k)^2)>=a) && (sqrt(x(i)^2+y(j)^2+z(k)^2)<=b))
%                             V(i,j,k)= V(i,j,k)/(4*pi*e0*er);                            
%                         else
%                             V(i,j,k)= V(i,j,k)/(4*pi*e0);
%                         end
                    
                    end
                    
                end
            end
        end
    end
end

%% Calcula Potencial CASCA
for i = 1:length(x)% varre a coordenada x onde v será calculado
    disp(i);
    for j = 1: length(y)  % varre a coordenada z onde V será calculado
        for k = 1:length(z) % varre a coordenada z onde V será calculado
            
            for n = 1:length(phil) % varre a coordenada  phil da carga
                for o = 1:length(thetal) %varre a coordenada  thetal da carga
                    
                    r = [x(i),y(j),z(k)]; %vetor posição apontando para onde estamos calculando V
                    [rll(1),rll(2),rll(3)] = sph2cart(phil(n), pi/2-thetal(o),b);
                    
                    dSb = b^2*sin(thetal(o))*dphi*dtheta;
                    
                    if (sqrt((r-rll)*(r-rll)')>0.001*b) %remove os pontos muito próximos das cargas.
                        V(i,j,k) = V(i,j,k)  + (pSb*dSb/(sqrt((r-rll)*(r-rll)')))';
                        
%                         if ((sqrt(x(i)^2+y(j)^2+z(k)^2)>=a) && (sqrt(x(i)^2+y(j)^2+z(k)^2)<=b))
%                             V(i,j,k)= V(i,j,k)/(4*pi*e0*er);
%                         else
%                             V(i,j,k)= V(i,j,k)/(4*pi*e0);
%                         end
                        
                    end
                    
                end
            end
        end
    end
end


V= V/(4*pi*e0*er);
%% Calcula E

for i = 2:length(x)-1% varre a coordenada x onde E será calculado
    disp(i);
    for j = 2 :length(y)-1
        for k = 2: length(z)-1  % varre a coordenada z onde E será calculado
            
            E(1,i-1,j-1,k-1) = -(V(i+1,j,k)-V(i-1,j,k))/2/passo; %Calcula a componente x do campo elétrico Ex como a -dV/dx, fazendo usando uma aproximação de diferença central;
            E(2,i-1,j-1,k-1) = -(V(i,j+1,k)-V(i,j-1,k))/2/passo; % Calcula Ey
            E(3,i-1,j-1,k-1) = -(V(i,j,k+1)-V(i,j,k-1))/2/passo; %calcula Ez
        end
    end
end


%% CALCULAR ENERGIA TOTAL ARMAZENADA A PARTIR DO CAMPO ELETRICO
We=0; %energia total armazenada

for i = 1:length(xn)% varre a coordenada x do E
    disp(i);
    for j = 1: length(yn)  % varre a coordenada y do E
        for k = 1:length(zn) % varre a coordenada z do E
            campoE = dot(E(:,i,j,k),E(:,i,j,k));
            We = We + ((campoE)*(passo^3));
        end
    end
end

We = 0.5*We*e0*er;

%% Plot
midz = int64(length(zn)/2);
[X,Y] = meshgrid(xn,yn);
figure
quiver(X,Y,squeeze(E(1,:,:,midz))' , squeeze(E(2,:,:,midz))')  %faz o gráfico vetorial de E
xlabel('eixo y (m)')
ylabel('eixo x (m)')
hold

[X,Y] = meshgrid(x,y);
figure
contour(X,Y,squeeze(V(:,:,midz)),50)
colorbar
xlabel('eixo x (m)')
ylabel('eixo y (m)')
hold

disp(We);       %Resp: 8.8808e-07