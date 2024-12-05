#include <SoftwareSerial.h>
#include <Wire.h>


#define RX_PIN 10  
#define TX_PIN 11  

SoftwareSerial npkSerial(RX_PIN, TX_PIN);  


const int NPK_SENSOR_ADDR = 0x60; 

int npkI2CValue = 0;  

void setup() {
  Serial.begin(9600);        
  npkSerial.begin(9600);      
  Wire.begin();               

  Serial.println("NPK Sensor Ready!");
}

void loop() {
  
  if (npkSerial.available()) {
    String sensorData = readNPKData();   
    if (!sensorData.isEmpty()) {
      parseAndDisplay(sensorData);       
    }
  }

  
  readI2CNpkData();                    
  delay(5000);                         
}

String readNPKData() {
  String data = "";

  
  npkSerial.write(0x01); 
  delay(100);

 
  while (npkSerial.available()) {
    char c = npkSerial.read();
    data += c;
  }

  return data;
}

void parseAndDisplay(String data) {
 
  int nitrogen = data.substring(0, 3).toInt();
  int phosphorus = data.substring(3, 6).toInt();
  int potassium = data.substring(6, 9).toInt();
  float pH = data.substring(9, 13).toFloat();
  int moisture = data.substring(13, 16).toInt();


  Serial.println("---- NPK Sensor Readings (UART) ----");
  Serial.print("Nitrogen (N): ");
  Serial.println(nitrogen);
  Serial.print("Phosphorus (P): ");
  Serial.println(phosphorus);
  Serial.print("Potassium (K): ");
  Serial.println(potassium);
  Serial.print("pH Level: ");
  Serial.println(pH);
  Serial.print("Moisture Level: ");
  Serial.println(moisture);
  Serial.println("------------------------------");
}

void readI2CNpkData() {
  
  Wire.requestFrom(NPK_SENSOR_ADDR, 2);  

  if (Wire.available()) {
    
    npkI2CValue = Wire.read() << 8 | Wire.read();  
    
    Serial.println("---- I2C NPK Sensor Readings ----");
    Serial.print("I2C NPK Sensor Value: ");
    Serial.println(npkI2CValue);
    Serial.println("------------------------------");
  } else {
    Serial.println("No data received from I2C NPK sensor");
  }
}
