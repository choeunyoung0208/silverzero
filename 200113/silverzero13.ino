int a=0; //값을 저장하고싶을 때는 전역변수 사용

void setup() {
  Serial.begin(9600);
}

void loop() {
  int b; //지역변수, 중괄호 바깥으로 나가는 순간 없어짐
  a=a+1;
  Serial.print("a="); //" " 안의 글자(a=)를 그대로 PC로 보낸다.
  Serial.print(a); //a라는 변수에 저장된 값을 PC로 보낸다.
  Serial.print(" ");
  Serial.print("b="); //b=을 출력
  Serial.println(b); //b라는 변수에 저장된 값을 출력하고 줄을 바꿈
  b=b+1;
  delay(500); //실행이 된 후 loop문을 나감
}
 
//Serial.print()와 Serial.println() 명령어 : 아두이노에서 PC로 메시지를 보낸다 
