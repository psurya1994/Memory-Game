int level = 1;

void setup()
{
  Serial.begin(9600);
  Serial.println("Starting game...");
  for (int i = 2; i <= 7; i++)
  {
    pinMode(i, OUTPUT);
  }
  for (int i = 8; i <= 11; i++)
  {
    pinMode(i, INPUT);
  }
  digitalWrite(2, LOW);
  digitalWrite(3, LOW);
  digitalWrite(4, LOW);
  digitalWrite(5, LOW);
}

void LEDs_low()
{  
  digitalWrite(2, LOW);
  digitalWrite(3, LOW);
  digitalWrite(4, LOW);
  digitalWrite(5, LOW);
}

void loop()
{
  // randomly glow led
  int a[level];
  
  digitalWrite(6,LOW);
  digitalWrite(7,LOW);
  
  for(int m = 0; m < level; m++)
  {
    int total =analogRead(A0)+analogRead(A1)+analogRead(A2)+analogRead(A3)+analogRead(A4)+analogRead(A5);
    a[m] = (total%4)+2;   
    digitalWrite(a[m], HIGH);
    delay(1000);
    digitalWrite(a[m], LOW);
    delay(500);
  }
  Serial.println("");
  Serial.print("level = ");
  Serial.print(level);
  Serial.println("");
  for(int j=0;j<level;j++)
  {
    Serial.print("a[j] = ");
    Serial.println(a[j]);
  }
  //take input from user
  int j=0;
  int flag=-1;
  while(1)
  {
    int i;
    for (i = 8; i <= 11; i++)
    {
      
      int temp = digitalRead(i);
      if(temp==1)
      {
        Serial.print("a[j]=");
        Serial.print(a[j]);
        Serial.print(", ");
        Serial.println(i-6);
        if(a[j] == i-6)
        {
          Serial.println("correct");
          flag=1;
          j++;
          digitalWrite(6,HIGH);
          delay(300);
          digitalWrite(6,LOW);
          if(j==level)
          {
            flag=2;
            level = level + 1; 
            //digitalWrite(6,HIGH);
          }
        }
        else
        {
          Serial.println("wrong");
          digitalWrite(7,HIGH);
          flag=0;
          level = 1;
        }
        break;
      }
    }
    
    if(flag==0 || flag==2) break;
  }
  
  Serial.println("end of program");
  delay(1000);
}
