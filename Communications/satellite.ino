#include "LoRaWan_APP.h"
#include "Arduino.h"


#ifndef LoraWan_RGB
#define LoraWan_RGB 0
#endif

#define RF_FREQUENCY                                915000000 
#define TX_OUTPUT_POWER                             14        
#define LORA_BANDWIDTH                              0         
#define LORA_SPREADING_FACTOR                       7         
#define LORA_CODINGRATE                             1         
#define LORA_PREAMBLE_LENGTH                        8         
#define LORA_SYMBOL_TIMEOUT                         0        
#define LORA_FIX_LENGTH_PAYLOAD_ON                  false
#define LORA_IQ_INVERSION_ON                        false
#define RX_TIMEOUT_VALUE                            1000
#define BUFFER_SIZE                                 30 

char txpacket[BUFFER_SIZE];
char rxpacket[BUFFER_SIZE];

static RadioEvents_t RadioEvents;

int16_t txNumber;

int16_t rssi, rxSize;

bool lora_idle = true;
bool serverConnected = false;
bool allDataReceived = false;

void setup() {
    Serial.begin(115200);

    txNumber = 0;
    rssi = 0;
    RadioEvents.RxDone = OnRxDone;
    Radio.Init(&RadioEvents);
    Radio.SetChannel(RF_FREQUENCY);

    Radio.SetRxConfig(MODEM_LORA, LORA_BANDWIDTH, LORA_SPREADING_FACTOR,
                      LORA_CODINGRATE, 0, LORA_PREAMBLE_LENGTH,
                      LORA_SYMBOL_TIMEOUT, LORA_FIX_LENGTH_PAYLOAD_ON,
                      0, true, 0, 0, LORA_IQ_INVERSION_ON, true);
}

void loop() {
    if (serverConnected) {
        sendResponseToServer();
    } else if (allDataReceived) {
        sendConfirmationToGround();
    }
    if (lora_idle) {
        turnOffRGB();
        lora_idle = false;
        Serial.println("Switching to RX mode");
        Radio.Rx(0);
    }

    delay(5000);  
}

void sendConfirmationToGround() {
    char confirmationData[] = "Data successfully received";
    Radio.Send((uint8_t *)confirmationData, strlen(confirmationData));
}

void sendResponseToServer() {
    char resp[] = "Acknowledged";
    Radio.Send((uint8_t *)resp, strlen(resp));
}

void OnTxDone(void) {
    
}

void OnRxDone(uint8_t *payload, uint16_t size, int16_t rssi, int8_t snr) {
    rssi = rssi;
    rxSize = size;
    memcpy(rxpacket, payload, size);
    rxpacket[size] = '\0';
    turnOnRGB(COLOR_RECEIVED, 0);
    Radio.Sleep();
    Serial.printf("\nReceived packet \"%s\" with RSSI %d, length %d\n", rxpacket, rssi, rxSize);
    lora_idle = true;

    if (strcmp((char *)payload, "Server ready")) {
        serverConnected = true; 
    } else if (strcmp((char *)payload, "Telemetry data")) {
        allDataReceived = true; 
    }
    Serial.printf("\nProcessed packet \"%s\" with RSSI %d, length %d\n", payload, rssi, size);
}
