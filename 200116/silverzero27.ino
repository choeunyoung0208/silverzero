//Interrupt를 이용해 바퀴의 회전방향을 측정 

#include <Balance.h>
Balance BR;
int a=0;
int b=0;
bool ccc=0;

void setup() {
  Serial.begin(500000); BR.Motor_Init(); BR.Gyro_Init();
  Timer3.initialize(10000); Timer3.attachInterrupt(tim);

  attachInterrupt(digitalPinToInterrupt(2), CHA_A, CHANGE); //2번핀과 3번핀이 한 개의 모터에 대한 것이고 18번핀과 19번핀이 또다른 모터에 대한 것인데, 위상들을 보고 정방향인지 역방향인지 판단할 수 있다! 
  attachInterrupt(digitalPinToInterrupt(3), CHA_B, CHANGE);
  attachInterrupt(digitalPinToInterrupt(18), CHB_B, CHANGE);
  attachInterrupt(digitalPinToInterrupt(19), CHB_A, CHANGE);
  
  /*CHA_A : A모터(오른쪽 모터..)의 A위상.
  CHA_B : A모터의 B위상.
  CHB_B : B모터(왼쪽 모터)의 B위상.
  CHB_A : B모터의 A위상. 
  A위상과 B위상은 90도 만큼 위상차이가 난다!
  */
  
  
  BR.Motor(-255, -255); //255의 속력으로 전진
}

void loop() {
if(ccc==1) {ccc=0;
  int vl=a, vr=b; a=0; b=0; //vl과 vr에 a와 b값을 저장하자마자 a와 b값을 리셋할 수 있음
  Serial.print(vl); Serial.print(" "); Serial.println(vr);
  //위의 int vl=a, vr=b; a=0; b=0; 명령어 대신 여기에 a=0; b=0;을 해도 a와 b값을 리셋할 수 있긴 하지만 이것보다 위에 했던것이 더 좋은 명령어!
  }
}

void CHA_A () {
  bool p1 = digitalRead(2), p2 = digitalRead(3);
  if (p1 == p2) { //p1과 p2의 값이 같을때 역방향
    a++;
  }
  else { //p1과 p2의 값이 다를때 정방향
    a--;
  }
}

void CHA_B () {
  bool p1 = digitalRead(2), p2 = digitalRead(3);
  if (p1 == p2) { //p1과 p2의 값이 같을때 정방향 (-가 앞으로 가는 방향이에요!)
    a--;
  }
  else { //p1과 p2의 값이 다를때 역방향
    a++;
  }
}

void CHB_A () {
  bool p1 = digitalRead(18), p2 = digitalRead(19);
  if (p1 == p2) { 
    b--;
  }
  else {
    b++;
  }
}

void CHB_B () {
  bool p1 = digitalRead(18), p2 = digitalRead(19);
  if (p1 == p2) {
    b++;
  }
  else {
    b--;
  }
}

/* 
위상의 진행방향이 왼쪽에서 오른쪽으로 진행하는 것이 정방향, 오른쪽에서 왼쪽으로 진행하는 것이 역방향.
그리고, (이건 확실하진 않은데.. 저는 이렇게 들었던 거 같아요..!!) pulse가 0->1 또는 1->0 으로 변할때 마다 다른 위상의 값과 비교.
ex) CHA_A에서는, 
A모터의 A위상 값이 0->1 또는 1->0으로 변할때 마다 그 순간  B위상의 값을 확인해서 비교 */

void tim() { ccc=1; 
}

//계속 수정해서 죄송합니다....ㅎ.ㅎ... 뭔가 이거 같아용~~!
