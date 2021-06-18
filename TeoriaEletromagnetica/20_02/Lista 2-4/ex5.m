%% Questão 5                Arthur A. S. Araújo
% Determine, numericamente, a indutância mútua entre um longo fio reto 
% e uma espira em formato de triânguilo equilátero de labo b (em metros). 
% Um dos vértices do triângulo é o ponto mais próximo do fio, e está a 
% uma distância d (em metros), conforme a figura. Para avaliar sua resposta,
% considere b=9 cm e d=5 cm.

%% Variáveis fornecidas
clc
clear all
close all

u0 = 4*pi*10^(-7); %permeabilidade magnética do espaço livre (em H/m)

b = 9*10^(-2); %lado triângulo (em m)
d = 5*10^(-2); %distância (em m)

h = b*sqrt(3)/2; %altura do triângulo

I = [0,0,1]; %corrente arbitrária (em A)

%% Variáveis Criadas
lim = 1.5*(d+h); %limite para as coordenadas x e y
passo = d/2;

%variação das coordenadas onde será calculado B
dx = passo;
dy = passo;
dz = passo;

x = [-lim:dx:lim];
y = [-lim:dy:lim];
z = [-b:dz:b];

%variação das coordenadas do fio
zl = [-2*lim+dz/2:dz:2*lim-dz/2];

%inicializa a densidade de fluxo magnético B
B(1,:,:,:) = zeros(length(x),length(y),length(z));
B(2,:,:,:) = zeros(length(x),length(y),length(z));
B(3,:,:,:) = zeros(length(x),length(y),length(z));

%índices para x = y = z = 0
midx = ceil(length(x)/2);
midy = ceil(length(y)/2);
midz = ceil(length(z)/2);

%% Calcula B Fio
for i = 1:length(x) %varre as coordenadas onde B2 será calculado
    disp(i)
    for j = 1:length(y)
        for k = 1:length(z)
            
            for n = 1:length(zl) %varre a coordenada do fio

                r = [x(i),y(j),z(k)];  %vetor posição do ponto de campo (onde calculamos B)
                rl1 = [0,0,zl(n)]; %vetor posição do fio

                    if ((r-rl1)*(r-rl1)' > (dz/2)^2) %evitando a divisão por zero, no caso em que r = rl

                    dL = dz;
                    I_x_rrl = cross(I, r-rl1);
                    dB = (I_x_rrl')*dL / (((r-rl1)*(r-rl1)')^(3/2)); %essa é a contribuição dB devida a I

                    B(:,i,j,k) = B(:,i,j,k) + dB;

                    end
            end
        end
    end
end
B = B*u0/(4*pi);

%% Calcula Fluxo
%calcular o fluxo magnético
psi = 0; 
for j = 1:length(y) %varre as coordenadas onde Psi será calculado
    disp(i)
    for k = 1:length(z)
        
        if( (z(k) <= 1/sqrt(3)*(y(j)-d)) && (z(k) >= -1/sqrt(3)*(y(j)-d)) && (y(j) >= d) && (y(j)<= d+h) )
            %psi = integral(Bfio*dS2)
            psi = psi + dot(B(:,midx,j,k),[-dy*dz,0,0]);
        end
    end
end

L = psi/norm(I);
disp(L);    %A resposta correta é: 7,15093871e-9 H.
% Encontrado: 7.3920e-09

%% Plot B
%gráfico vetorial de B no plano XY
[X,Y] = meshgrid(x,y);
figure (1);
quiver(X, Y, squeeze(B(1,:,:,midz))', squeeze(B(2,:,:,midz))'); 
line([d,d+h], [0, 0], 'Color', 'r');
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('B, plano XY (z=0)');
