#include "Balance.h"
Balance BR;

void setup() {
  BR.Motor_Init();
}

void loop() {
  BR.Motor(-25, 25); /* -255와 255 : 모터의 속도. 
  모터의 속도 범위는 [-255, 255] 까지 가능 */
  delay(100);
}
