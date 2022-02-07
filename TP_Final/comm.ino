#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>

Adafruit_PWMServoDriver servos = Adafruit_PWMServoDriver(0x40);

int pos0 = 96;
int pos180=506;
int theta1;
int theta2;
int theta3;
int servo1_pin = 0;
int servo2_pin = 1;
int servo3_pin = 2;

void setup() {
  // put your setup code here, to run once:
 servos.begin();
 servos.setPWMFreq(50);
 Serial.begin(9600);
}

void loop() {
 if(Serial.available()>0 )
    {
      theta1 = Serial.readStringUntil(' ').toInt();
      theta2 = Serial.readStringUntil(' ').toInt();
      theta3 = Serial.readStringUntil(' ').toInt();
      
      
      if( (theta1>180 || theta1<0) && (theta2>180 || theta2<0) && (theta3>180 || theta3<0))
      {
        Serial.println("Invalid angle range (0-180°)");
      }
      else
      {
        
        Serial.println("Readed \ntheta 1 : ");
        Serial.println(theta1);
        Serial.println("Readed \ntheta 2 : ");
        Serial.println(theta2);
        Serial.println("Readed \ntheta 3 : ");
        Serial.println(theta3);
        setServo(servo1_pin,theta1+8);
        setServo(servo2_pin,theta2);
        setServo(servo3_pin,theta3+6);
        Serial.flush();
        delay(500);
      
    }

  }

}

void setServo(uint8_t servo_id,int angulo)
{
  int duty;
  duty=map(angulo,0,180,pos0,pos180);
  //Serial.println(duty);
  servos.setPWM(servo_id,0,duty);
}
