%2)System Solution and Simulation

close all 
%close : 지정된 Figure 제거
%close all은 핸들이 숨겨지지 않은 모든 Figure를 삭제합니다.
clear all
%작업 공간에서 항목을 제거하여 시스템 메모리 늘리기
%clear는 현재 작업 공간에서 모든 변수를 제거하여 시스템 메모리에서 해제합니다.
clc

%Initilization
th_int=[-pi/2 pi/2]; %initial positions
ths=[pi/2 -pi/2]; %set-points => final positions

x0=[0 0 th_int 0 0 0 0]; %states initial values(초기값) 
%초기값을 이용해서 ODE의 상수들(적분상수 같은것들)을 특정값으로 결정해줌

%★★★★★★★★★★★★★★Ts값만 바꿨습니다★★★★★★★★★★★★★★
Ts=0:1.5:30; %time span

%Robot Specifications
L1=1; %link 1
L2=1; %link 2
M1=1; %mass 1
M2=1; %mass 2
spec=[L1 L2 M1 M2];

%PID Parameters
%PID parameters for theta 1
Kp1=15;
Kd1=7;
Ki1=10;
%PID parameters for theta 2
Kp2=15;
Kd2=10;
Ki2=10;

Kpid=[Kp1 Kd1 Ki1 Kp2 Kd2 Ki2];

%ODE solving
%ode45 를 사용해 ODE 풀기
%[t,y] = ode45(odefun,tspan,y0)
%odefun : 풀고싶은 ode함수
%tspan = [t0 tf] &  y0 : t0에서 tf까지의 구간에서 초기 조건 y0을 사용하여 연립미분방정식 y′=f(t,y)를 적분함
%해 배열 y의 각 행은 열 벡터 t에 반환된 값에 대응함

[T, X]=ode45(@(t, x) r2dof(t, x, ths, spec, Kpid), Ts, x0); 
%독립변수가 2개인 r2dof(t, x, ths, spec, Kpid)함수에 대하여 Ts구간에서 초기 조건 x0을 사용하여 ode 풀기

%Output (구하고 싶은 것!)
th1=X(:, 3); %theta1 waveform. 시간 T에 대한 각도1
th2=X(:, 4); %theta2 waveform. 시간 T에 대한 각도2

%torque inputs computation from the 7th, 8th states inside ODE
%힘 F1과 F2를 r2dof.m에서 x'7과 x'8인 미분값으로 정의했으므로, diff(차분) 함수를 사용하여 구하기

%벡터 요소 간의 차분
%Y=diff(X) : X에 대해 차분을 계산함. Y의 요소는 X의 인접 요소 간의 차분결과로 X보다 요소가 하나 더 적게 출력됨
%ex) X=[1 1 2 3 5 8 13 21]에서 Y = diff(X)를 하면 
%결과 : Y=[0  1  1  2  3  5  8]

F1=diff(X(:, 7))./diff(T); %분모와 분자 모두 스칼라가 아닌 벡터이므로 성분별 나눗셈(./) 사용. F1=xdot(7)=X(:, 7)./diff(T)
F2=diff(X(:, 8))./diff(T); %F2=xdot(8)=X(:, 8)./diff(T)
tt=0:(T(end)/(length(F1)-1)):T(end);

%xy
x1=L1*sin(th1); %X1
y1=L1*cos(th1); %Y1
x2=L1*sin(th1)+L2*sin(th1+th2); %X2
y2=L1*cos(th1)+L2*cos(th1+th2); %Y2

%theta1 error plot
plot(T, ths(1)-th1) %x축 : T, y축 : ths(1)-th1
grid;
title('Theta-1 error');
xlabel('time (sec)');
ylabel('theta1 error (rad)');

%theta2 error plot
figure;
plot(T, ths(2)-th2);
grid;
title('Theta-2 error');
xlabel('time (sec)');
ylabel('theta2 error (rad)');

%torque1 plot
figure;
plot(tt, F1);
grid;
title('Torque of theta 1');
xlabel('time (sec)');
ylabel('theta1 torque');

%torque2 plot
figure;
plot(tt, F2);
grid;
title('Torque of theta 2');
xlabel('time (sec)');
ylabel('theta2 torque');
