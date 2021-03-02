%% Questao 9
% Um cabo coaxial infinitamente longo possui uma distribuição volumétrica de 
% cargas uniforme ?v no cilindro interno (raio a), e uma densidade superficial 
% de carga uniforme ?s na casca externa do cilindro (raio b). Essa carga 
% superficial é negativa  e de magnitude exata para que o cabo, como um todo, 
% seja eletricamente neutro. Determine numericamente o pontecial em qualquer 
% região do espaço, considerando ?v = 8,3 pC/m³, a = 6,8 mm, b = 8,6 mm. 
% Desenhe as curvas equipotenciais a partir deste cálculo. Para avaliar sua 
% resposta, determine a diferença de potencial entre um ponto no eixo e um 
% ponto no cilindro externo.

%% Variaveis Dadas
clc
clear all
close all

pv = 8.3*10^(-12);  %Densidade Volumétrica de Carga no cilindro interno[C/m^3]

%Q da casca deve ser igual ao Q interno, logo: ps = (-pv*a^2)/(2*b);

a = 6.9*10^(-3);    %Raio Menor
b = 8.6*10^(-3);    %Raio Maior

e0=8.854*10^(-12);  %Constante
k=1/(4*pi*e0);      %Constante

%% Variaveis Criadas
passo = a/5;
lim = 2*b;
%Vamos considerar que o cabo se encontra sobre o eixo Z

%Gerador do potencial Cilindro Central:
xl=[-a:passo:a]; 
yl=[-a:passo:a];
zl=[-lim:passo:lim];

%Onde o potencial sera medido: (Define as coordenadas)
x=[-lim:passo:lim]; %vetor na coordenada x onde será calculado E
y=[-lim:passo:lim]; %vetor na coordenada y onde será calculado E

Vol = passo^3; %volume de cada segmento

%Gerador do potencial Casca Cilíndrica:
xll=[-b:passo:b]; 
yll=[-b:passo:b];
zll=[-lim:passo:lim];

A = passo^2;

%inicializa o potencial elétrico:
V(:,:) = zeros (length(x),length(y)); 

%% Desenvolvimento (Calcula Pontos do Potencial Elétrico)
for i = 1:length(x)
    disp(i)
    for j = 1:length(y)
            
            for m = 1:length(xl)                % varre a coordenada x da carga
                for n = 1:length(yl)            % varre a coordenada y da carga
                    for o = 1:length(zl)        % varre a coordenada y da carga        
                    
                        r = [x(i),y(j),0];      %vetor posição apontando para onde estamos calculando E
                        rl= [xl(m),yl(n),zl(o)];    % vetor posição apontando para a carga
                        
                        if (sqrt(xl(m)^2+yl(n)^2)<=a)
                            %if ((r-rl)*(r-rl)'>passo/10000)
                            V(i,j) = V(i,j)  + (pv*Vol/sqrt((r-rl)*(r-rl)'))';
                            %end
                        end
                        
                    end
                    
                end
            end
            
    end
end

%% Desenvolvimento (Calcula Pontos do Potencial Elétrico) [CASCA]
for i = 1:length(x)
    disp(i)
    for j = 1:length(y)
            
            for m = 1:length(xll)                       % varre a coordenada x da carga
                for n = 1:length(yll)                   % varre a coordenada y da carga
                    for o = 1:length(zll)               % varre a coordenada y da carga        
                    
                        r = [x(i),y(j),0];              % vetor posição apontando para onde estamos calculando E
                        rll= [xll(m),yll(n),zll(o)];    % vetor posição apontando para a carga
                        
                        raio = sqrt(xll(m)^2+yll(n)^2);
                        if (raio > 0.9*b) && (raio < 1.1*b)
                            if ((r-rll)*(r-rll)'>passo/1000)
                            V(i,j) = V(i,j)  + (((-pv*a^2)/(2*b))*A/sqrt((r-rll)*(r-rll)'))';
                            end
                        end
                        
                    end
                end
            end
            
    end
end

V= V*k;

%% Plot Gráficos POTENCIAL ELÉTRICO
[X,Y] = meshgrid(x,y);

figure
pcolor(X,Y,V)
colorbar
xlabel('eixo x (m)')
ylabel('eixo y (m)')
hold

figure
surf(X,Y,V)
colorbar
xlabel('eixo x (m)')
ylabel('eixo y (m)')
hold

figure
contour3(X,Y,V,20)
colorbar
xlabel('eixo x (m)')
ylabel('eixo y (m)')
hold

figure
contour(X,Y,V,20)
colorbar
xlabel('eixo x (m)')
ylabel('eixo y (m)')
hold