%1)System ODE function file

%x'=Ax (state equation)
function xdot=r2dof(t, x, ths, spec, Kpid) %x를 제외한 나머지는 A를 구성하는데 필요한 것들

xdot=zeros(8, 1); %x' => xdot

%set-points (final position의 각도)
th1s=ths(1); %원하는 위치의 각도1(theta1) 
th2s=ths(2); %원하는 위치의 각도2(theta2)

%Robot Specifications
L1=spec(1); %로봇 팔 길이1
L2=spec(2); %로봇 팔 길이2
M1=spec(3); %관절1 질량
M2=spec(4); %관절2 질량
g=9.8; %중력가속도

%Inertia Matrix => B(q)행렬
b11=(M1+M2)*L1^2+M2*L2^2+2*M2*L1*L2*cos(x(4));
b12=M2*L2^2+M2*L1*L2*cos(x(4));
b21=M2*L2^2+M2*L1*L2*cos(x(4));
b22=M2*L2^2;
Bq=[b11, b12; b21 b22];

%Centrifugal and Coriolis forces Matrix => C(q', q)행렬
c11= -M2*L1*L2*sin(x(4))*(x(6)^2+2*x(5)*x(6));
c21= -M2*L1*L2*sin(x(4))*x(5)*x(6);
Cq=[c11; c21];

%Gravity Matrix => G(q)행렬
g11=-(M1+M2)*g*L1*sin(x(3))-M2*g*L2*sin(x(3)+x(4));
g21=-M2*g*L2*sin(x(3)+x(4));
Gq=[g11; g21];

%PID Control
%PID parameters for theta 1
Kp1=Kpid(1);
Kd1=Kpid(2);
Ki1=Kpid(3);
%PID parameters for theta 2
Kp2=Kpid(4);
Kd2=Kpid(5);
Ki2=Kpid(6);
%decoupled control input
f1=Kp1*(th1s-x(3))-Kd1*x(5)+Ki1*(x(1));
f2=Kp2*(th2s-x(4))-Kd2*x(6)+Ki2*(x(2));
Fhat=[f1; f2];

F=Bq*Fhat; %actual input to the system

%System states
xdot(1)=(th1s-x(3)); %각도1의 error
xdot(2)=(th2s-x(4)); %각도2의 error

xdot(3)=x(5); %각속도1
xdot(4)=x(6); %각속도2

g2dot=inv(Bq)*(-Cq-Gq+F);
xdot(5)=g2dot(1); %각가속도1
xdot(6)=g2dot(2); %각가속도2

%control input function output to outside computer program
xdot(7)=F(1); 
xdot(8)=F(2);
%x'(7)=F(1), x'(8)=F(2) => 힘들을 미분값으로 정의함!