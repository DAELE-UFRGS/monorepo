%% Questão 4                           Arthur A S Araújo
% Seja J = 25/? a? -20/(?2 + 0,01) az A/m2. Determine numericamente o campo
% vetorial J para uma região do espaço que englobe o plano z = 4,3 e
% 0 < ? < 2*6,4. Trace o gráfico de J no plano xz (?=?/2). Trace o gráfico de
% J no plano xy (z=0). Trace o gráfico de J no plano z = 4,3. Trace o gráfico
% de J no plano z = -4,3.Com base nos dados calculados, integre numericamente
% o fluxo de J através do plano z = 4,3, na região em que ? < 6,4 m, determinando
% a corrente que passa por essa região.

%% Variaveis Dadas
clc
clear all
close all

u0=4*pi*10^(-7); % Permeabilidade magnÃ©tica do espaÃ§o livre (em H/m)

limz = 4.3;           %magnitude da analise em z
limp = 2*(6.4);       %magnitude da analise em p

%% Variaveis Criadas
passo = limp/100;        % passo

dx=passo;
dy=passo;
dz=passo;

x = [-limp:dx:limp];    %variacao da coordenada x
y = [-limp:dy:limp];    %variacao da coordenada y
z = [-limz:dz:limz];    %variacao da coordenada z

% Inicializa a densidade volumetrica de corrente
J(1,:,:,:) = zeros(length(x),length(y),length(z));
J(2,:,:,:) = zeros(length(x),length(y),length(z));
J(3,:,:,:) = zeros(length(x),length(y),length(z));

% Ã?ndice do valor mÃ©dio dos vetores de x, y e z.
% (Neste exemplo, sÃ£o os Ã­ndices em que x=y=z=0.)
xmedio = ceil(length(x)/2);
ymedio = ceil(length(y)/2);
zmedio = ceil(length(z)/2);

%% Desenvolvimento
for i = 1:length(x)% varre a coordenada x onde B serÃ¡ calculado
    disp(i)
    for j = 1: length(y)  % varre a coordenada y onde B serÃ¡ calculado
        for k = 1:length(z) % varre a coordenada z onde B serÃ¡ calculado
            
            raio = sqrt(x(i)^2+y(j)^2);
            
            J(1,i,j,k) = (25/raio) * x(i)/raio; 
            J(2,i,j,k) = (25/raio) * y(j)/raio;
            J(3,i,j,k) = (-20)/(raio^2 + 0.01);
            
        end
    end
end

%% Plot
%gráfico de J no plano yz (x=0)
figure(1);
[Y,Z] = meshgrid(y,z);
quiver(Y, Z, squeeze(J(2,xmedio,:,:))', squeeze(J(3,xmedio,:,:))');
hold on
contour(Y, Z, squeeze(J(1,xmedio,:,:))', 20);
colorbar
xlabel('eixo y (m)')
ylabel('eixo z (m)')
title('J no plano yz (phi=pi/2)');

%gráfico de J no plano xy (z=0)
figure(2);
[X,Y] = meshgrid(x,y);
quiver(X, Y, squeeze(J(1,:,:,zmedio))', squeeze(J(2,:,:,zmedio))');
hold on
contour(x, y, squeeze(J(3,:,:,zmedio))', 20);
colorbar
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('J no plano xy (z=0)');

%gráfico de J no plano z = 4,3
figure(3);
[X,Y] = meshgrid(x,y);
quiver(X, Y, squeeze(J(1,:,:,length(z)))', squeeze(J(2,:,:,length(z)))');
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('J no plano z = 4,3');

%gráfico de J no plano z = -4,3
figure(4);
[X,Y] = meshgrid(x,y);
quiver(X, Y, squeeze(J(1,:,:,1))', squeeze(J(2,:,:,1))');
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('J no plano z = -4,3');

%% Calculando corrente
%corrente em z = 4,3 e 0 < p < 6,4 m
%Inicializa a corrente
current = 0;
for i = 2:length(x)% varre a coordenada x
    disp(i)
    for j = 2: length(y)% varre a coordenada y
        raio = sqrt(x(i)^2+y(j)^2);
        if ((raio) < 6.4 && (raio) > 0)
            current = current + J(1,i,j,length(z))*dx*dy;
            current = current + J(2,i,j,length(z))*dx*dy;
            current = current + J(3,i,j,length(z))*dx*dy;
        end
    end
end

disp(current);  %Resp:  -514.4171
