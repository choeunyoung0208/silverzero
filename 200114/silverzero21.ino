#include "Balance.h"
Balance BR;
bool cnt=0;
int16_t AcX, AcY, AcZ, Tmp, GyX, GyY, GyZ;
float dp=0;
float deg=0;

void setup() {
BR.Motor_Init(); BR.Gyro_Init(); Serial.begin(500000);
Timer3.initialize(10000); Timer3.attachInterrupt(tim);
}

void loop() {
if(cnt==1) {cnt=0;
BR.Gyro_Get(&AcX, &AcY, &AcZ, &GyX, &GyY, &GyZ);
float deg_acc=atan2(AcX,AcZ)*57.3;
dp=BR.Gfilter(deg_acc,GyY, 4 , 9);
deg=deg-GyY*0.01/32.8;
Serial.print(dp); Serial.print("  ");
Serial.print(deg); Serial.print("  ");
Serial.println(deg_acc);}
}

void tim() {cnt=1;}
