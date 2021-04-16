%% Quest„o 9                Arthur A. S. Ara˙jo
% Dois anÈis circulares coaxiais de raios a e b tÍm seus eixos alinhados
% com o eixo z. O anel de raio a tem centro na origem de coordenadas,
% enquanto que o anel de raio b tem seu centro em coordenadas x, y e z
% arbitr·rias.  Determine, numericamente, a indut‚ncia m˙tua entre os anÈis.
% Afim de avaliar sua resposta considere que os dois circuitos est„o no espaÁo
% livre, dispostos como mostrado na figura, com  a =1,8 mm, b = 2,1 mm e h = 26,3 mm.

%% Vari·veis fornecidas
clc
clear all
close all

u0=4*pi*10^(-7); % Permeabilidade magn√©tica do espa√ßo livre (em H/m)

a = 1.8*10^(-3); % raio do anel 1
b = 2.1*10^(-3); % raio do anel 2
h = 26.3*10^(-3);

deslocx = 0.5*10^(-3);
deslocy = 0.5*10^(-3);

I=1; % corrente que flui no anel

%% Vari·veis Criadas
lim = 2*b; % limite para as coordenadas x, y e z
passo = a/4; % passo

dx = passo;
dy = passo;
dz = passo;

x = [-lim:dx:lim]; %varia√ß√£o da coordenada x onde ser√° calculado B
y = [-lim:dy:lim]; %varia√ß√£o da coordenada y onde ser√° calculado B
z = [-1.5*h:dz:1.5*h]; %varia√ß√£o da coordenada z onde ser√° calculado B

% Inicializa a densidade de fluxo magn√©tico
B(1,:,:,:) = zeros(length(x),length(y),length(z));
B(2,:,:,:) = zeros(length(x),length(y),length(z));
B(3,:,:,:) = zeros(length(x),length(y),length(z));

x0=ceil(length(x)/2);
y0=ceil(length(y)/2);
z0=ceil(length(z)/2);

dphi=2*pi/14;
phil=[0:dphi:2*pi-dphi/2];

%% Calcula B
for i = 1:length(x)% varre a coordenada x onde B ser√° calculado
    disp(i)
    for j = 1: length(y)  % varre a coordenada y onde B ser√° calculado
        for k = 1:length(z) % varre a coordenada z onde B ser√° calculado
            
            for m = 1:length(phil)  % varre a coordenada phil, onde existe a corrente
                
                r = [x(i),y(j),z(k)];  %vetor posi√ß√£o do ponto de campo (onde calculamos B)
                [rl(1), rl(2), rl(3)] = pol2cart(phil(m), b, h); % convertemos rl para coord retangulares
                rl = [rl(1)+deslocx, rl(2)+deslocy, rl(3)];
                
                [dL(1), dL(2), dL(3)] = pol2cart(pi/2+phil(m), b*dphi, 0);

                dl_x_rrl = cross(dL, r-rl);
 
%                 if  ((r-rl)*(r-rl)' > dz/2)
                    dB = dl_x_rrl'/(sqrt((r-rl)*(r-rl)')^3); % essa √© a contribui√ß√£o dB devida a esse dL
                    
                    B(:,i,j,k) = B(:,i,j,k) + dB;
                    
%                 end
                
            end
        end
    end
end

B = B*u0*I/(4*pi);

%% Calcula Fluxo
psi = 0;
for i = 1:length(x) %varre as coordenadas onde Psi ser· calculado
    disp(i)
    for j = 1:length(y)
        
        dS1 = [0,0,dx*dy];
        
        if( (sqrt(x(i)^2+y(j)^2) <= a) ) %se est· na espira 1
            %psi = integral(B*dS)           
            psi = psi + dot(B(:,i,j,z0),dS1);
        end
    end
end

%% Calcula L
L = psi/I;
disp(L);    %A resposta correta È: 1,55040834e-12 H.

%% Plot B
%gr·fico vetorial de B no plano XY
[Y,Z] = meshgrid(y,z);
figure (1);
quiver(Y, Z, squeeze(B(2,x0,:,:))', squeeze(B(3,x0,:,:))'); 
xlabel('eixo y (m)')
ylabel('eixo z (m)')
title('B, plano YZ (x=0)');