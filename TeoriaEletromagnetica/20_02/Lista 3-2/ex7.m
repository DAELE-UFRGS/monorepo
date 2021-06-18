%% Questão 7
% A corrente de um antena filamentar do tipo dipolo elétrico pode ser representada por
% Onde ? é a frequência angular (? = 2?f), l é o comprimento do diplo sendo l = ?0/2
% sendo ?0 o comprimento de uma onda com frequência f se propagando no espaço livre ?0=c/f e k = 2?/?0.
% Considere que a fonte conectada na antena é ligada no instante t = 0, de forma que para t < 0 I = 0,
% B =0 e E =0. A partir de t >=0 a corrente é dada pela equação acima.
% Determine numericamente, em todo o espaço e para qualquer t >=0, o potencial vetorial A,
% a densidade de fluxo magnético B e a intensidade de campo elétrico E .
% Faça representações gráficas de A, B e E em um plano que contenha o dipolo e em um
% plano ortogonal ao dipolo.
% Observe que nesse caso como a corrente depende da coordenada z a antena não será elétricamente
% neutra (vide equação da continuidade). Assim, V não pode ser considerado nulo.
% Para o cálculo de E recomendo a integração no tempo da lei de Ampère (com a correção de Maxwell)

%% Variáveis Dadas
clc
clear all
close all

e0 = 8.854*10^(-12);
u0 = 4*pi*10^(-7);
c = 3*10^(8); %v. da luz

I0 = 1; %corrente
f=20*10^9;  %Frequencia

per=1/f;
lamb = c/f;
L = lamb/2;
k = 2*pi/lamb;
w = 2*pi*f;

%% Variáveis Criadas
lim = 2*lamb;
passo = lamb/10; % passo

dx = passo;
dy = passo;
dz = passo;

x= -lim:dx:lim; %variacao da coordenada x
y= -lim:dy:lim; %variacao da coordenada y
z= -lim:dz:lim; %variacao da coordenada z

%antena
zl = [-L/2:dz:L/2];

%variação de tmepo
dt = per/20;
t = 0:dt:2*per;

xmedio = ceil(length(x)/2);
ymedio = ceil(length(y)/2);
zmedio = ceil(length(z)/2);
tmedio = ceil(length(t)/2);

xn = (x(2:end-1));
yn = (y(2:end-1));
zn = (z(2:end-1));
tn = (t(2:end-1));

xmedio2 = ceil(length(xn)/2);
ymedio2 = ceil(length(yn)/2);
zmedio2 = ceil(length(zn)/2);
tmedio2 = ceil(length(tn)/2);

xnn = (xn(2:end-1));
ynn = (yn(2:end-1));
znn = (zn(2:end-1));

xmedio3 = ceil(length(xnn)/2);
ymedio3 = ceil(length(ynn)/2);
zmedio3 = ceil(length(znn)/2);

%% Descobrindo valor do campo A
%zerando a densidade de fluxo magnético
A = zeros(3, length(x), length(y), length(z), length(t));

for p = 1:length(t)
    disp(p)
    for i = 1:length(x)
        for j = 1:length(y)
            for k = 1:length(z)
                
                r = [x(i),y(j),z(k)];  %vetor posiÃ§Ã£o do ponto de campo (onde calculamos B)
                dL = dz;
                
                for u = 1:length(zl)
                    
                    rl = [0,0,zl(u)];
                    modulo = norm(r-rl);
                    
                    
                    if  ((t(p)- modulo/c) > 0)
                        
                        if  (zl(u) >= 0)
                            Ir = [0,0,I0*sin(w*(t(p)- modulo/c))*sin(k*(L/2-zl(u)))];
                        else
                            Ir = [0,0,I0*sin(w*(t(p)- modulo/c))*sin(k*(L/2+zl(u)))];
                        end
                        
                        dA = (Ir) /modulo;
                        A(1,i,j,k,p) = A(1,i,j,k,p) + dA(1)*dL;
                        A(2,i,j,k,p) = A(2,i,j,k,p) + dA(2)*dL;
                        A(3,i,j,k,p) = A(3,i,j,k,p) + dA(3)*dL;
                    end
                    
                end
            end
        end
    end
end
A = ( u0/(4*pi) ) * A;

%% Plot A
%gráfico vetorial de A no plano XY
[X,Y] = meshgrid(x,y);
figure (1);
quiver(X, Y, squeeze(A(1,:,:,zmedio,tmedio))', squeeze(A(2,:,:,zmedio,tmedio))');
hold
contour(x,y,squeeze(A(3,:,:,zmedio,tmedio))');
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('A, plano XY (z=0)');

%gráfico vetorial de A no plano YZ
[Y,Z] = meshgrid(y,z);
figure (2);
quiver(Y, Z, squeeze(A(2,xmedio,:,:,tmedio))', squeeze(A(3,xmedio,:,:,tmedio))');
xlabel('eixo y (m)')
ylabel('eixo z (m)')
title('A, plano YZ (x=0)');

%gráfico vetorial de A no plano XZ
[X,Z] = meshgrid(x,z);
figure (3);
quiver(X, Z, squeeze(A(1,:,ymedio,:,tmedio))', squeeze(A(3,:,ymedio,:,tmedio))');
xlabel('eixo x (m)')
ylabel('eixo z (m)')
title('A, plano XZ (y=0)');

%% Calculo de B a partir do rotacional de A
% rotacional de A
%Zerando densidades de corrente ligadas
B  = zeros (3,length(xn),length(yn),length(zn),length(t));

%rot M = (dAz/dy-dAy/dz) ax + (dAx/dz-dAz/dx) ay + (dAy/dx-dAx/dy) az
for p = 1:length(t)
    disp(p);
    for i = 2:length(x)-1
        for j = 2 :length(y)-1
            for k = 2: length(z)-1
                
                dAz_dy= (A(3,i,j+1,k,p)-A(3,i,j-1,k,p))/2/dy; %derivada de Az em relação a y
                dAy_dz = (A(2,i,j,k+1,p)-A(2,i,j,k-1,p))/2/dz; %derivada de Ay em relação a z
                
                dAx_dz=(A(1,i,j,k+1,p)-A(1,i,j,k-1,p))/2/dz; %derivada de Ax em relação a z
                dAz_dx=(A(3,i+1,j,k,p)-A(3,i-1,j,k,p))/2/dx;%derivada de Az em relação a x
                
                dAy_dx=(A(2,i+1,j,k,p)-A(2,i-1,j,k,p))/2/dx; %derivada de Ay em relação a x
                dAx_dy=(A(1,i,j+1,k,p)-A(1,i,j-1,k,p))/2/dy;%derivada de Ax em relação a y
                
                B(1,i-1,j-1,k-1,p) = dAz_dy-dAy_dz; %a componente x de B é dAz_dy-dAy_dz
                B(2,i-1,j-1,k-1,p) = dAx_dz-dAz_dx;%a componente y de B é dAx_dz-dAz_dx
                B(3,i-1,j-1,k-1,p) = dAy_dx-dAx_dy;%a componente z de B é dAy_dx-dAx_dy
                
            end
        end
    end
end

%% Plot B
%gráfico vetorial de B no plano XY
[X,Y] = meshgrid(xn,yn);
figure (4);
quiver(X, Y, squeeze(B(1,:,:,zmedio2,tmedio))', squeeze(B(2,:,:,zmedio2,tmedio))');
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('B, plano XY (z=0)');

%gráfico vetorial de B no plano YZ
[Y,Z] = meshgrid(yn,zn);
figure (5);
quiver(Y, Z, squeeze(B(2,xmedio2,:,:,tmedio))', squeeze(B(3,xmedio2,:,:,tmedio))');
xlabel('eixo y (m)')
ylabel('eixo z (m)')
title('B, plano YZ (x=0)');

%gráfico vetorial de A no plano XZ
[X,Z] = meshgrid(xn,zn);
figure (6);
quiver(X, Z, squeeze(B(1,:,ymedio2,:,tmedio))', squeeze(B(3,:,ymedio2,:,tmedio))');
xlabel('eixo x (m)')
ylabel('eixo z (m)')
title('B, plano XZ (y=0)');

%% Calculo de E a partir da derivada negativa de A e Grad(V)
%E=-Grad(V)-dA/dt #GRANDE LORENTZ
%Zerando densidades de corrente ligadas
E = zeros (3,length(xnn),length(ynn),length(znn),length(tn));

% CALCULO DERIVADA A
derA = zeros (3,length(xnn),length(ynn),length(znn),length(tn));
for p = 2:length(t)-1
    disp(p);
    for i = 3:length(x)-2
        for j = 3:length(y)-2
            for k = 3:length(z)-2
                
                dAx_dt= (A(1,i,j,k,p+1)-A(1,i,j,k,p-1))/(2*dt); %derivada de Ax em relação a t
                dAy_dt= (A(2,i,j,k,p+1)-A(2,i,j,k,p-1))/(2*dt); %derivada de Ay em relação a t
                dAz_dt= (A(3,i,j,k,p+1)-A(3,i,j,k,p-1))/(2*dt); %derivada de Az em relação a t
                
                derA(1,i,j,k,p-1) = dAx_dt;
                derA(2,i,j,k,p-1) = dAy_dt;
                derA(3,i,j,k,p-1) = dAz_dt;
                
            end
        end
    end
end

%Divergente A
divA = zeros (length(xnn),length(ynn),length(znn),length(tn));
%Div M = (dAx/dx+dAy/dy+dAz/dz)
for p = 2:length(t)-1
    disp(p);
    for i = 2:length(x)-1
        for j = 2 :length(y)-1
            for k = 2: length(z)-1
                
                dAx_dx = (A(1,i+1,j,k,p)-A(1,i-1,j,k,p))/2/dx; %derivada de Az em relação a x
                dAy_dy = (A(2,i,j+1,k,p)-A(2,i,j-1,k,p))/2/dy; %derivada de Az em relação a y
                dAz_dz = (A(3,i,j,k+1,p)-A(3,i,j,k-1,p))/2/dz; %derivada de Ay em relação a z
                
                divA(i-1,j-1,k-1,p) = dAx_dx+dAy_dy+dAz_dz; %a componente x de B é dAz_dy-dAy_dz
                
            end
        end
    end
end
divA = -divA/(u0*e0);

%CALCULO V    %Integral no tempo
V = zeros (length(xn),length(yn),length(zn),length(tn));
for p = 1:length(tn)
    disp(p);
    for i = 1:length(xn)
        for j = 1:length(yn)
            for k = 1:length(zn)
                
                V(i,j,k,p) = V(i,j,k,p) + divA(i,j,k,p)*dt;
                
            end
        end
    end
end

%GRADIENTE V
gradV = zeros (3,length(xnn),length(ynn),length(znn),length(tn));
for p = 1:length(tn)
    disp(p);
    for i = 2:length(xn)-1
        for j = 2 :length(yn)-1
            for k = 2: length(zn)-1
                
                dV_dx = (V(i+1,j,k,p)-V(i-1,j,k,p))/2/dx; %derivada de V em relação a x
                dV_dy = (V(i,j+1,k,p)-V(i,j-1,k,p))/2/dy; %derivada de V em relação a y
                dV_dz = (V(i,j,k+1,p)-V(i,j,k-1,p))/2/dz; %derivada de V em relação a z
                
                gradV(:,i-1,j-1,k-1,p) = [dV_dx,dV_dy,dV_dz]; %a componente x de B é dAz_dy-dAy_dz
                
            end
        end
    end
end

%% Calcula E
for p = 1:length(tn)
    disp(p);
    for i = 1:length(xnn)
        for j = 1:length(ynn)
            for k = 1: length(znn)
                
                E(:,i,j,k,p) = -gradV(:,i,j,k,p) - derA(:,i,j,k,p);
                
            end
        end
    end
end


%% Plot E
%gráfico vetorial de E no plano XY
[X,Y] = meshgrid(xnn,ynn);
figure (7);
quiver(X, Y, squeeze(E(1,:,:,zmedio3,tmedio2))', squeeze(E(2,:,:,zmedio3,tmedio2))');
xlabel('eixo x (m)')
ylabel('eixo y (m)')
title('E, plano XY (z=0)');

%gráfico vetorial de E no plano YZ
[Y,Z] = meshgrid(ynn,znn);
figure (8);
quiver(Y, Z, squeeze(E(2,xmedio3,:,:,tmedio2))', squeeze(E(3,xmedio3,:,:,tmedio2))');
xlabel('eixo y (m)')
ylabel('eixo z (m)')
title('E, plano YZ (x=0)');

%gráfico vetorial de A no plano XZ
[X,Z] = meshgrid(xnn,znn);
figure (9);
quiver(X, Z, squeeze(E(1,:,ymedio3,:,tmedio2))', squeeze(E(3,:,ymedio3,:,tmedio2))');
xlabel('eixo x (m)')
ylabel('eixo z (m)')
title('E, plano XZ (y=0)');
