%% Questão 3                Arthur A. S. Araújo
% Considere um cabo coaxial composto por um condutor interno sólido de 
% raio a separado de um condutor externo de raio b, cuja espessura é d 
% (valores em metros). Calcule, numericamente, a indutância por unidade 
% de comprimento dessa linha de transmissão, usando o método da energia. 
% Para avaliar sua resposta, considere a=2,4 cm, b = 33,5 cm e d= 5,4 cm.

%% Variáveis fornecidas
clc
clear all
close all

u0 = 4*pi*10^(-7); %permeabilidade magnética do espaço livre (em H/m)

a = 2.0*10^(-2); %raio interno (em m)
b = 3.5*10^(-2); %raio externo (em m)
d = 1.0*10^(-2); %espessura da casca (em m)

c = b + d;

I = 1; %corrente arbitrária (em A)

%% Variáveis Criadas
J1 = [0,0,I/(pi*a^2)]; %J = I/A
J2 = [0,0,-I/(pi*(c^2-b^2))];

lim = 2*c; %limite para as coordenadas x e y
passo = a/4;

dphi = pi/5;
drho = passo;

%variação das coordenadas onde será calculado B
dx = passo;
dy = passo;
dz = passo;

x = [-lim:dx:lim];
y = [-lim:dy:lim];
z = [-dz:dz:dz];

%variação das coordenadas condutor interno
phil1 = [0:dphi:2*pi-dphi/2];
rhol1 = [0:drho:a];
zl1 = [-lim:dx:lim]; %infinito

%variação das coordenadas condutor externo
phil2 = [0:dphi:2*pi-dphi/2];
rhol2 = [b:drho:c];
zl2 = [-lim:dx:lim]; %infinito

%inicializa a densidade de fluxo magnético B
B(1,:,:,:) = zeros(length(x),length(y),length(z));
B(2,:,:,:) = zeros(length(x),length(y),length(z));
B(3,:,:,:) = zeros(length(x),length(y),length(z));

B1(1,:,:,:) = zeros(length(x),length(y),length(z));
B1(2,:,:,:) = zeros(length(x),length(y),length(z));
B1(3,:,:,:) = zeros(length(x),length(y),length(z));

B2(1,:,:,:) = zeros(length(x),length(y),length(z));
B2(2,:,:,:) = zeros(length(x),length(y),length(z));
B2(3,:,:,:) = zeros(length(x),length(y),length(z));

%índices para x = y = z = 0
x0 = ceil(length(x)/2);
y0 = ceil(length(y)/2);
z0 = ceil(length(z)/2);

%% Calcula B Interno
%calcular B por Biot-Savart
for i = 1:length(x) %varre as coordenadas onde B será calculado
    disp(i)
    for j = 1:length(y)
        for k = 1:length(z)
            
            for m = 1:length(phil1)  %varre as coordenadas do condutor interno
                for n = 1:length(rhol1)
                    for o = 1:length(zl1)
                        
                        r = [x(i),y(j),z(k)];  %vetor posição do ponto de campo (onde calculamos B)
                        [rl1(1),rl1(2),rl1(3)] = pol2cart(phil1(m), rhol1(n), zl1(o));
                        
                        if ((r-rl1)*(r-rl1)' > (dx/2)^2) %evitando a divisão por zero, no caso em que r = rl
                            
                            dV = rhol1(n)*dphi*drho*dz;
                            J1_x_rrl = cross(J1, r-rl1);
                            dB1 = ((J1_x_rrl')*dV) / (sqrt((r-rl1)*(r-rl1)')^(3)); %essa é a contribuição dB devida a J
                            
                            B1(:,i,j,k) = B1(:,i,j,k) + dB1;
                        end
                    end
                end
            end
        end
    end
end

%% Calcula B Externo
for i = 1:length(x) %varre as coordenadas onde B será calculado
    disp(i)
    for j = 1:length(y)
        for k = 1:length(z)
            
            for m = 1:length(phil2)  %varre as coordenadas do condutor externo
                for n = 1:length(rhol2)
                    for o = 1:length(zl2)
                        
                        r = [x(i),y(j),z(k)];  %vetor posição do ponto de campo (onde calculamos B)
                        [rl2(1),rl2(2),rl2(3)] = pol2cart(phil2(m), rhol2(n), zl2(o));
                        
                        if ((r-rl2)*(r-rl2)' > (dx/2)^2) %evitando a divisão por zero, no caso em que r = rl
                            
                            dV = rhol2(n)*dphi*drho*dz;
                            J2_x_rrl = cross(J2, r-rl2);
                            dB2 = ((J2_x_rrl')*dV) / (sqrt((r-rl2)*(r-rl2)')^(3)); %essa é a contribuição dB devida a J
                            
                            B2(:,i,j,k) = B2(:,i,j,k) + dB2;
                        end
                    end
                end
            end
        end
    end
end
B1=(u0/(4*pi))*B1;
B2=(u0/(4*pi))*B2;
B = B1+B2;

%% Plot B
%gráfico vetorial de B no plano XY
[X,Y] = meshgrid(x,y);
figure (1);
quiver(X, Y, squeeze(B(1,:,:,z0))', squeeze(B(2,:,:,z0))'); 
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('B, plano XY (z=0)');

[X,Y] = meshgrid(x,y);
figure (2);
quiver(X, Y, squeeze(B1(1,:,:,z0))', squeeze(B1(2,:,:,z0))'); 
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('B1, plano XY (z=0)');

[X,Y] = meshgrid(x,y);
figure (3);
quiver(X, Y, squeeze(B2(1,:,:,z0))', squeeze(B2(2,:,:,z0))'); 
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('B2, plano XY (z=0)');

%gráfico de By variando em x
figure;
plot(x, B(2,:,y0,z0)); 
xlabel('eixo x')
ylabel('By(x)')
title('By(x)');

%% Calcula W
%calcular a energia magnética Wm por unidade de comprimento
Wm = 0;
for i = 1:length(x) %varre as coordenadas onde Wb será calculado
    disp(i)
    for j = 1:length(y)
        %calculando por unidade comprimento, dz=1
            dW = (1/(2*u0))* dot(B(:,i,j,z0),B(:,i,j,z0));
            Wm = Wm + dW*dx*dy*1;
    end
end
disp(Wm); 

%% Calcula L
%calcular a indutância L
L = (2*Wm)/(I^2);
disp(L);    %A resposta correta é: 0,000000588 H/m.
