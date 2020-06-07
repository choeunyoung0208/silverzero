//PWM 프로그래밍 실습
// 2초동안 정방향으로 250의 속도 -> 1초동안 정방향으로 120의 속도 -> 1초동안 역방향으로 120의 속도 -> 2초동안 정방향으로 250의 속도 -> 2초동안 좌회전 -> 2초동안 우회전을 순차적으로 동작하는 프로그램 작성

//아두이노의 파란색 LED가 켜지는 곳이 앞쪽

#include "Balance.h"
Balance BR;

void setup() {
  BR.Motor_Init();
}

void loop() {
  BR.Motor(-250, -250);
  delay(2000);
  BR.Motor(-120, -120);
  delay(1000);
  BR.Motor(120, 120);
  delay(1000);
  BR.Motor(-250, -250);
  delay(2000);
  BR.Motor(250, -250);
  delay(2000);
  BR.Motor(-250, 250);
  delay(2000);
}
