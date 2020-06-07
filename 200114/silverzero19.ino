#include <Wire.h> // I2C 통신을 사용하겠다는 뜻
int16_t AcX, AcY, AcZ, Tmp, GyX, GyY, GyZ; // Ac : 가속도, Gy : 각속도, Tmp : 온도, AcX : x방향의 가속도, GyX : x방향의 각속도 

void setup(){
  Serial.begin(250000);
  Wire.begin(); Wire.setClock(400000);
  Wire.beginTransmission(0x68); // 자이로센서 이름이 0x68(16진수 68번)인것을 부르는거 (이 이후로 전송 시작됨)
  Wire.write(0x6B); Wire.write(0); // 레지스터 0x6B를 0으로 바꿔라(=초기화)
  Wire.endTransmission(true); // true : 통신을 끝냄
}

void loop() {
  Wire.beginTransmission(0x68);// 자이로센서 이름이 0x68(16진수 68번)인것을 부르는거 (이 이후로 전송 시작됨)
  Wire.write(0x3B); // 레지스터 0x3B 부터 8비트씩 저장 
  Wire.endTransmission(false);
  Wire.requestFrom(0x68, 14, true); // 자이로센서 이름이 0x68(16진수 68번)에서 14개의 데이터 값을 받아오라는 뜻
  AcX=Wire.read()<<8 | Wire.read(); // 여기서부터
  AcY=Wire.read()<<8 | Wire.read();
  AcZ=Wire.read()<<8 | Wire.read();
  Tmp=Wire.read()<<8 | Wire.read();
  GyX=Wire.read()<<8 | Wire.read();
  GyY=Wire.read()<<8 | Wire.read();
  GyZ=Wire.read()<<8 | Wire.read(); /* 여기까지 : 자이로 센서로부터 7개의 데이터(AcX, AcY, ...)에다 정보를 가져온다. => 아두이노에서는 8비트로 통신하기때문에 Wire.read() 명령어를 쓰면 한 번에 8비트를 받을 수 있음. 
  8비트로 두번 받아서 하나의 16비트 값으로 합치는 구문(첫번째로 불러온 8비트는 왼쪽으로 8비트 만큼 shifting후 8비트 추가) 
  컴퓨터구조에서 배운거랑 비슷함 */
  Serial.print(AcX); Serial.print(" ");
  Serial.print(AcY); Serial.print(" ");
  Serial.print(AcZ); Serial.print(" ");
  Serial.print(GyX); Serial.print(" ");
  Serial.print(GyY); Serial.print(" ");
  Serial.println(GyZ); delay(100);
}
