%% Robot Parcial
%Denavit Hartember_ejer.doc  
close all; clear all; clc
syms q1 q2 q3 q4 real 
L1=0.3; 
L2=0.2; 
L3=1.5; 
L4=1;
L5=0.5;
% Primer robot
% Parámetros de DH del archivo de word
q=[pi/2 -pi/2 0 q1 q2] % los q´s son los titas del video 
d=[L3 L1 L2 0 0]
a=[0 0 0 L4 L5]
alfa=[pi/2 -pi/2 0 0 0]

%%
% Segundo robot
L1=0.3;
L2=0.6;
L3=0.4;
d1=0.3;
q=[0 q1 q2 0] % los q´s son los titas del video 
d=[L1 0 0 d1]
a=[0 L2 L3 0]
alfa=[pi/2 0 pi/2 0]
%%
%Iteracion para el primer robot

i=1;
A01=[cos(q(i)) -cos(alfa(i))*sin(q(i))  sin(alfa(i))*sin(q(i)) a(i)*cos(q(i));...
   sin(q(i))  cos(alfa(i))*cos(q(i)) -sin(alfa(i))*cos(q(i)) a(i)*sin(q(i));...
   0          sin(alfa(i))            cos(alfa(i))           d(i);...
   0 0 0 1]

i=2;
A12=[cos(q(i)) -cos(alfa(i))*sin(q(i))  sin(alfa(i))*sin(q(i)) a(i)*cos(q(i));...
   sin(q(i))  cos(alfa(i))*cos(q(i)) -sin(alfa(i))*cos(q(i)) a(i)*sin(q(i));...
   0          sin(alfa(i))            cos(alfa(i))           d(i);...
   0 0 0 1]

i=3

A23=[cos(q(i)) -cos(alfa(i))*sin(q(i))  sin(alfa(i))*sin(q(i)) a(i)*cos(q(i));...
   sin(q(i))  cos(alfa(i))*cos(q(i)) -sin(alfa(i))*cos(q(i)) a(i)*sin(q(i));...
   0          sin(alfa(i))            cos(alfa(i))           d(i);...
   0 0 0 1]

i=4

A34=[cos(q(i)) -cos(alfa(i))*sin(q(i))  sin(alfa(i))*sin(q(i)) a(i)*cos(q(i));...
   sin(q(i))  cos(alfa(i))*cos(q(i)) -sin(alfa(i))*cos(q(i)) a(i)*sin(q(i));...
   0          sin(alfa(i))            cos(alfa(i))           d(i);...
   0 0 0 1]

i=5
A45=[cos(q(i)) -cos(alfa(i))*sin(q(i))  sin(alfa(i))*sin(q(i)) a(i)*cos(q(i));...
   sin(q(i))  cos(alfa(i))*cos(q(i)) -sin(alfa(i))*cos(q(i)) a(i)*sin(q(i));...
   0          sin(alfa(i))            cos(alfa(i))           d(i);...
   0 0 0 1]

%%
%Iteracion para el segundo robot
i=1;
A01=[cos(q(i)) -cos(alfa(i))*sin(q(i))  sin(alfa(i))*sin(q(i)) a(i)*cos(q(i));...
   sin(q(i))  cos(alfa(i))*cos(q(i)) -sin(alfa(i))*cos(q(i)) a(i)*sin(q(i));...
   0          sin(alfa(i))            cos(alfa(i))           d(i);...
   0 0 0 1]

i=2;
A12=[cos(q(i)) -cos(alfa(i))*sin(q(i))  sin(alfa(i))*sin(q(i)) a(i)*cos(q(i));...
   sin(q(i))  cos(alfa(i))*cos(q(i)) -sin(alfa(i))*cos(q(i)) a(i)*sin(q(i));...
   0          sin(alfa(i))            cos(alfa(i))           d(i);...
   0 0 0 1]

i=3

A23=[cos(q(i)) -cos(alfa(i))*sin(q(i))  sin(alfa(i))*sin(q(i)) a(i)*cos(q(i));...
   sin(q(i))  cos(alfa(i))*cos(q(i)) -sin(alfa(i))*cos(q(i)) a(i)*sin(q(i));...
   0          sin(alfa(i))            cos(alfa(i))           d(i);...
   0 0 0 1]

i=4

A34=[cos(q(i)) -cos(alfa(i))*sin(q(i))  sin(alfa(i))*sin(q(i)) a(i)*cos(q(i));...
   sin(q(i))  cos(alfa(i))*cos(q(i)) -sin(alfa(i))*cos(q(i)) a(i)*sin(q(i));...
   0          sin(alfa(i))            cos(alfa(i))           d(i);...
   0 0 0 1]

%%
% Matriz T para el primer robot
T1=A01*A12*A23*A34*A45

%%
% Matriz T para el segundo robot
T2=A01*A12*A23*A34

%%
% ROBOT 1 Evolucion de la posicion del efector final
q1=0;
q2=-pi/2;
L1=0;
L2=0;
i=1;
while q1<=pi
	while q2<=pi/2
        while L1<=0.3;
            while L2<=0.2;
                Aux=eval(T1);
                % De cada paso toma la posicion:
                x(i)=Aux(1,4); % Eje X
                y(i)=Aux(2,4); % Eje Y
                z(i)=Aux(3,4); % Eje Z
                d1=d1+10;
                i=i+1;
                L2=0;
            end
		q2=q2+0.1;
		L1=0;
	end
	q1=q1+0.1;
	q2=-pi/4;
    end
end
% Print de figuras
clear clc
figure
plot3(x,y,z);grid
title('Graficas en 3D');
hold off
figure
subplot(3,1,1),plot(x,y),title('Grafica ejes XY');
subplot(3,1,2),plot(x,z),title('Grafica ejes XZ');
subplot(3,1,3),plot(y,z),title('Grafica ejes YZ');
hold off

%%
% ROBOT 2 Evolucion de la posicion del efector final (Volumen de trabajo)
q1=0;
q2=-pi/4;
d1=0;
i=1;
while q1<=pi
	while q2<=pi/4
		while d1<=L1;
			Aux=eval(T2);
			% De cada paso toma la posicion:
			x(i)=Aux(1,4); % Eje X
			y(i)=Aux(2,4); % Eje Y
			z(i)=Aux(3,4); % Eje Z
			d1=d1+10;
			i=i+1;
		end
		q2=q2+0.1;
		d1=0;
	end
	q1=q1+0.1;
	q2=-pi/4;
end
figure(1)
plot3(x,y,z);grid
title('Graficas en 3D');
figure(2)
subplot(3,1,1),plot(x,y),title('Grafica ejes XY');
subplot(3,1,2),plot(x,z),title('Grafica ejes XZ');
subplot(3,1,3),plot(y,z),title('Grafica ejes YZ');

