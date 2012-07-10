//INTVAL V 1.0
#include <Button.h>

/*
WHAT TO WIRE:
A0 - Button D - Shoot once
  -serial 0
A1 - Button C - Camera increase (x2)
  -serial 1
A2 - Button B - Delay increase (+1sec)
  -serial 2
A3 - Button A - ON/OFF loop
  -serial 3
*/

int butA=17; int butB=16; int butC=15; int butD=14;

long aonc = 0;long bonc = 0;long conc = 0;long donc = 0;

boolean swtch = false;

unsigned long timeI, timeO;

int camPin = 10;//PWM!!!!!!
int deBug = 13;
int length = 0;
int ovrl = 0;
int dela = 0;
int incomingByte = 0;

//                      1/60 1/30 1/15 1/8 1/4 1/2  1s   2    4     8   16    30     1m     2m     4m    8m      15m     30m
//                         0   1   2   3    4   5   6    7    8     9   10    11     12     13     14    15      16      17
unsigned long speeds[] = {16, 32,  64, 128, 256,512,1024,2056,4000,8000,16000,30000,60000,120000,240000,480000,900000,1800000};

Button buttonA = Button(butA,PULLUP);
Button buttonB = Button(butB,PULLUP);
Button buttonC = Button(butC,PULLUP);
Button buttonD = Button(butD,PULLUP);

void setup(){
  pinMode(camPin,OUTPUT);
  pinMode(deBug,OUTPUT);

  Serial.begin(9600);
  Serial.flush();
  Serial.println("Connected");
  delay(150);

  for(int o=0;o<18;o++)
  {
    Serial.print(o);
    Serial.print(": ");
    Serial.println(speeds[o]);
  }
}

void loop(){
  aonc = 0; bonc = 0; conc = 0; donc = 0;
 if(Serial.available()>0){
    incomingByte = Serial.read();
   if(incomingByte==51){  //0
     bD();
   }
      if(incomingByte==50){
     bC(1);
   }
      if(incomingByte==49){
     bB(1);
   }
      if(incomingByte==48){
     bA();
   }
  Serial.flush();
}
  
  

  while(buttonA.isPressed()){ //ON OFF Toggle Button
    bA();
  }
  digitalWrite(deBug,LOW);

  while(buttonB.isPressed()){ //Delay increase
    bB(1);
    //bB(-1);
  }
  digitalWrite(deBug,LOW);

  while(buttonC.isPressed()){ //Camera increase
    bC(1);
    //bC(-1);
  }
  digitalWrite(deBug,LOW);

  while(buttonD.isPressed()){ //Shoot once
    bD();
  }
  //serial ifs


  digitalWrite(deBug,LOW);
  if(swtch==true){
    ovrl++;
    ease(camPin,speeds[length]);
    delay(dela*1000); 
  }
  
}

void ease(int pin, int L){
  int steps = 255;
   unsigned long then = millis();
  for(int i=0;i<256;i+=255/steps){
    analogWrite(pin,i);
    delay(1);
  }
  analogWrite(pin,255);
  delay(L);
  for(int i=255;i>-1;i-=255/steps){
    analogWrite(pin,i);
    delay(1);
  }

  Serial.print("Frame[");
  Serial.print(ovrl);
  Serial.print("] : ");
  Serial.println(millis()-then);
  Serial.flush();

}
// ON/OFF
void bA(){
  digitalWrite(deBug,HIGH);
    if(aonc<1)
    {
      if(!swtch)
      {
        swtch=true;
        Serial.println("ON");
        blinker(deBug,2);
      } else{
        swtch=false;
        Serial.println("OFF");
        blinker(deBug,3);
      }
      aonc++;
    }
    delay(5);
}
// delay manipulation
void bB(int change){
  if(bonc<1){
    dela += change;
    blinker(deBug,dela);
    Serial.print("Delay: ");
    Serial.println(dela*1000);
    bonc++;
  }
  delay(5);
}
//
void bC(int change){
  if(conc<1){
    length += change;
    if(length>17){
      length=0;
    }
    blinker(deBug,length);
    Serial.print("Camera[");
    Serial.print(length);
    Serial.print("] : ");
    Serial.println(speeds[length]);
    conc++;
  }
  delay(5);
}
//Print 1
void bD(){
  if(donc<1){
    ovrl++;
    ease(camPin,speeds[length]);
    blinker(deBug,length);
    donc++;
  }
  delay(5);
}


void blinker(int pin, int times){
  for(int i=0; i<times; i++){
    digitalWrite(pin,HIGH);
    delay(32);
    digitalWrite(pin,LOW);
    	delay(200); 	  
  } 
}

//for 1-505;
int ramp(int x) {
 float a = 1/1000;
 float b = 2.0;
 int limit = floor(pow(a*x, 2)); 
 if(limit > 255) {
    limit = 255; 
 }
 return limit;
}

//BETTER RAMP FUNCTION FOR STABILITY
