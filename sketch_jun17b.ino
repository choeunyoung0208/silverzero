#include <ESP8266WiFi.h>       // ESP8266 NodeMCU를 사용하여 데이터 통신
#include <Adafruit_NeoPixel.h> // LED
#include <SPI.h>               // LED

// 연결할 wifi 이름과 비밀번호를 설정한다
const char* ssid = "AndroidHotspot4747";
const char* password = "12344321";

WiFiServer server(12345);// 포트 번호 설정(12345는 임의로 설정한 값)

// LED 
#define PIN            14    // GPIO 14(NodeMCU), LED(날씨에 따라 다른 색으로 출력)
#define STRIPSIZE      26    // LED 개수       
Adafruit_NeoPixel strip = Adafruit_NeoPixel(STRIPSIZE, PIN, NEO_GRB + NEO_KHZ800);

int PUMP = 4;               // GPIO 4(NodeMCU), 펌프(비 내리는 효과)
int Cloud = 5;              // GPIO 5(NodeMCU), 가습기(구름, 안개 효과)
int weather = 0;            // 데이터 통신으로 받아온 값을 저장할 변수

//★★NodeMCU 처음 구동시 or 리셋 버튼 누를시 한 번만 실행되는 함수★★
void setup() {
  // LED, 가습기, 펌프 초기 설정
  strip.begin();
  strip.setBrightness(120);
  strip.show();
  pinMode(Cloud,OUTPUT);          // 가습기 핀 출력 설정
  pinMode(PUMP,OUTPUT);           // 펌프 핀 출력 설정
  Rain_PUMP(0);                   // 펌프 출력 LOW
  Cloud_PUMP(0);                  // 가습기 출력 LOW
  
  Serial.begin(115200);           // 시리얼통신을 설정한다
  delay(10);
 
  // 연결할 wifi를 출력한다
  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);     // 미리 설정된 wifi에 연결을 시도한다

  // wifi연결을 대기하는 동안 ...을 출력한다
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  // wifi가 연결되었다고 출력한다
  Serial.println("");
  Serial.println("WiFi connected");

  // server 역할을 시작한다
  server.begin();
  Serial.println("Server started");

  // 현재 ip를 출력한다
  Serial.print("Use this URL to connect: ");
  Serial.print("http://");
  Serial.print(WiFi.localIP());
  Serial.println("/");
}

//★★실제 구동 함수(setup 함수 실행 이후 계속 반복해서 실행되는 함수)★★
void loop() {
  WiFiClient client=server.available();               // 연결을 요청한 client가 있는지 확인

  if (!client) {                                      // client가 연결되지 않은 경우
    Serial.println("connection waiting");             // 서버 접속에 실패했음을 출력
    return;
  }
  else
  {
    while(client.connected()){                        // client가 연결된 경우
      
      if(client.available()){
         String recevbline= client.readString();      // client가 전송한 data를 읽음
         Serial.println(recevbline);                  // 받은 데이터를 시리얼 모니터에 출력
         weather = recevbline.substring(0,3).toInt(); // 받은 데이터의 데이터타입을 정수형으로 변환
         Animation();                                 // weather 값에 따라 LED, 가습기, 펌프를 제어하는 함수 실행 
      }
    }
  }
}

//★★weather 값에 따라 LED, 가습기, 펌프를 제어하는 함수★★
// weather 값 범위 : 200 ~ 804 (weather 값에 따른 날씨 구분 : 날씨 데이터를 받아오는 데 사용한 사이트 https://openweathermap.org/weather-conditions 참조)
void Animation()
{
  //뇌우
  if(weather <= 232 && weather >= 200)
  {
    Serial.print("Lightening Rain(뇌우, 깜빡임 + 보라색)");
    Rain_PUMP(1);        // 펌프 구동 O
    Lightening_LED();    // LED 깜빡임 + 보라색
    Cloud_PUMP(0);       // 가습기 구동 X
  }
  
  //약한 비
  else if(weather <= 321 && weather >= 300)
  {
    Serial.print("Light Rain(약한 비, 파란색)");
    Rain_PUMP(1);        // 펌프 구동 O
    Light_Rainy_LED();   // LED 파란색
    Cloud_PUMP(1);       // 가습기 구동 O
  }

  //눈 오는 날
  else if(weather <= 622 && weather >= 600)
  {
    Serial.print("White snow(눈 오는 날, 흰색)");
    Rain_PUMP(1);       // 펌프 구동 O
    Snowy_LED();        // LED 흰색
    Cloud_PUMP(0);      // 가습기 구동 X
  }

  //안개 낀 날
  else if(weather <= 721 && weather >= 701 || (weather == 741))
  {
    Serial.print("Fog(안개 낀 날, LED 출력 없음)"); 
    Rain_PUMP(0);                   // 펌프 구동 X
    LED_ON(strip.Color(0, 0, 0));   // LED 출력 X
    Cloud_PUMP(1);                  // 가습기 구동 O
  }

  //구름 낀 날
  else if((weather == 731) || (weather == 751) || (weather == 761) || (weather == 781))
  {
    Serial.print("Dark Cloudy(구름 낀 날, 보라색)");
    Rain_PUMP(0);       // 펌프 구동 X
    Cloudy_LED();       // LED 보라색
    Cloud_PUMP(0);      // 가습기 구동 X
  }

  //맑은 날
  else if(weather <= 804 && weather >= 800)
  {
    Serial.print("General Cloud(맑은 날, 노란색)");
    Rain_PUMP(0);       // 펌프 구동 X
    Fine_LED();         // LED 노란색
    Cloud_PUMP(0);      // 가습기 구동 X
  }
}

//★★LED 출력 함수★★
void LED_ON(uint32_t c)           
{
  for(uint16_t i=0; i<strip.numPixels(); i++) {
      strip.setPixelColor(i, c);
      strip.show();
  }
}

//★★날씨에 따른 LED 출력 색 설정★★
void Fine_LED()                       // '맑은 날' LED 출력 (노란색)
{
  LED_ON(strip.Color(255, 228, 0));
}

void Cloudy_LED()                     // '구름 낀 날' LED 출력 (회색)
{
  LED_ON(strip.Color(102, 0, 153));
}

void Snowy_LED()                      // '눈 오는 날' LED 출력 (흰색)
{
  LED_ON(strip.Color(255, 255, 255));
}

void Light_Rainy_LED()                // '약한 비' LED 출력 (파란색)
{
 LED_ON(strip.Color(0, 51, 102));
}

void Lightening_LED()                 // '뇌우' LED 출력 (깜빡임 + 회색)
{
  int i;
  while(1){                           // 무한 반복
    for(i=0;i<15;i++)
    {
      LED_ON(strip.Color(102, 0, 153));
      delay(10);
      LED_ON(strip.Color(0, 0, 0));
      delay(5);
    }
    for(i=0;i<5;i++)
    {
      LED_ON(strip.Color(102, 0, 153));
      delay(500);
      LED_ON(strip.Color(0, 0, 0));
      delay(100);
    } 
    for(i=0;i<8;i++)
    {
      LED_ON(strip.Color(102, 0, 153));
      delay(1000);
      LED_ON(strip.Color(0, 0, 0));
      delay(50);
    }
  }
}

//★★가습기 구동 함수★★
void Cloud_PUMP(byte state)           
{
  if(state == 1){digitalWrite(Cloud,HIGH);}     // state가 1이면 가습기 구동 O
  else if(state == 0){digitalWrite(Cloud,LOW);} // state가 0이면 가습기 구동 X
}

//★★펌프 구동 함수★★
void Rain_PUMP(byte state)            
{
  if(state == 1){digitalWrite(PUMP,HIGH);}      // state가 1이면 펌프 구동 O
  else if(state == 0){digitalWrite(PUMP,LOW);}  // state가 0이면 펌프 구동 X
}
