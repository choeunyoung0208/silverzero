
//4번핀의 상태를 읽고 난 후 4번핀이 켜져있다면 끄고, 꺼져있다면 켜는 프로그램

void setup() {
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
}

void loop() {
  int a;
  a=digitalRead(4); //4번핀의 상태를 읽어 변수 a에 할당.
  if(a==1) {digitalWrite(4, LOW); } //a가 1과 같으면(등호 두개 사용), if문 안에 있는 명령을 실행. 4번핀의 불을 끈다.
  else {digitalWrite(4, HIGH); } //a가 1과 같지 않으면, else문 안에 있는 명령을 실행. 4번핀의 불을 켠다.
  delay(100);
}
