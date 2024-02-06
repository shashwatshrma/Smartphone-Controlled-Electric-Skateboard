#define EN 4 //enables HC-05
#define IN1 3 //left wheels backward 
#define IN2 5 //left wheels forward
#define IN3 6 //right wheels backward
#define IN4 9 //right wheels forward

int speed = 255;
char dir = 'f';
//f - forward
//b - backward

void forward()
{
  dir = 'f';
  analogWrite(IN1, 0);
  analogWrite(IN2, speed);
  analogWrite(IN3, 0);
  analogWrite(IN4, speed);
}

void backward()
{
  dir = 'b';
  analogWrite(IN1, speed);
  analogWrite(IN2, 0);
  analogWrite(IN3, speed);
  analogWrite(IN4, 0);
}

void left()
{
  analogWrite(IN1, 0);
  analogWrite(IN2, 0);
  delay(1000);
  if(dir == 'f')
  {
    analogWrite(IN1, 0);
    analogWrite(IN2, speed);
  }
  else
  {
    analogWrite(IN1, speed);
    analogWrite(IN2, 0);
  }
}

void right()
{
  analogWrite(IN3, 0);
  analogWrite(IN4, 0);
  delay(1000);
  if(dir == 'f')
  {
    analogWrite(IN3, 0);
    analogWrite(IN4, speed);
  }
  else
  {
    analogWrite(IN3, speed);
    analogWrite(IN4, 0);
  }
}

void stop()
{
  analogWrite(IN1, 0);
  analogWrite(IN2, 0);
  analogWrite(IN3, 0);
  analogWrite(IN4, 0);
}

void setup()
{
  pinMode(EN, OUTPUT);
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);
  Serial.begin(9600);
  digitalWrite(EN, HIGH);
}

void loop()
{
  if(Serial.available())
  {
    char command = Serial.read();
    Serial.println(command);
    switch(command)
    {
      case '+':
        speed += 50;
        if(speed > 250)
          speed = 250;
        break;
      case '-':
        speed -= 50;
        if(speed < 0)
          speed = 0;
        break;
      case 'f':
        forward();
        break;
      case 'b':
        backward();
        break;
      case 'l':
        left();
        break;
      case 'r':
        right();
        break;
      case 's':
        stop();
        break;
    }
  }
}
