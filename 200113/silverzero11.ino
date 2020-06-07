void setup() {
  //pinMode(핀 번호, INPUT or OUTPUT) : 선택한 핀을 입력이나 출력으로 사용함
  //4번핀이 녹색, 5번핀이 적색
  pinMode(4, OUTPUT); 
  pinMode(5, OUTPUT);
}

void loop() {
  digitalWrite(4, HIGH); // HIGH : 1(켜는거), LOW : 0(끄는거) 
  digitalWrite(5, LOW);
  delay(500);
  digitalWrite(4, LOW);
  digitalWrite(5, HIGH);
  delay(500);
}
