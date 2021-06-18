%% Questão 10                   Arthur A S Araújo
% Uma lâmina de corrente K flui na região  -a < y < a no plano z =0. 
% Calcule numericamente o potencial vetorial magnético A e a partir 
% desse a densidade de fluxo magnético B, em qualquer posição do espaço. 
% Fação uma representação gráfica de A e de B no plano xz
% Afim de avaliar sua resposta calcule a componente y da intensidade de 
% campo magnético na posição (x = 0, y = 0, z = 8,8 m), 
% considere K = 9,5 ax A/m e a = 2,9 m.

%% Variáveis Dadas
clc
clear all
close all

u0 = 4*pi*10^-7; % permeablidade do espaço livre (em H/m)

a = 8.9; % limite da lâmina
k1 = 3.1; %na direção ax
lim_z = 8.2;

%% Variáveis Criadas
lim = 3*a; % limite para as coordenadas x, y e z
passo = a/4; % passo

dx=passo;
dy=passo;
dz=passo;

x=[-lim:dx:lim]; %variaÃ§Ã£o da coordenada x onde serÃ¡ calculado H
y=[-lim:dy:lim]; %variaÃ§Ã£o da coordenada y onde serÃ¡ calculado H
z=[-2*lim_z:dz:2*lim_z]; %variaÃ§Ã£o da coordenada z onde serÃ¡ calculado H

xl=[-2*lim:dx:2*lim]; %variaÃ§Ã£o da coordenada x onde está a carga
yl=[-a:dy:a]; %variaÃ§Ã£o da coordenada y onde está a carga

%incializa o potencial vetorial magnético
A(1,:,:,:) = zeros(length(x),length(y),length(z));      %Componente x do potencial vetorial magnético
A(2,:,:,:) = zeros(length(x),length(y),length(z));      %Componente y do potencial vetorial magnético
A(3,:,:,:) = zeros(length(x),length(y),length(z));      %Componente z do potencial vetorial magnético

%% Desenvolvimento: Calcula Potencial A
for i = 1:length(x)% varre a coordenada x onde H será¡ calculado
    disp(i)
    for j = 1: length(y)  % varre a coordenada y onde H será calculado
        for k = 1:length(z) % varre a coordenada z onde H será calculado
            
            for m = 1:length(xl)  % varre a coordenada xl, onde existe a corrente
                for n = 1:length(yl)
                    
                    r = [x(i),y(j),z(k)];  %vetor posição do ponto de campo (onde calculamos H)
                    rl = [xl(m), yl(n), 0];
                    
                    dS = dx*dy;
                    K_dS = k1*dS*[1,0,0];
                    
                    dA = K_dS/sqrt((r-rl)*(r-rl)'); % contribuição para o potencial A devido a a corrente I no segmento dzl
                    
                    A(1,i,j,k)=A(1,i,j,k)+dA(1); %soma em Ax a componente x da contribuição em dA
                    A(2,i,j,k)=A(2,i,j,k)+dA(2);%soma em Ay a componente y da contribuição em dA
                    A(3,i,j,k)=A(3,i,j,k)+dA(3);%soma em Az a componente z da contribuição em dA
                    
                end
            end
        end
    end
end

A=(u0/(4*pi))*A;

%% Calcula B
xn = (x(2:end-1));
yn = (y(2:end-1));
zn = (z(2:end-1));

B(1,:,:,:) = zeros (length(xn),length(yn),length(zn)); %inicializa a densidade de fluxo magnético B, componente x
B(2,:,:,:) = zeros (length(xn),length(yn),length(zn)); %componente y
B(3,:,:,:) = zeros (length(xn),length(yn),length(zn)); %componente z

%vamos calcular o B a partir do rotacional de A (rot A = (dAz/dy-dAy/dz) ax
%(dAx/dz-dAz/dx) ay + (dAy/dx-dAx/dy) az
for i = 2:length(x)-1% varre a coordenada x onde B será calculado
    disp(i)
    for j = 2 :length(y)-1 % varre a coordenada y onde B será calculado
        for k = 2: length(z)-1  % varre a coordenada z onde E será calculado
            
            dAz_dy = (A(3,i,j+1,k)-A(3,i,j-1,k))/2/dy; %derivada de Az em relação a y
            dAy_dz = (A(2,i,j,k+1)-A(2,i,j,k-1))/2/dz; %derivada de Ay em relação a z
            
            dAx_dz = (A(1,i,j,k+1)-A(1,i,j,k-1))/2/dz; %derivada de Ax em relação a z
            dAz_dx = (A(3,i+1,j,k)-A(3,i-1,j,k))/2/dx;%derivada de Az em relação a x
            
            dAy_dx = (A(2,i+1,j,k)-A(2,i-1,j,k))/2/dx; %derivada de Ay em relação a x
            dAx_dy = (A(1,i,j+1,k)-A(1,i,j-1,k))/2/dy;%derivada de Ax em relação a y
            
            B(1,i-1,j-1,k-1) = dAz_dy-dAy_dz; %a componente x de B é dAz/dy-dAy/dz
            B(2,i-1,j-1,k-1) = dAx_dz-dAz_dx;%a componente y de B é dAx/dz-dAz/dx
            B(3,i-1,j-1,k-1) = dAy_dx-dAx_dy;%a componente z de B é dAy/dx-dAx/dy
        end
    end
end

%% Plot A
midx=ceil(length(x)/2);
midy=ceil(length(y)/2);
midz=ceil(length(z)/2);

figure(1);
[X,Z] = meshgrid(x,z);
quiver(X, Z, squeeze(A(1,:,midy,:))', squeeze(A(3,:,midy,:))');  %faz o gráfico de A no plano y = 0
xlabel('eixo x (m)')
ylabel('eixo z (m)')
title('A, plano XZ (y=0)');

figure(2);
[X,Y] = meshgrid(x,y);
quiver(X, Y, squeeze(A(1,:,:,midz))', squeeze(A(2,:,:,midz))');  %faz o gráfico de A no plano y = 0
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('A, plano XY (z=0)');

%% Plot B
midxn=ceil(length(xn)/2);
midyn=ceil(length(yn)/2);
midzn=ceil(length(zn)/2);

figure(3)
[X,Z] = meshgrid(xn,zn);
quiver(X,Z,squeeze(B(1,:,midyn,:))' , squeeze(B(3,:,midyn,:))')
hold on
contour(X, Z, squeeze(B(2,:,midyn,:))',40)
xlabel('eixo x (m)')
ylabel('eixo z (m)')
title('B, plano XZ (y=0)');

figure(4)
[X,Y] = meshgrid(xn,yn);
surf(X,Y,squeeze((B(3,:,:,midzn)))')
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('B, plano XY (z=0)');

%% Disp
H= B/u0;
pontoz = ceil(0.75*length(zn));
disp(H(2,midxn,midyn,pontoz));