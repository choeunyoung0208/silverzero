//silverzero15 의 코드와 비교

//Timer를 쓰면 delay를 쓰지 않고 불을 깜빡일 수 있고, Timer를 쓰지 않고 loop를 이용해 LED 불을 깜빡이면 delay를 사용해야됨.
//delay()의 괄호 안 단위는 millisecond
//delay를 사용하면 다른 프로그램을 실행하는데 제약이 있음. 
//ex) delay(500)인 경우, 500ms동안 프로그램은 아무 것도 못 함. (쉽게 말하면 delay를 쓰면 멀티가 안된다!!)

//따라서, delay를 안 쓸수록 좋은 프로그램.

void setup() {
  pinMode(4, OUTPUT);
}

void loop() {
  digitalWrite(4,HIGH); delay(500); //불을 켜고 난 후, 500ms동안 아무일도 안 함
  digitalWrite(4,LOW); delay(500);
}
