%% Questao 11
% A superfície anelar 1 cm < ? < 3 cm, z =0, está carregada com a 
% densidade superficial não uniforme de cargas ps = 2,6r nC/m2. 
% Assumindo V=0 no infinito, determine numericamente o potencial 
% devido à superficie anelar carregada em qualquer ponto do espaço. 
% Com os dados obtidos, trace o gráfico do potencial em função de z, 
% considerando x=0 e y=0. Trace também o gráfico do potencial nos 
% planos xz e xy. Para validar sua resposta, calcule V em 
% P(x = 0, y = 0, z= 2) cm.

%% Variaveis Dadas
clc
clear all
close all

ps = 2.6*10^(-9);  %Densidade Volumétrica de Carga no cilindro interno[C/m^3]

%Q da casca deve ser igual ao Q interno, logo: ps = (-pv*a^2)/(2*b);
%P(x = 0, y = 0, z= 2)

r1 = 1*10^(-2);    %Raio Menor
r2 = 3*10^(-2);    %Raio Maior

e0=8.854*10^(-12);  %Constante
ke=1/(4*pi*e0);      %Constante

%% Variaveis Criadas
% passo = r2/10;
% lim = 2*r2;

lim = 1.5*r2;
passo = r1/5; %tamanho dos segmentos 
%Vamos considerar que o cabo se encontra sobre o eixo Z

%Gerador do potencial:
xl=[-r2:passo:r2]; 
yl=[-r2:passo:r2];

%Onde o potencial sera medido: (Define as coordenadas)
x = [-lim:passo:lim]; %vetor na coordenada x onde será calculado E
y = [-lim:passo:lim]; %vetor na coordenada y onde será calculado E
z = [-lim:passo:lim]; %vetor na coordenada z onde será calculado E

A = passo^2;

%inicializa o potencial elétrico:
V(:,:,:) = zeros (length(x),length(y),length(z)); 

%% Desenvolvimento (Calcula Pontos do Potencial Elétrico)
for i = 1:length(x)
    disp(i)
    for j = 1:length(y)
         for k = 1:length(z)
             
            for m = 1:length(xl)                % varre a coordenada x da carga
                for n = 1:length(yl)            % varre a coordenada y da carga
                    
                    r = [x(i),y(j),z(k)];      %vetor posição apontando para onde estamos calculando E
                    rl= [xl(m),yl(n),0];       % vetor posição apontando para a carga

                    raio = sqrt(xl(m)^2+yl(n)^2);
                    if (raio<r2)&&(raio>r1)
                        %if ((r-rl)*(r-rl)'>passo/10000)
                        V(i,j,k) = V(i,j,k)  + (ps*raio*A/sqrt((r-rl)*(r-rl)'))';
                        %end
                    end
                    
                end
            end
            
         end
    end
end

V= V*ke;

%% Plot Gráficos POTENCIAL ELÉTRICO
midy = int64(length(y)/2);
midz = int64(length(z)/2);

[X,Z] = meshgrid(x,z);
figure
contour3(X,Z,squeeze(V(:,midy,:)),50)
colorbar
xlabel('eixo x (m)')
ylabel('eixo z (m)')
hold

figure
contour(X,Z,squeeze(V(:,midy,:)),50)
colorbar
xlabel('eixo x (m)')
ylabel('eixo z (m)')
hold

[X,Y] = meshgrid(x,y);
figure
contour3(X,Y,squeeze(V(:,:,midz)),30)
colorbar
xlabel('eixo x (m)')
ylabel('eixo y (m)')
hold

figure
contour(X,Y,squeeze(V(:,:,midz)),30)
colorbar
xlabel('eixo x (m)')
ylabel('eixo y (m)')
hold