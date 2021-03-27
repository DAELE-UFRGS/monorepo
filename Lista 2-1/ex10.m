%% Questão 10                           Arthur A S Araújo
% Uma lâmina de corrente K flui na região  -a < y < a no plano z =0.
% A partir da densidade de corrente K, calcule numericamente a intensidade
% de campo magnético gerado por essa lâmina em qualquer posição do espaço.
% Afim de avaliar sua resposta calcule a componente y da intensidade de 
% campo magnético na posição (x = 0, y = 0, z = 2,6 m), 
% considere K = 2,3 ax A/m e a = 5,6 m.

%% Variáveis Dadas
clc
clear all
close all

a = 5.6;        % limite da lâmina
kx = 2.3;       %na direção ax
z1 = 2.6;

%% Variáveis Criadas
lim = 2*a; % limite para as coordenadas x, y e z
passo = a/6; % passo

dx=passo;
dy=passo;
dz=passo;

x=[-a/2:dx:a/2];            %variaÃ§Ã£o da coordenada x onde serÃ¡ calculado H
y=[-lim:dy:lim];            %variaÃ§Ã£o da coordenada y onde serÃ¡ calculado H
z=[-2*z1:dz:2*z1];        %variaÃ§Ã£o da coordenada z onde serÃ¡ calculado H

xl=[-lim+dx:dx:lim];           %variaÃ§Ã£o da coordenada x onde está a carga
yl=[-a+dy:dy:a];               %variaÃ§Ã£o da coordenada y onde está a carga

H(1,:,:,:) = zeros(length(x),length(y),length(z)); 
H(2,:,:,:) = zeros(length(x),length(y),length(z));
H(3,:,:,:) = zeros(length(x),length(y),length(z));

%% Desenvolvimento
for i = 1:length(x)% varre a coordenada x onde H será¡ calculado
    disp(i)
    for j = 1: length(y)  % varre a coordenada y onde H será calculado
        for k = 1:length(z) % varre a coordenada z onde H será calculado
            
            for m = 1:length(xl)  % varre a coordenada xl, onde existe a corrente
                for n = 1:length(yl)
                    
                    r = [x(i),y(j),z(k)];  %vetor posição do ponto de campo (onde calculamos H)
                    rl = [xl(m), yl(n), 0];
                    
                    K = [kx, 0, 0];
                    
                    % Agora calculamos o produto vetorial K x (r-rl)
                    K_x_rrl = cross(K, r-rl);              
                    
                    % Utilizamos a condição abaixo para evitar a divisão por zero, no caso em que r e rl são iguais.
                    %if (yl(n)>=-a && yl(n)<=a)
                        if  ((r-rl)*(r-rl)' > dz/2)
                            
                            dH = K_x_rrl'/(sqrt((r-rl)*(r-rl)')^3); 
                            
                            H(1,i,j,k) = H(1,i,j,k) + dH(1)*dx*dy;
                            H(2,i,j,k) = H(2,i,j,k) + dH(2)*dx*dy;
                            H(3,i,j,k) = H(3,i,j,k) + dH(3)*dx*dy;
                        end
                    %end
                end
            end
        end
    end
end

H = H/(4*pi);

midx=ceil(length(x)/2);
midy=ceil(length(y)/2);
midz=ceil(length(z)/2);

%% Resposta
disp('A componente y do campo magnético em x=0, y=0 e z=z_desejado vale:');
z_desejado = midz * 1.5;
disp(H(2,midx,midy,z_desejado));    %resp:   -0.8333

%% Plot
figure(1);
[Y,Z] = meshgrid(y,z);
quiver(Y, Z, squeeze(H(2,midx,:,:))', squeeze(H(3,midx,:,:))');

xlabel('eixo y (m)')
ylabel('eixo z (m)')
title('H, plano YZ (x=0)');
