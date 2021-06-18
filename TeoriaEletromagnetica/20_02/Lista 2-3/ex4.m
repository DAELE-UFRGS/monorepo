%% Questão 4                Arthur A. S. Araújo
% Uma longa fita condutora metálica estende-se de -d/2 <y < d/2 ao longo do eixo z.
% Nessa fita, flui uma corrente I, no sentido positivo de z, distribuída
% uniformemente. Um fio condutor se estende paralelo ao eixo z, passando pelo
% ponto y = 0, x = b. Uma corrente I passa por esse condutor no sentido negativo
% de z. Determine numericamente a densidade de fluxo magnético resultante em todo
% o espaço. Trace o gráfico de um plano perpendicular ao comprimento do fio e da fita.
% Em seguida, determine numericamente as forças diferenciais por unidade de comprimento
% existentes na região em que existe a fita e o fio. Integre numericamente essas forças
% para determinar as forças por unidade de comprimento sofridas tanto pela fita quanto
% pelo fio.

%% Variáveis Dadas
clc
clear all
close all

u0 = 4*pi*10^-7; % permeablidade do espaço livre (em H/m)
d = 0.2;
b = 0.6;
I = 0.8;

%% Variáveis Criadas
passo=d/6; % passo

dx=passo;
dy=passo;
dz=passo;

x= [-1.5*b:dx:1.5*b]; %variacao da coordenada x
y= [-b:dy:b]; %variacao da coordenada y
z= [-d/2:dz:d/2]; %variacao da coordenada z

yl1= [-(d/2+dy/2):dy:(d/2+dy/2)]; %variacao da coordenada y onde está a fita
zl1= [-(2*d+dz/2):dz:(2*d+dz/2)]; %variacao da coordenada z onde está a fita

xl2 = b;
zl2= [-(2*d+dz/2):dz:(2*d+dz/2)]; %variacao da coordenada x onde está a fio
%Campo Total
B(1,:,:,:) = zeros(length(x),length(y),length(z));
B(2,:,:,:) = zeros(length(x),length(y),length(z));
B(3,:,:,:) = zeros(length(x),length(y),length(z));
%Campo Fita
B1(1,:,:,:) = zeros(length(x),length(y),length(z));
B1(2,:,:,:) = zeros(length(x),length(y),length(z));
B1(3,:,:,:) = zeros(length(x),length(y),length(z));
%Campo Fio
B2(1,:,:,:) = zeros(length(x),length(y),length(z));
B2(2,:,:,:) = zeros(length(x),length(y),length(z));
B2(3,:,:,:) = zeros(length(x),length(y),length(z));

%Forças Totais
F (1,:,:,:) = zeros(length(x),length(y),length(z));
F (2,:,:,:) = zeros(length(x),length(y),length(z));
F (3,:,:,:) = zeros(length(x),length(y),length(z));
%Força na Fita
F1 (1,:,:,:) = zeros(length(x),length(y),length(z));
F1 (2,:,:,:) = zeros(length(x),length(y),length(z));
F1 (3,:,:,:) = zeros(length(x),length(y),length(z));
%Força no Fio
F2 (1,:,:,:) = zeros(length(x),length(y),length(z));
F2 (2,:,:,:) = zeros(length(x),length(y),length(z));
F2 (3,:,:,:) = zeros(length(x),length(y),length(z));

%% Descobrindo valor de B1 - Fita
for i = 1:length(x)% varre a coordenada x onde H será¡ calculado
    disp(i)
    for j = 1: length(y)  % varre a coordenada y onde H será calculado
        for k = 1:length(z) % varre a coordenada z onde H será calculado
            
            for m = 1:length(yl1)  % varre a coordenada yl, onde existe a corrente
                for n = 1:length(zl1)
                    
                    r1 = [x(i),y(j),z(k)];
                    rl1 = [0, yl1(m), zl1(n)];
                    
                    K1 = [0,0,I/d];
                    dS = dy*dz;
                    
                    %produto evetorial d K x ar-rl
                    K1_x_rrl = cross(K1, r1-rl1);
                    
                    %if  ((r1-rl1)*(r1-rl1)' > dz/2)
                        dB1 = K1_x_rrl'/(sqrt((r1-rl1)*(r1-rl1)')^3);
                        
                        B1(1,i,j,k) = B1(1,i,j,k) + dB1(1)*dS;
                        B1(2,i,j,k) = B1(2,i,j,k) + dB1(2)*dS;
                        B1(3,i,j,k) = B1(3,i,j,k) + dB1(3)*dS;
                        
                    %end
                end
            end
        end
    end
end
%% Descobrindo valor de B2 - Fio
for i = 1:length(x)% varre a coordenada x onde H será¡ calculado
    disp(i)
    for j = 1: length(y)  % varre a coordenada y onde H será calculado
        for k = 1:length(z) % varre a coordenada z onde H será calculado
            
            for n = 1:length(zl2)
                
                r2 = [x(i),y(j),z(k)];
                rl2 = [xl2, 0, zl2(n)];
                
                I2 = [0,0,-I]; %densidade de corrente superficial em az
                dl = dz; %componente de espaço bidimensional cart.
                
                %produto evetorial d K x ar-rl
                I2_x_rrl = cross(I2, r2-rl2);
                
                %if  ((r2-rl2)*(r2-rl2)' > dz/2)
                    dB2 = I2_x_rrl'/(sqrt((r2-rl2)*(r2-rl2)')^3);
                    
                    B2(1,i,j,k) = B2(1,i,j,k) + dB2(1)*dl;
                    B2(2,i,j,k) = B2(2,i,j,k) + dB2(2)*dl;
                    B2(3,i,j,k) = B2(3,i,j,k) + dB2(3)*dl;
                    
                %end
            end
        end
    end
end

B1=(u0/(4*pi))*B1;
B2=(u0/(4*pi))*B2;
B = B1+B2;

%% Descobrindo valor de Força diferencial
for i = 1:length(x)
    disp(i)
    for j = 1: length(y)
        for k = 1:length(z)
            
            if ((y(j) > -(d/2) && y(j) < d/2) && (x(i)>-dx/2 && x(i)<dx/2))
                F1(:,i,j,k) = cross(K1,B2(:,i,j,k))*dS;    %Fita
            end
            if ((x(i)> xl2-dx/2 && x(i)< xl2+dx/2) && (y(j)>-dy/2 && y(j)<dy/2)) 
                F2(:,i,j,k) = cross(I2,B1(:,i,j,k))*dl;    %Fio
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
q=quiver(X, Y, squeeze(B(1,:,:,zmedio))', squeeze(B(2,:,:,zmedio))');
set(q,'AutoScale','on', 'AutoScaleFactor', 2)
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('B, plano XY (z=0)');

%% Plot Força Diferencial
figure (2)
[X,Y] = meshgrid(x,y);
qf=quiver(X, Y, squeeze(F(1,:,:,zmedio))', squeeze(F(2,:,:,zmedio))');
set(qf,'AutoScale','on', 'AutoScaleFactor', 5)
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('dF, plano XY (z=0)');

%% Força Total/Comprimento
F_Total1 = 0;
F_Total2 = 0;
for i = 1:length(x)
    disp(i)
    
    if (x(i) > 0)
        F_Total2 = F_Total2 + norm(F2(:,i,ymedio,zmedio));  %Fio
    end
end
for i = 1:length(y)
    disp(i)
    
    if ((y(i) > -(d/2) && y(i) < d/2))
        F_Total1 = F_Total1 + norm(F1(:,xmedio,i,zmedio));  %Fita
    end
end
disp(F_Total1);
disp(F_Total2);