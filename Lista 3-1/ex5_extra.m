%% Questão 5                Arthur A. S. Araújo
% Uma espira filamentar quadrada de lado a está posicionada no plano xy,
% com seu centro alinhado com o eixo z. A espira está parada nesta posição.
% Determine a magnitude da FEM induzida que resulta de uma densidade de
% fluxo magnético dado por B(y,t) = B0 cos( ?t - ?y) az. Afim de avaliar a
% sua resposta considere
% B0 = 9,1 Wb/m2,? = 80,3 rad/s, ? = 8,5 rad/m, a = 0,01 m, t = 1,1 s.

%% Variáveis Dadas
clc
clear all
close all

%VARIÁVEIS FORNECIDAS
a = 0.01;
w = 80.3;
B0 = 9.1;
beta = 8.5;
tempo = 1.1;

u0 = 4*pi*10^-7; % permeablidade do espaço livre (em H/m)

%% Variáveis Criadas
periodo = 1/(w/(2*pi));
%Passos
passo = a/5;
lim = 2*a;
lim_t = 2*tempo;

dx=passo;
dy=passo;
dz=passo;

dt=periodo/20;
%Espaços
x = [-lim:dx:lim]; %variacao da coordenada x
y = [-lim:dy:lim]; %variacao da coordenada y
z = [-lim:dz:lim]; %variacao da coordenada z

t = [0:dt:lim_t];

% GRÁFICO DE B (YZ)
midx = ceil(length(x)/2);
midy = ceil(length(y)/2);
midz = ceil(length(z)/2);

% Inicializa a densidade de fluxo magnÃ©tico
B(1,:,:,:,:) = zeros(length(x),length(y),length(z),length(t));
B(2,:,:,:,:) = zeros(length(x),length(y),length(z),length(t));
B(3,:,:,:,:) = zeros(length(x),length(y),length(z),length(t));


%% CÁLCULO B
for p = 1:length(t)
    disp(p)
    for i = 1:length(x)
        for j = 1:length(y)
            for k = 1:length(z)
                
                B(:,i,j,k,p) = [0,0,B0*cos(w*t(p)-beta*y(j))];
                
            end
        end
    end
end

%% CÁLCULO DO FLUXO NA ESPIRA
%integral de B dS -> dS = n*dA
fluxo = zeros([1,length(t)]);
for p = 1:length(t)
    disp(p)
    for i = 1:length(x)
        for j = 1:length(y)
            
            if (x(i)<= a/2 && x(i)>= -a/2 && y(j)<= a/2 && y(j)>= -a/2)
                dA=dx*dy;
                %n = [0,-sin(w*t(p)),cos(w*t(p))];
                n = [0,0,1];
                dS = n*dA;
                
                fluxo(1,p) = fluxo(1,p) + dot(B(:,i,j,midz,p),dS);
            end
        end
    end
end

%%  GRÁFICO DO FLUXO X TEMPO (YZ)
figure(2);
plot(t,fluxo);
xlabel('tempo')
ylabel('fluxo')
title('Fluxo no tempo');

%% Calcula FEM
Vfem = zeros([1,length(t)]);
for i = 2:length(t)-1% varre a coordenada x onde E será calculado
    disp(i);
    Vfem(1,i) = -(fluxo(1,i+1)-fluxo(1,i-1))/2/dt;
end

%%  GRÁFICO DA FORÇA ELETROMOTRIZ X TEMPO (YZ)
figure(3);
plot(t,Vfem);
xlabel('tempo')
ylabel('V')
title('FEM no tempo');
