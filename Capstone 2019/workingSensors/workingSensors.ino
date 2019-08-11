
//Light Sensor
const int sensorPin = 1;
int lightCal;
int lightVal;

//Temp Humidity
#include <dht_nonblocking.h>
#define DHT_SENSOR_TYPE DHT_TYPE_11
static const int DHT_SENSOR_PIN = 11;
DHT_nonblocking dht_sensor( DHT_SENSOR_PIN, DHT_SENSOR_TYPE );

//Soil Moisture
#define MoisturePin A0
float sensorValue=0;

void setup() 
{
  lightCal = analogRead(sensorPin);
  Serial.begin( 9600);
}
static bool measure_environment( float *temperature, float *humidity )
{
  static unsigned long measurement_timestamp = millis( );

  /* Measure once every four seconds. */
  if( millis( ) - measurement_timestamp > 3000ul )
  {
    if( dht_sensor.measure( temperature, humidity ) == true )
    {
      measurement_timestamp = millis( );
      return( true );
    }
  }

  return( false );
}
int soilMoisture(){
   for (int i = 0; i <= 100; i++) 
 { 
   sensorValue = sensorValue + analogRead(MoisturePin); 
   delay(1); 
 } 
 sensorValue = sensorValue/100.0; 
 Serial.println(sensorValue); 
 delay(30);
}

void loop(){
  //Light/Photoresistor
  lightVal = analogRead(sensorPin);
  

  //Humidity/Temp
  float temperature;
  float humidity;

  /* Measure temperature and humidity.  If the functions returns
     true, then a measurement is available. */
  if( measure_environment( &temperature, &humidity ) == true )
  {
    Serial.print( "T = " );
    Serial.print( temperature, 1 );
    Serial.print( " deg. C, H = " );
    Serial.print( humidity, 1 );
    Serial.println( "%" );
    Serial.print("Light Value: ");
    Serial.println(lightVal);
    Serial.print("Soil Moisture Level: ");
    soilMoisture();
  }
 
}
