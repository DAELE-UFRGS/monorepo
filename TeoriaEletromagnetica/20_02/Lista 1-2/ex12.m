%% Questao 12
% Dado o campo de potencial, no espaço livre, V = 100xz/(x2 + 4) V, considerando
% que a superfície z = 0 seja a superfície de um condutor, calcule numericamente
% a distribuição superficial de cargas para qualquer lugar no espaço, e determine
% a carga total na porção do condutor definida por 0 < x < 9,2 m ; -8 m < y < 0.

%% Variaveis Dadas

clc
clear all
close all

e0=8.854*10^-12;
xmax = 9.2;
ymax = 8;
zmax = 30;

%% Variaveis Criadas

%passos
dx = xmax/50;
dy = ymax/50;
dz = zmax/50;

%espaço
x=[-zmax:dx:zmax];
y=[-zmax:dy:zmax];
z=[-zmax:dz:zmax];

%area de cálculo
xn=(x(2:end-1));
yn=(y(2:end-1));
zn=(z(2:end-1));

%Campo Elétrico
E(1,:,:,:) = zeros (length(xn),length(yn),length(zn));
E(2,:,:,:) = zeros (length(xn),length(yn),length(zn));
E(3,:,:,:) = zeros (length(xn),length(yn),length(zn));

%Potencial
V(:,:,:) = zeros (length(x), length(y), length(z));

%% Desenvolvimento (Calcula Pontos do Potencial Elétrico)

for i = 1:length(x)
    disp(i)
    for j = 1:length(y)
        for k = 1:length(z)
            
            campoV = (100*x(i)*z(k))/((x(i))^2 + 4);
            V(i,j,k) = campoV;
            
        end
    end
end

%% Desenvolvimento (Calcula Campo Elétrico)

for i = 2:length(x)-1% varre a coordenada x onde E será calculado
    disp(i)
    for j = 2 :length(y)-1
        for k = 2: length(z)-1  % varre a coordenada z onde E será calculado
            
            E(1,i-1,j-1,k-1) = -(V(i+1,j,k)-V(i-1,j,k))/2/dx; %Calcula a componente x do campo elétrico Ex como a -dV/dx, fazendo usando uma aproximação de diferença central;
            E(2,i-1,j-1,k-1) = -(V(i,j+1,k)-V(i,j-1,k))/2/dy; %Calcula Ey
            E(3,i-1,j-1,k-1) = -(V(i,j,k+1)-V(i,j,k-1))/2/dz; %calcula Ez
        end
    end
end

%% Desenvolvimento (Calcula Densidade de Carga)

D = E*e0;
ps = D;

carga = 0;
z0 = round(length(zn/2));

for i = 2:length(xn)
    for j = 2:length(yn)
        if(x(i)>0 && x(i)<xmax && y(j)>-ymax && y(j)<0)
            carga = carga + ps(3,i,j,z0)*dx*dy;
        end
    end
end

disp(carga)
