//★ 제일 중요한 부분 ★ 
// 각속도를 이용한 각도 구하기, 가속도를 이용한 각도 구하기

#include "Balance.h" // 헤더파일 불러옴

Balance BR; // Balance에 내장된 애를 BR로 둠

bool ccc=0; // bool형 변수 ccc를 선언
float deg=0; // float형 변수 deg를 선언
int16_t AcX, AcY, AcZ, Tmp, GyX, GyY, GyZ; // 16비트 정수형 변수들을 선언

void setup() {
  BR.Motor_Init(); BR.Gyro_Init(); Serial.begin(500000);
  Timer3.initialize(10000); Timer3.attachInterrupt(tim);
}

void loop() {
  if (ccc==1) {ccc=0;
  BR.Gyro_Get(&AcX, &AcY, &AcZ, &GyX, &GyY, &GyZ); // AcX, AcY,..., GyZ에 자이로센서로부터 얻은 값을 저장함. '&' 필수!

  //가속도를 이용한 각도 구하기
  float ang=atan2(AcX, AcZ); // 각도는 float형으로 선언. atan2 : arctangent. 결과값은 라디안 단위로 나옴. 90도일 때 라디안 값은 1.57로 나옴

  //각속도를 이용한 각도 구하기
  deg=deg-GyY*0.01/32.8; /* 구분구적법을 이용하여 적분하기. 
  dx(밑변)*dy(높이=측정값)인데, 
  dx=0.01로 일정(tim의 주기 0.01마다 dy값이 관측되므로 tim주기인 0.01이 dx가 됨).
  y축을 중심으로 회전하기 때문에 GyY값이 dy(측정값)이다. 따라서 GyY를 적분해야된다.
  그리고, 아두이노에서의 각도와 실제 각도는 다르기 때문에 구한 값에 32.8을 나눠줘야 실제 각도가 나온다. 또한 방향이 반대로 출력되므로 -를 곱해줘야된다. */
  Serial.print(deg); Serial.print(" "); // 각속도를 이용한 각도 출력
  Serial.println(ang*57.3);}  // 가속도를 이용한 각도 출력. ang에 57.3을 곱하면 도(degree)단위로 출력된다.
}

void tim() { ccc=1; 
}
