%% Questão 3
% Considere uma linha de carga, no eixo z, com densidade linear de cargas
% uniforme pL = 1 C/m, se estendendo de z = -1 m até z = 1 m. Calcule,
% numericamente, a intensidade de campo elétrico E em qualquer posição espaço.
% Faça uma representação gráfica de E no plano xz e uma no plano xy.


%% Variaveis Dadas
clc
clear all
close all

z1=-1;
z2=1;
pL=1;  %Densidade Superficial de Carga [C/m^2]
k=1/(4*pi*8.854*10^(-12));  %Constante

%% Variaveis Criadas

%Onde o campo sera medido:
x=[-2:1/20:2]; %vetor na coordenada x onde será calculado E
z=[-2:1/20:2]; %vetor na coordenada z onde será calculado E
y=[-2:1/20:2]; %vetor na coordenada y onde será calculado E

%Gerador do campo:
zl=[z1:1/20:z2]; % variação da coordenada x onde está a carga (centro dos segmentos)

%A = 1; %área de cada segmento

%inicializa o campo elétrico:
E(1,:,:) = zeros (length(x),length(y)); 
E(2,:,:) = zeros (length(x),length(y));
E(3,:,:) = zeros (length(x),length(y));

%% Desenvolvimento
for i = 1:length(x)% varre a coordenada x onde E será calculado
    for j = 1: length(y)  % varre a coordenada y onde E será calculado
        
        for m = 1:length(zl)  % varre a coordenada x da carga
                
                r = [x(i),y(j),0]; %vetor posição apontando para onde estamos calculando E
                rl= [0,0,zl(m)];% vetor posição apontando para um segmento da placa
                
                if ((r-rl)*(r-rl)'>1/100) %??????
                E(:,i,j) = E(:,i,j)  + (pL*1/sqrt((r-rl)*(r-rl)')^3*(r-rl))'; % para cada ponto (xl, yl)  da placa somo a contribuição da carga para o campo na posição (x,z). Considero a carga concentrada no centro do segmento.
                end

        end
        
    end
end
E= E*k;

%% Grafico
[X,Y] = meshgrid(x,y);
quiver(X,Y,squeeze(E(1,:,:))' , squeeze(E(2,:,:))')  %faz o gráfico vetorial
xlabel('eixo x (m)')
ylabel('eixo y (m)')

