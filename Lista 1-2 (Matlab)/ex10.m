%% Questao 10
% Calcule numericamente o potencial produzido por uma linha de cargas
% ?L = k.x/(x² +a²) que se estende ao longo do eixo x, de x = a até +?,
% com a = 9,7 m e k = 6,9 pC, em todo o espaço. Considere o zero de referência
% no infinito. Trace o gráfico das linhas equipotenciais nos planos yz e xz.
% Para validar sua resposta, calcule V na origem.

%% Variaveis Dadas
clc
clear all
close all

a = 9.7;

e0=8.854*10^(-12);      %Constante
ke=1/(4*pi*e0);         %Constante

%% Variaveis Criadas
passo = a/10;
lim = 30;
%Vamos considerar que o cabo se encontra sobre o eixo Z

%Gerador do potencial:
xl=[a:passo:5*lim];

%Onde o potencial sera medido: (Define as coordenadas)
x=[-lim:passo:lim];     %vetor na coordenada x onde será calculado E
y=[-lim:passo:lim];     %vetor na coordenada y onde será calculado E
z=[-lim:passo:lim];     %vetor na coordenada y onde será calculado E

%inicializa o potencial elétrico:
V(:,:,:) = zeros (length(x),length(y),length(z));

%% Desenvolvimento (Calcula Pontos do Potencial Elétrico)
for i = 1:length(x)
    disp(i)
    for j = 1:length(y)
        for k = 1:length(z)
            
            for m = 1:length(xl)                % varre a coordenada x da carga
                
                r = [x(i),y(j),z(k)];           %vetor posição apontando para onde estamos calculando E
                rl= [xl(m),0,0];                % vetor posição apontando para a carga
                
                pl = (6.9*10^(-12)*xl(m))/(xl(m)^2 +a^2);
                V(i,j,k) = V(i,j,k) + (pl*passo/sqrt((r-rl)*(r-rl)'))';
                
            end
            
        end
    end
end
V= V*ke;

%% Plot Gráficos POTENCIAL ELÉTRICO
[X,Y] = meshgrid(x,y);
midx = int64(length(x)/2);
midy = int64(length(y)/2);
midz = int64(length(z)/2);

figure
contour(Y,X,squeeze(V(:,:,midz)),50)
colorbar
xlabel('eixo x (m)')
ylabel('eixo y (m)')
hold

[X,Z] = meshgrid(x,z);
figure
contour(Z,X,squeeze(V(:,midy,:)),50)
colorbar
xlabel('eixo x (m)')
ylabel('eixo z (m)')
hold

[Y,Z] = meshgrid(y,z);
figure
contour(Z,Y,squeeze(V(midx,:,:)),50)
colorbar
xlabel('eixo y (m)')
ylabel('eixo z (m)')
hold