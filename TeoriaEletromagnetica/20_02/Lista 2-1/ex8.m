%% Questão 8                           Arthur A S Araújo
% Um disco de raio a pertence ao plano xy, com o eixo z passando pelo seu centro.
% Uma carga superficial de densidade uniforme ?s está presente no disco, que gira
% em volta do eixo z em uma velocidade angular de ? rad/s. A partir da Lei de
% Biot-Savart e da densidade superficial de cargas, determine numericamente a
% intensidade de campo magnético em todo o espaço. Para fins de conferência,
% avalie sua resposta considerando a = 9,9 m, ?s = 3,9 C/m2, z = 6,4 m e ? = 2,7 rad/s

%% Variáveis Dadas
clc
clear all
close all

a = 9.9;            % raio do anel
w = 2.7;            %velocidade angular [rad/s]
ps = 3.9;           %densidade superficial [C/m^2]
z1 = 6.4;

%% Variáveis Criadas
lim = 2*a;          % limite para as coordenadas x, y e z
passo = a/8;        % passo

dx=passo;
dy=passo;
dz=passo;

x=[-lim:dx:lim];            %variaÃ§Ã£o da coordenada x onde serÃ¡ calculado H
y=[-lim:dy:lim];            %variaÃ§Ã£o da coordenada y onde serÃ¡ calculado H
z=[-2*z1:dz:2*z1];          %variaÃ§Ã£o da coordenada z onde serÃ¡ calculado H

dphi = 2*pi/14;
drho = a/10;

phil = [0:dphi:2*pi-dphi/2]; % notar que excluímos 2*pi, pois já¡ temos 0.
rhol = [0:drho:a];

% Inicializa a densidade de campo magnÃ©tico
H(1,:,:,:) = zeros(length(x),length(y),length(z));
H(2,:,:,:) = zeros(length(x),length(y),length(z));
H(3,:,:,:) = zeros(length(x),length(y),length(z));

%% Desenvolvimento
for i = 1:length(x)% varre a coordenada x onde H será¡ calculado
    disp(i)
    for j = 1: length(y)  % varre a coordenada y onde H será¡ calculado
        for k = 1:length(z) % varre a coordenada z onde H será¡ calculado
            
            for m = 1:length(phil)  % varre a coordenada phil, onde existe a corrente
                for n =1:length(rhol)
                    
                    r = [x(i),y(j),z(k)];  %vetor posição do ponto de campo (onde calculamos H)
                    [rl(1), rl(2), rl(3)] = pol2cart(phil(m), rhol(n), 0); % convertemos rl para coord retangulares
                    
                    [K(1), K(2), K(3)] = pol2cart(pi/2+phil(m), (rhol(n)*w)*ps, 0);%K=[sqrt(x(i)^2+y(j)^2), 0, 0]
                    
                    % Agora calculamos o produto vetorial K x (r-rl)                   
                    K_x_rrl = cross(K, r-rl);
                    
                    % Utilizamos a condição abaixo para evitar a divisão por zero, no caso em que r e rl são iguais.
                    if  ((r-rl)*(r-rl)' > dz/2)
                        dH = K_x_rrl'/(sqrt((r-rl)*(r-rl)')^3); % essa Ã© a contribuição dB devida a esse dL
                        dS = rhol(n)*drho*dphi;
                        
                        H(1,i,j,k) = H(1,i,j,k) + dH(1)*dS;
                        H(2,i,j,k) = H(2,i,j,k) + dH(2)*dS;
                        H(3,i,j,k) = H(3,i,j,k) + dH(3)*dS;
                        
                    end
                end
            end
        end
    end
end

H = H/(4*pi);

midx=ceil(length(x)/2);
midy=ceil(length(y)/2);
midz=ceil(length(z)/2);

%% Plot
figure(1);
[X,Z] = meshgrid(x,z);
quiver(X, Z, squeeze(H(1,:,midy,:))', squeeze(H(3,:,midy,:))');
xlabel('eixo x (m)')
ylabel('eixo z (m)')
title('B, plano XZ (y=0)');

figure(2);
[Y,Z] = meshgrid(y,z);
quiver(Y, Z, squeeze(H(2,midx,:,:))', squeeze(H(3,midx,:,:))');
xlabel('eixo y (m)')
ylabel('eixo z (m)')
title('B, plano YZ (x=0)');

%% Resp
disp(H(3,midx,midy,ceil(midz*1.5)));    %Resp:    12.8469
