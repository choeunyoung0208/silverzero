//타이머 주기를 0.1s로 고정하면서 불이 깜빡이는 주기를 2s로 바꾸기(2)

#include <TimerThree.h>
int LED=0;

void setup() {
  Serial.begin(250000); 
  pinMode(4, OUTPUT);
  Timer3.initialize(100000);
  Timer3.attachInterrupt(tim);
}

void loop() {
}

void tim() { 
  LED++; // LED=LED+1과 같음
  if (LED>19) {LED=0; digitalWrite(4, !digitalRead(4));}  // !digitalRead(4) : 4번핀의 상태를 읽어서 그 핀의 반대상태를 출력
}
