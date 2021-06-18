%% Quest„o 7                Arthur A. S. Ara˙jo
% Calcule, numericamente, a auto-indut‚ncia de uma espira de raio a.

%% Vari·veis fornecidas
clc
clear all
close all

u0 = 4*pi*10^(-7); %permeabilidade magnÈtica do espaÁo livre (em H/m)

a = 1; %raio 
I = 1;

%% Vari·veis Criadas
lim = 2*a; %limite para as coordenadas x e y
passo = a/8;

%variaÁ„o das coordenadas onde ser· calculado A
dx = passo;
dy = passo;
dz = passo;

x = -lim:dx:lim;
y = -lim:dy:lim;
z = -lim:dz:lim;

%variaÁ„o das coordenadas da espira
dphi = 2*pi/14;
drho = a/10;

phil = 0:dphi:2*pi-dphi/2; %notar que excluÌmos 2*pi, pois j· temos 0

% Inicializa a densidade de fluxo magn√©tico
B(1,:,:,:) = zeros(length(x),length(y),length(z));
B(2,:,:,:) = zeros(length(x),length(y),length(z));
B(3,:,:,:) = zeros(length(x),length(y),length(z));

%Ìndices para x = y = z = 0
x0 = ceil(length(x)/2);
y0 = ceil(length(y)/2);
z0 = ceil(length(z)/2);

%% Calcula B
for i = 1:length(x)% varre a coordenada x onde B ser√° calculado
    disp(i)
    for j = 1: length(y)  % varre a coordenada y onde B ser√° calculado
        for k = 1:length(z) % varre a coordenada z onde B ser√° calculado
            
            for m = 1:length(phil)  % varre a coordenada phil, onde existe a corrente
                
                r = [x(i),y(j),z(k)];  %vetor posi√ß√£o do ponto de campo (onde calculamos B)
                [rl(1), rl(2), rl(3)] = pol2cart(phil(m), a, 0); % convertemos rl para coord retangulares
                
                [dL(1), dL(2), dL(3)] = pol2cart(pi/2+phil(m), a*dphi, 0);

                dl_x_rrl = cross(dL, r-rl);
 
                 if  ((r-rl)*(r-rl)' > (dz/2)^2)
                    dB = dl_x_rrl'/(sqrt((r-rl)*(r-rl)')^3); % essa √© a contribui√ß√£o dB devida a esse dL
                    
                    B(:,i,j,k) = B(:,i,j,k) + dB;
                    
                 end
                
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
        
        if( (sqrt(x(i)^2+y(j)^2) <= a) ) 
            %psi = integral(B*dS)           
            psi = psi + dot(B(:,i,j,z0),dS1);
        end
    end
end

%% Calcula L
L = psi/I;
disp(L);    % 3.9902e-06

%% Plot B
%gr·fico vetorial de B no plano XY
[Y,Z] = meshgrid(y,z);
figure (1);
quiver(Y, Z, squeeze(B(2,x0,:,:))', squeeze(B(3,x0,:,:))'); 
xlabel('eixo y (m)')
ylabel('eixo z (m)')
title('B, plano YZ (x=0)');