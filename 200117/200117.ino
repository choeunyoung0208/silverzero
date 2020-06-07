#include "Balance.h"
Balance BR;

#include <SPI.h>
#include <RF24.h>

bool cnt=0;
int LL=0, RR=0;
int16_t AcX, AcY, AcZ, Tmp, GyX, GyY, GyZ;
float deg=0, deg_p=0, deg_v=0;
int vv=0;

const byte ads1[6] = "YU26A", ads2[6] = "YU26B";
int8_t fb=0, lr=0, fb_p=0;
int nocon=0;
RF24 radio(48,53);


 

void setup() {
Serial.begin(500000); BR.Motor_Init(); BR.Gyro_Init();
attachInterrupt(digitalPinToInterrupt(2), CHA_A, CHANGE);
attachInterrupt(digitalPinToInterrupt(3), CHA_B, CHANGE);
attachInterrupt(digitalPinToInterrupt(18), CHB_B, CHANGE);
attachInterrupt(digitalPinToInterrupt(19), CHB_A, CHANGE);

Serial.begin(500000);
radio.begin(); radio.setChannel(112);
radio.setDataRate(RF24_250KBPS); radio.setRetries(0, 0);
radio.openWritingPipe(ads2); radio.openReadingPipe(1, ads1);
radio.setPALevel(RF24_PA_MAX); radio.startListening();

Timer3.initialize(10000); Timer3.attachInterrupt(tim);
}

void loop() {
if(cnt==1)
{
cnt=0;
BR.Gyro_Get(&AcX, &AcY, &AcZ, &GyX, &GyY, &GyZ);
float deg_acc=atan2(AcX,AcZ)*57.3;
deg=BR.Gfilter(deg_acc,GyY, 3, 0.01);
float deg_d=(deg-deg_p)*100;  deg_p=deg;

char tp[3] = ""; int8_t sw=0;
if(radio.available())
  {radio.read(&tp, sizeof(tp)); fb=-tp[0]; lr=tp[1]; sw=tp[2];
   digitalWrite(5,HIGH);
   if (fb>fb_p+5) {fb=fb_p+5;}    if (fb<fb_p-5) {fb=fb_p-5;}  fb_p=fb;
   }
else { nocon++; if (nocon>20) { nocon=20; fb=0; lr=0; digitalWrite(5,LOW); }  }

int vl=LL, vr=RR;  LL=0; RR=0;
float vdif=abs(vl-vr)-lr*0.8;

deg_v= -(vl+vr) -0.5*fb;



vv=7*deg  +  0.8*deg_d  + 4.5*deg_v;


vv=constrain(vv,-255,255);
BR.Motor(vv+vdif, vv-vdif);

}
}

void CHA_A() {
bool p1=digitalRead(2), p2=digitalRead(3);
if(p1==p2){RR++;}
else {RR--;}
}

void CHA_B() {
bool p1=digitalRead(2), p2=digitalRead(3);
if(p1==p2){RR--;}
else {RR++;}
}

void CHB_A(){
bool p1=digitalRead(18), p2=digitalRead(19);
if(p1==p2){LL--;}
else {LL++;}
}

void CHB_B() {
bool p1=digitalRead(18), p2=digitalRead(19);
if(p1==p2){LL++;}
else {LL--;}
}

void tim() {cnt=1;}
