#include <TimerThree.h>
bool LED=0; //int로 선언해도 가능. LED라는 변수 선언.

void setup() {
  Serial.begin(250000); 
  pinMode(4, OUTPUT);
  Timer3.initialize(100000); //0.1s의 주기(LED가 깜빡이는 주기)로 tim함수를 실행. 반복문처럼 사용. 
  Timer3.attachInterrupt(tim);
}

void loop() {
}

void tim() { 
  if(LED==0) //LED의 값이 0일경우, if문 안의 명령어 실행.
  {digitalWrite(4, HIGH); LED=1;} //4번 핀의 불을 켜고, LED를 1로 할당.
  else
  {digitalWrite(4, LOW); LED=0;} //4번 핀의 불을 끄고, LED를 0으로 할당.
}
