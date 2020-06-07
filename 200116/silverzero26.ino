/* Encoder를 이용한 제어
모터의 회전속도를 측정하고 이를 제어에 넣기. 회전속도 측정은 Encoder를 사용해서 측정함.

Encoder를 이용해서 속도를 측정하는 방법(2가지)
1. 펄스의 상태가 바뀌는 시간을 측정(신호처리를 알아야 사용가능) => 단점 : 보정하는게 어려움
2. 일정시간동안 펄스가 몇개 나왔는지 측정(우리가 사용할 것). pinchange interrupt를 사용해서 측정 */

#include <Balance.h>
Balance BR;

void setup() {
  Serial.begin(500000); BR.Motor_Init(); BR.Gyro_Init();

  attachInterrupt(digitalPinToInterrupt(2), CHA_A, CHANGE); /*Interrupt 정의. 위상이 0과 1 두개가 있으므로 핀 두개가 모터 하나에 할당됨
  2번 핀을 Interrput 입력으로 사용하고, Interrupt가 걸렸을 때 cha_a를 사용.(이렇게 설명해주셨어욧...) Interrput 유형으로는 change를 쓴다(change를 사용하면 rigsing falling 둘다 실행 => 클록이 0에서 1로 증가할 때와 클록이 1에서 0으로 감소할 때 둘다 감지하는 것과 비슷)
  2번 핀과 3번 핀 : 모터 하나,  18번 핀과 19번 핀 : 또다른 모터 하나
  CHA_A : channel a 모터의 a위상. 
  CHA_B : channel a 모터의 b위상.
  CHB_A : channel b 모터의 a위상.
  CHB_B : channel b 모터의 b위상. 
  a모터는 오른쪽 모터, b모터는 왼쪽 모터 */
  attachInterrupt(digitalPinToInterrupt(3), CHA_B, CHANGE); //3번 핀
  attachInterrupt(digitalPinToInterrupt(18), CHB_B, CHANGE); //18번 핀
  attachInterrupt(digitalPinToInterrupt(19), CHB_A, CHANGE); //19번 핀
}

void loop() {
  }

void CHA_A () { //Interrupt가 걸렸을 때 출력할 메시지 설정. 이를 통해 모터의 위상을 확인할 수 있음.
    Serial.println("Motor A-A");
    }

void CHA_B () {
    Serial.println("Motor A-B");
}

void CHB_B () {
    Serial.println("Motor B-A");
}

void CHB_A () {
    Serial.println("Motor B-B");
}
