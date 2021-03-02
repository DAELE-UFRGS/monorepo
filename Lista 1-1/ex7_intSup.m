%% Questão 7
% Na região do espaço livre que inclui o volume 1,8 m < x < 5 m, 1,8 m < y < 5 m,
% 1,8 m < z < 5 m, D = 2(yz ax + xz ay ? 2xy az
% )/z2 C/m2
% . Avalie, numericamente, a
% carga dentro do volume usando dois métodos diferentes.

%% Variaveis Dadas
clc
clear all
close all

x1=1.8;
x2=5;

%% Variaveis Criadas

passo = 1/150;

%Gerador do campo:
xl=[x1:passo:x2]; % variação da coordenada onde está a carga 
yl=[x1:passo:x2];
zl=[x1:passo:x2];

Q = 0; QU = 0; QD = 0; QL = 0; QR = 0; QF = 0; QB = 0;

A = passo^2; %área de cada segmento

%Como é um paralelepípedo, temos 6 Normais. 3 Eixos com coordenadas
%positivas e negativas.

%% Função da Densidade de Fluxo
syms x y z 
D =[2*y/z 2*x/z -4*x*y/(z^2)]; 

dens = symfun(D,[x y z]); %Cria Função Simbólica e substitui na Densidade
densN = matlabFunction(dens);   %Passa a função de Simbólica pra Numérica

%% Desenvolvimento

%Superfície Superior(QU)
dS = [0 0 1];
for i = 1:length(xl)  % varre a coordenada x da carga
    disp(i)
    for j = 1:length(yl)  % varre a coordenada y da carga
            QU = QU + dot((densN(xl(i),yl(j),x2)),dS)*A;
    end
end
%Superfície Inferior (QD)
dS = [0 0 -1];
for i = 1:length(xl)  % varre a coordenada x da carga
    disp(i)
    for j = 1:length(yl)  % varre a coordenada y da carga
            QD = QD + dot((densN(xl(i),yl(j),x1)),dS)*A;
    end
end

%Superfície Esquerda (QL)
dS = [0 -1 0];
for i = 1:length(xl)  % varre a coordenada x da carga
    disp(i)
    for j = 1:length(zl)  % varre a coordenada z da carga
            QL = QL + dot((densN(xl(i),x1,zl(j))),dS)*A; 
    end
end
%Superfície Direita (QR)
dS = [0 1 0];
for i = 1:length(xl)  % varre a coordenada x da carga
    disp(i)
    for j = 1:length(zl)  % varre a coordenada z da carga
            QR = QR + dot((densN(xl(i),x2,zl(j))),dS)*A; 
    end
end
%Superfície Frontal (QF)
dS = [1 0 0];
for i = 1:length(yl)  % varre a coordenada y da carga
    disp(i)
    for j = 1:length(zl)  % varre a coordenada z da carga
            QF = QF + dot((densN(x2,yl(i),zl(j))),dS)*A; 
    end
end
%Superfície Traseira (QB)
dS = [-1 0 0];
for i = 1:length(yl)  % varre a coordenada y da carga
    disp(i)
    for j = 1:length(zl)  % varre a coordenada z da carga
            QB = QB + dot((densN(x1,yl(i),zl(j))),dS)*A; 
    end
end


Q = QU + QD + QL + QR + QF + QB;
disp(double(Q))

%RESPOSTA: 127.9341
