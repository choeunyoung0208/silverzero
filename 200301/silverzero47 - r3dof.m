%1)System ODE function file

%x'=Ax (state equation)
function xdot=r3dof(t, x, ths, spec, Kpid) %x를 제외한 나머지는 A를 구성하는데 필요한 것들

xdot= zeros(12, 1); %x' => xdot

%set-points (final position의 각도)
th1s= ths(1); %원하는 위치의 각도1(theta1) 
th2s= ths(2); %원하는 위치의 각도2(theta2)
th3s= ths(3); %원하는 위치의 각도3(theta3)

%Robot Specifications
L1= spec(1); %로봇 팔 길이1
L2= spec(2); %로봇 팔 길이2
L3= spec(3); %로봇 팔 길이3
M1= spec(4); %관절1 질량
M2= spec(5); %관절2 질량
M3= spec(6); %관절3 질량
g= 9.8; %중력가속도

%Inertia Matrix => B(q)행렬
b11= (M1+M2+M3)*L1^2+2*(M2+M3)*L1*L2*cos(x(5))+(M2+M3)*L2^2+M3*L3^2+2*M3*L2*L3*cos(x(6))+2*M3*L1*L3*cos(x(5)-x(6));
b12= (M2+M3)*L1*L2*cos(x(5))+(M2+M3)*L2^2+M3*L3^2+2*M3*L2*L3*cos(x(6))+M3*L1*L3*cos(x(5)-x(6));
b13= -M3*L3^2+M3*L2*L3*cos(x(6))-M3*L1*L3*cos(x(5)-x(6));
b21= (M2+M3)*L1*L2*cos(x(5))+(M2+M3)*L2^2+M3*L3^2+2*M3*L2*L3*cos(x(6))+M3*L1*L3*cos(x(5)-x(6));
b22= (M2+M3)*L2^2+M3*L3^2+2*M3*L2*L3*cos(x(6));
b23= -M3*L3^2-M3*L2*L3*cos(x(6));
b31= -M3*L2*L3*cos(x(6))-M3*L1*L3*cos(x(5)-x(6));
b32= -M3*L3^2-M3*L2*L3*cos(x(6));
b33= M3*L3^2;
Bq= [b11 b12 b13; b21 b22 b23; b31 b32 b33];

%Centrifugal and Coriolis forces Matrix => C(q', q)행렬
c11= -(M2+M3)*L1*L2*sin(x(5)).*(x(8).^2+2*x(7).*x(8))-M3*L2*L3*sin(x(6)).*(-x(9).^2+2*x(7).*x(9)+2*x(8).*x(9))-M3*L1*L3*sin(x(5)-x(6)).*(x(8).^2-x(9).^2+2*x(7).*x(8)-2*x(8).*x(9)-2*x(9).*x(7));
c21= -(M2+M3)*L1*L2*sin(x(5)).*x(7).*x(8)-M3*L2*L3*sin(x(6)).*(-x(9).^2+2*x(7).*x(9)+2*x(8).*x(9))-M3*L1*L3*sin(x(5)-x(6)).*(x(7).*x(8)-x(7).*x(9))+(M2+M3)*L1*L2*sin(x(5)).*(x(7).^2+x(7).*x(8))+M3*L1*L3*sin(x(5)-x(6)).*(x(7).^2+x(7).*x(8)-x(9).*x(7));
c31= M3*L2*L3*sin(x(6)).*(x(7).*x(9)+x(8).*x(9))+M3*L1*L3*sin(x(5)-x(6)).*(x(7).*x(8)-x(7).*x(9))+M3*L2*L3*sin(x(6)).*(x(7).^2+x(8).^2+2*x(7).*x(8)-x(8).*x(9)-x(9).*x(7))-M3*L1*L3*sin(x(5)-x(6)).*(x(7).^2+x(7).*x(8)-x(9).*x(7));
Cq=[c11; c21; c31];

%Gravity Matrix => G(q)행렬
g11= M1*g*L1*cos(x(4))+M2*g*(L1*cos(x(4))+L2*cos(x(4)+x(5)))+M3*g*(L1*cos(x(4))+L2*cos(x(4)+x(5))+L3*cos(x(6)-(x(4)+x(5))));
g21= M2*g*L2*cos(x(4)+x(5))+M3*g*L2*cos(x(4)+x(5))+M3*g*L3*cos(x(6)-(x(4)+x(5)));
g31= -M3*g*L3*cos(x(6)-(x(4)+x(5)));
Gq= [g11; g21; g31];

%PID Control
%PID parameters for theta 1
Kp1=Kpid(1);
Kd1=Kpid(2);
Ki1=Kpid(3);
%PID parameters for theta 2
Kp2=Kpid(4);
Kd2=Kpid(5);
Ki2=Kpid(6);
%PID parameters for theta 3
Kp3=Kpid(7);
Kd3=Kpid(8);
Ki3=Kpid(9);
%decoupled control input
f1=Kp1*(th1s-x(4))-Kd1*x(7)+Ki1*(x(1));
f2=Kp2*(th2s-x(5))-Kd2*x(8)+Ki2*(x(2));
f3=Kp3*(th3s-x(6))-Kd3*x(9)+Ki3*(x(3));
Fhat=[f1; f2; f3];

F=Bq*Fhat; %actual input to the system

%System states
xdot(1)=(th1s-x(4)); %각도1의 error
xdot(2)=(th2s-x(5)); %각도2의 error
xdot(3)=(th3s-x(6)); %각도3의 error

xdot(4)=x(7); %각속도1
xdot(5)=x(8); %각속도2
xdot(6)=x(9); %각속도3

g2dot=inv(Bq)*(-Cq-Gq+F);
xdot(7)=g2dot(1); %각가속도1
xdot(8)=g2dot(2); %각가속도2
xdot(9)=g2dot(3); %각가속도3

%control input function output to outside computer program
xdot(10)=F(1); 
xdot(11)=F(2);
xdot(12)=F(3);
%x'(10)=F(1), x'(11)=F(2), x'(12)=F(3) => 힘들을 미분값으로 정의함!