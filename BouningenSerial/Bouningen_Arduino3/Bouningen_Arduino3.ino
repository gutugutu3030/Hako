// Sweep
// by BARRAGAN <http://barraganstudio.com> 
// This example code is in the public domain.


#include <Servo.h> 
 
Servo myservo;  // create servo object to control a servo 
                // a maximum of eight servo objects can be created 
 
int pos = 0;    // variable to store the servo position 
int old=100;
int ifmove=0;
int dir=0;
int olddir;
int l=500;

void setup(){ 
  Serial.begin(9600); // Start serial communication at 9600 bps
  myservo.attach(10);  // attaches the servo on pin 9 to the servo object
  myservo.write(pos);              // tell servo to go to position in variable 'pos' 
  pinMode(8,OUTPUT);
  pinMode(9,OUTPUT);
} 
 
 
void loop() 
{
  if (Serial.available()>2) { // If data is available to read,
     pos = Serial.read(); // read it and store it in val
     dir=Serial.read();
     ifmove=Serial.read();
     if(ifmove){
       olddir=dir;
       if(olddir==0){
          digitalWrite(8,HIGH);
          digitalWrite(9,LOW);
        }else{
          digitalWrite(8,LOW);
          digitalWrite(9,HIGH);
        }
        delay(ifmove);
        digitalWrite(8,LOW);
        digitalWrite(9,LOW);
     }
     if(abs(old-pos)>3){
        myservo.write(pos);              // tell servo to go to position in variable 'pos' 
        old=pos;
     }
     Serial.write(1);
  }
  
  //delay(15);
} 
