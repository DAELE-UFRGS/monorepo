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

V = passo^3; %volume de cada segmento
Q = 0;

%% Calcula o Divergente
syms x y z 
D =[2*y/z 2*x/z -4*x*y/(z^2)]; %input('Insira o vetor na forma simbolica [fx(x,y,z) fy(x,y,z) fz(x,y,z)]...\n')
divD = diff(D(1),x) + diff(D(2),y) + diff(D(3),z);
pv=divD;

div = symfun(pv,[x y z]); %Cria Função Simbólica e substitui no Divergente
divnum = matlabFunction(div);

%% Desenvolvimento

for i = 1:length(xl)  % varre a coordenada x da carga
    disp(i)
    for j = 1:length(yl)  % varre a coordenada y da carga
        for k = 1:length(zl)
            Q = Q + (divnum(xl(i),yl(j),zl(k))*V); 
        end
    end
end
disp(double(Q))

%RESPOSTA: 127.9341
