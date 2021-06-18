%% Questão 2                Arthur A. S. Araújo
% Duas fitas condutoras, de comprimentos infinitos na direção z,
% estão situadas no plano xz, Uma ocupa a região d/2 < x < b + d/2
% e conduz uma densidade de corrente superficial K = K0az, enquanto
% a outra está situada em -(b + d/2) < x < -d/2 e conduz uma densidade
% de corrente superficial igual -K0az.
% Determine numericamente a densidade de fluxo magnético em todo o espaço.
% Trace o gráfico da densidade de fluxo como vista de um plano ortogonal
% às duas fitas. Em seguida, determine a força diferencial por unidade de
% comprimento na região das fitas. Trace um gráfico dessas forças.
% Integre numericamente essas forças diferenciais para determinar a magnitude
% da força por unidade de comprimento sentida por cada uma das fitas.

%% Variáveis Dadas
clc
clear all
close all

d = 0.5;
b = 0.5;
k0 = 1.8;
u0 = 4*pi*10^-7; % permeablidade do espaço livre (em H/m)

%% Variáveis Criadas
passo = d/8; % passo

dx=passo;
dy=passo;
dz=passo;

x= [-2*d:dx:2*d]; %variacao da coordenada x
y= [-d/2:dy:d/2]; %variacao da coordenada y
z= [-d/2:dz:d/2]; %variacao da coordenada z

xl1= [-(d/2+b+dx/2):dx:-(d/2+dx/2)]; 
zl1= [-(2*d+dz/2):dz:(2*d+dz/2)]; 

xl2= [(d/2+dx/2):dz:(d/2+b+dx/2)]; 
zl2= [-(2*d+dz/2):dz:(2*d+dz/2)]; 

K1 = [0,0,-k0];
K2 = [0,0,k0];

%Campo Mag
B(1,:,:,:) = zeros(length(x),length(y),length(z));
B(2,:,:,:) = zeros(length(x),length(y),length(z));
B(3,:,:,:) = zeros(length(x),length(y),length(z));

B1(1,:,:,:) = zeros(length(x),length(y),length(z));
B1(2,:,:,:) = zeros(length(x),length(y),length(z));
B1(3,:,:,:) = zeros(length(x),length(y),length(z));

B2(1,:,:,:) = zeros(length(x),length(y),length(z));
B2(2,:,:,:) = zeros(length(x),length(y),length(z));
B2(3,:,:,:) = zeros(length(x),length(y),length(z));

%Forças
F (1,:,:,:) = zeros(length(x),length(y),length(z));
F (2,:,:,:) = zeros(length(x),length(y),length(z));
F (3,:,:,:) = zeros(length(x),length(y),length(z));

F1 (1,:,:,:) = zeros(length(x),length(y),length(z));
F1 (2,:,:,:) = zeros(length(x),length(y),length(z));
F1 (3,:,:,:) = zeros(length(x),length(y),length(z));

F2 (1,:,:,:) = zeros(length(x),length(y),length(z));
F2 (2,:,:,:) = zeros(length(x),length(y),length(z));
F2 (3,:,:,:) = zeros(length(x),length(y),length(z));

%% Desenvolvimento: Calcula B - Fita 1
for i = 1:length(x)% varre a coordenada x onde H será¡ calculado
    disp(i)
    for j = 1: length(y)  % varre a coordenada y onde H será calculado
        for k = 1:length(z) % varre a coordenada z onde H será calculado
            
            for m = 1:length(xl1)  % varre a coordenada xl, onde existe a corrente
                for n = 1:length(zl1)
                    
                    r = [x(i),y(j),z(k)];
                    rl = [xl1(m), 0, zl1(n)];
                    
                    dS = dx*dz;
                    
                    K1_x_rrl = cross(K1, r-rl);
                    %if  ((r1-rl1)*(r1-rl1)' > dz/2)
                    dB1 = K1_x_rrl'/(sqrt((r-rl)*(r-rl)')^3);
                    
                    B1(1,i,j,k) = B1(1,i,j,k) + dB1(1)*dS;
                    B1(2,i,j,k) = B1(2,i,j,k) + dB1(2)*dS;
                    B1(3,i,j,k) = B1(3,i,j,k) + dB1(3)*dS;
                    %end
                end
            end
        end
    end
end

%% Desenvolvimento: Calcula B - Fita 2
for i = 1:length(x)% varre a coordenada x onde H será¡ calculado
    disp(i)
    for j = 1: length(y)  % varre a coordenada y onde H será calculado
        for k = 1:length(z) % varre a coordenada z onde H será calculado
            
            for m = 1:length(xl2)  % varre a coordenada xl, onde existe a corrente
                for n = 1:length(zl2)
                    
                    r = [x(i),y(j),z(k)];
                    rl = [xl2(m), 0, zl2(n)];
                    
                    dS = dx*dz;
                    
                    K1_x_rrl = cross(K2, r-rl);
                    %                     if  ((r-rl)*(r-rl)' > dz/2)
                    dB2 = K1_x_rrl'/(sqrt((r-rl)*(r-rl)')^3);
                    
                    B2(1,i,j,k) = B2(1,i,j,k) + dB2(1)*dS;
                    B2(2,i,j,k) = B2(2,i,j,k) + dB2(2)*dS;
                    B2(3,i,j,k) = B2(3,i,j,k) + dB2(3)*dS;
                    %                     end
                end
            end
        end
    end
end

B1 = (u0/(4*pi))*B1;
B2 = (u0/(4*pi))*B2;
B = (B1+B2);
%% Descobrindo valor de Força diferencial por unidade de comprimento
for i = 1:length(x)% varre a coordenada x onde H será¡ calculado
    disp(i)
    for j = 1: length(y)
        for k = 1:length(z)
            
            if ((x(i) > -(d/2+b) && x(i) < -d/2) && (y(j)>-dy/2 && y(j)<dy/2))
                F1(:,i,j,k) = cross(K1,B2(:,i,j,k))'*dS;
            end
            if ((x(i) < (d/2+b) && x(i) > d/2) && (y(j)>-dy/2 && y(j)<dy/2))
                F2(:,i,j,k) = cross(K2,B1(:,i,j,k))'*dS;
            end
            
        end
    end
end
F = F1 + F2;

%% Plot B
xmedio = ceil(length(x)/2);
ymedio = ceil(length(y)/2);
zmedio = ceil(length(z)/2);

figure(1);
[X,Y] = meshgrid(x,y);
quiver(X, Y, squeeze(B(1,:,:,zmedio))', squeeze(B(2,:,:,zmedio))');
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('B, plano XY (z=0)');

%% Plot Força Diferencial
figure (2)
[X,Y] = meshgrid(x,y);
quiver(X, Y, squeeze(F(1,:,:,zmedio))', squeeze(F(2,:,:,zmedio))');
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('dF, plano XY (z=0)');

figure (3)
[X,Z] = meshgrid(x,z);
quiver(X, Z, squeeze(F(1,:,ymedio,:))', squeeze(F(3,:,ymedio,:))');
xlabel('eixo x (m)')
ylabel('eixo z (m)')
title('dF, plano XZ (y=0)');

%% Força Total
F_Total1 = 0;
F_Total2 = 0;
for i = 1:length(x)
    disp(i)
    
    if (x(i) > 0)
        F_Total2 = F_Total2 + norm(F2(:,i,ymedio,zmedio));
    end
    if (x(i) < 0)
        F_Total1 = F_Total1 + norm(F1(:,i,ymedio,zmedio));
    end
end
disp(F_Total1);
disp(F_Total2);
