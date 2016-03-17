/*
 Copyright 2013-2014 JUMA Technology
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
*/


#import "BCBluetooth.h"

#import <Cordova/NSDictionary+Extensions.h>
#import <Cordova/NSArray+Comparisons.h>
#import "sys/sysctl.h"

#define BLUETOOTH_STATE                                         @"state"
#define BLUETOOTH_OPEN                                          @"bluetoothopen"
#define BLUETOOTH_CLOSE                                         @"bluetoothclose"
#define DEVICE_NAME                                             @"deviceName"
#define DEVICE_ADDRESS                                          @"deviceAddress"
#define DEVICE_TYPE                                             @"deviceType"
#define PERIPHERALADDRESS                                       @"peripheralAddress"
#define MES                                                     @"mes"
#define DATA                                                    @"data"
#define ADVERTISEMENT_DATA                                      @"advertisementData"
#define SERVICES                                                @"services"
#define CHARACTERISTICS                                         @"characteristics"
#define DESCRIPTORS                                             @"descriptors"
#define SERVICE_INDEX                                           @"serviceIndex"
#define SERVICE_NAME                                            @"serviceName"
#define SERVICE_TYPE                                            @"serviceType"
#define SERVICE_UUID                                            @"serviceUUID"
#define UINQUE_ID                                               @"uniqueID"
#define CHARACTERISTIC_INDEX                                    @"characteristicIndex"
#define CHARACTERISTIC_VALUE                                    @"characteristicValue"
#define CHARACTERISTIC_NAME                                     @"characteristicName"
#define CHARACTERISTIC_PERMISSION                               @"characteristicPermission"
#define CHARACTERISTIC_PROPERTY                                 @"characteristicProperty"
#define CHARACTERISTIC_UUID                                     @"characteristicUUID"
#define CHARACTERISTIC_UUIDS                                    @"characteristicUUIDs"
#define CHARACTERISTIC_VALUE_TYPE                               @"characteristicValueType"
#define DESCRIPTOR_INDEX                                        @"descriptorIndex"
#define DESCRIPTOR_NAME                                         @"descriptorName"
#define DESCRIPTOR_PERMISSION                                   @"descriptorPermission"
#define DESCRIPTOR_UUID                                         @"descriptorUUID"
#define DESCRIPTOR_VALUE                                        @"descriptorValue"
#define DESCRIPTOR_VALUE_TYPE                                   @"descriptorValueType"
#define PERIPHERAL_RSSI                                         @"RSSI"
#define VALUE                                                   @"value"
#define DATE                                                    @"date"
#define DATE_FORMATE                                            @"yyyy-MM-dd HH:mm:ss:SSS"

#define NOTAVAILABLE                                            @"n/a"
#define SUCCESS                                                 @"success"
#define ERROR                                                   @"error"
#define IS_TRUE                                                 @"true"
#define IS_FALSE                                                @"false"
#define ENABLE                                                  @"enable"
#define IS_CONNECTED                                            @"isConnected"
#define DISCONNECT                                              @"disconnect"

#define PERMISSION_READ                                         @"read"
#define PERMISSION_READ_ENCRYPTED                               @"readEncrypted"
#define PERMISSION_READ_ENCRYPTED_MITM                          @"readEncryptedMitm"
#define PERMISSION_WRITE                                        @"write"
#define PERMISSION_WRITE_ENCRYPTED_MITM                         @"writeEncryptedMitm"
#define PERMISSION_WRITE_ENCRYPTED                              @"writeEncrypted"
#define PERMISSION_WRITE_SIGEND                                 @"writeSigend"
#define PERMISSION_WRITE_SIGEND_MITM                            @"writeSigendMitm"
#define PROPERTY_AUTHENTICATED_SIGNED_WTRTES                    @"authenticatedSignedWrites"
#define PROPERTY_BROADCAST                                      @"broadcast"
#define PROPERTY_EXTENDED_PROPERTIES                            @"extendedProperties"
#define PROPERTY_INDICATE                                       @"indicate"
#define PROPERTY_NOTIFY                                         @"notify"
#define PROPERTY_READ                                           @"read"
#define PROPERTY_WRITE                                          @"write"
#define PROPERTY_WRITE_WITHOUT_RESPONSE                         @"writeWithoutResponse"
#define PROPERTY_NOTIFY_ENCRYPTION_REQUIRED                     @"NotifyEncryptionRequired"
#define PROPERTY_INDICATE_ENCRYPTION_REQUIRED                   @"IndicateEncryptionRequired"

#define KCBADVDATA_LOCALNAME                                    @"kCBAdvDataLocalName"
#define LOCAL_NAME                                              @"localName"
#define KCBADVDATA_SERVICE_UUIDS                                @"kCBAdvDataServiceUUIDs"
#define SERVICE_UUIDS                                           @"serviceUUIDs"
#define KCBADVDATA_TXPOWER_LEVEL                                @"kCBAdvDataTxPowerLevel"
#define TXPOWER_LEVEL                                           @"txPowerLevel"
#define KCBADVDATA_SERVICE_DATA                                 @"kCBAdvDataServiceData"
#define SERVICE_DATA                                            @"serviceData"
#define KCBADVDATALOCAL_NAME                                    @"kCBAdvDataManufacturerData"
#define MANUFACTURER_DATA                                       @"manufacturerData"
#define KCBADVDATA_OVERFLOW_SERVICE_UUIDS                       @"kCBAdvDataOverflowServiceUUIDs"
#define OVERFLOW_SERVICE_UUIDS                                  @"overflowServiceUUIDs"
#define KCBADVDATA_ISCONNECTABLE                                @"kCBAdvDataIsConnectable"
#define ISCONNECTABLE                                           @"isConnectable"
#define KCBADCDATA_SOLICITED_SERVICE_UUIDS                      @"kCBAdvDataSolicitedServiceUUIDs"
#define SOLICITED_SERVICE_UUIDS                                 @"solicitedServiceUUIDs"

#define EVENT_NAME                                              @"eventName"
#define EVENT_DISCONNECT                                        @"disconnect"
#define EVENT_ONSUBSCRIBE                                       @"onsubscribe"
#define EVENT_ONUNSUBSCRIBE                                     @"onunsubscribe"
#define EVENT_ONCHARACTERISTICREAD                              @"oncharacteristicread"
#define EVENT_ONCHARACTERISTICWRITE                             @"oncharacteristicwrite"
#define EVENT_NEWADVPACKET                                      @"newadvpacket"
#define EVENT_BLUETOOTHOPEN                                     @"bluetoothopen"
#define EVENT_BLUETOOTHCLOSE                                    @"bluetoothclose"

#define GETBLUETOOTHSTATE                                       @"getBluetoothState"
#define BLUETOOTHSTARTSTATE                                     @"bluetoothState"
#define GETCONNECTEDDEVICES                                     @"getConnectedDevices"
#define SETNOTIFICATION                                         @"setNotification"
#define ADDSERVICE                                              @"addService"
#define ONREADREQUEST                                           @"onReadRequest"
#define ONWRIESTREQUEST                                         @"onWriteRequest"
#define WRITE_TYPE                                              @"writeType"
#define WRITE_VALUE                                             @"writeValue"
#define ISON                                                    @"isON"
#define READCHARACTERISTIC                                      @"readCharacteristor"
#define READDESCRIPTOR                                          @"readDescriptor"
#define WRITE                                                   @"write"
#define ON_READ_REQUEST                                         @"onReadRequest"
#define ON_WRITE_REQUEST                                        @"onWriteRequest"
#define WRITEREQUESTVALUE                                       @"writeRequestValue"

#define LOGINFORMATION                                          @"logInformation"
#define BLE_DEVICETYPE                                          @"BLE"
#define APP_ID                                                  @"appID"
#define API                                                     @"api"
#define VERSION                                                 @"VERSION"
#define IOS                                                     @"ios"
#define GETDEVICEID                                             @"getOwnDeviceAddress"

#define IS_IOS_VERSION              (([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0)? (YES):(NO))

#define GAP_MODUAL                  1
#define GATT_MODUAL                 2
#define DATA_MODUAL                 4
#define BCLOG_FUNC(modual)          [self logFunc:modual information:[NSString stringWithFormat:@"%s",__FUNCTION__]];
#define BCLOG_DATA(info,s,d,uuid)   [self logValue:info operation:s device:d UUID:uuid];
#define BCLOG_ERROR                 [self postErrorInformation];
#define BCLOG_SCANDATA              [self logScanDeviceUUID:[self getPeripheralUUID:peripheral] RSSI:[NSString stringWithFormat:@"%@",RSSI]];
#define BCLOG_RSSI                  [self logRSSI:RSSI device:[self getPeripheralUUID:peripheral]];
#define BCLOG_UUID(type)            [self logUUID:type.UUID];


@implementation BCBluetooth

@synthesize bluetoothState;
@synthesize urlAndCallback;
@synthesize _peripherals;

@synthesize peripheralsInfo;
@synthesize advDataDic;
@synthesize RSSIDic;

@synthesize serviceAndKeyDic;
@synthesize eventNameAndCallbackIdDic;
@synthesize writeReqAndCharacteristicDic;
@synthesize readReqAndCharacteristicDic;
@synthesize valueAndCharacteristicDic;

@synthesize myPeripheralManager;
@synthesize myCentralManager;

@synthesize debugOnOrOff;
@synthesize stopScanTimer;
@synthesize isAddAllData;
@synthesize isEndOfAddService;
@synthesize isFindingPeripheral;
#pragma mark -
#pragma mark BC Interface
#pragma mark -
- (void)pluginInitialize{
    [super pluginInitialize];
    
    isEndOfAddService = FALSE;
    isAddAllData = FALSE;
    isFindingPeripheral = FALSE;

    
    myPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    myCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    urlAndCallback = [[NSMutableDictionary alloc] init];
    _peripherals = [[NSMutableArray alloc] init];
    
    peripheralsInfo = [[NSMutableArray alloc] init];
    advDataDic = [[NSMutableDictionary alloc] init];
    RSSIDic = [[NSMutableDictionary alloc] init];
    
    serviceAndKeyDic = [[NSMutableDictionary alloc] init];
    eventNameAndCallbackIdDic = [[NSMutableDictionary alloc] init];
    writeReqAndCharacteristicDic = [[NSMutableDictionary alloc] init];
    readReqAndCharacteristicDic = [[NSMutableDictionary alloc] init];
    valueAndCharacteristicDic = [[NSMutableDictionary alloc] init];
    bluetoothState = BLUETOOTHSTARTSTATE;
    debugOnOrOff = [[NSString alloc] init];
}

- (CDVPlugin*)initWithWebView:(UIWebView*)theWebView deviceAddress:(NSString *)dicPlugin{
    self = [super init];
    if (self) {
        device_address = dicPlugin;
    }
    return self;
}

- (void)getEnvironment:(CDVInvokedUrlCommand *)command{
    BCLOG_FUNC(GAP_MODUAL)
    NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
    [callbackInfo setValue:NOTAVAILABLE forKey:APP_ID];
    [callbackInfo setValue:IOS forKey:API];
    [callbackInfo setValue:BLE_DEVICETYPE forKeyPath:DEVICE_TYPE];
    [callbackInfo setValue:[NSString stringWithFormat:@"%f",[[[UIDevice currentDevice] systemVersion] floatValue]] forKey:VERSION];
    [callbackInfo setValue:device_address forKey:DEVICE_ADDRESS];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)getBluetoothState:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(GAP_MODUAL)
    [self.urlAndCallback setValue:command.callbackId forKey:GETBLUETOOTHSTATE];
    [self performSelector:@selector(getBluetoothStateCallback) withObject:nil afterDelay: (bluetoothState.length > 0 ? 0:1.0)];

}

- (void)getBluetoothStateCallback{
    NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
    [callbackInfo setValue:bluetoothState forKey:BLUETOOTH_STATE];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
    [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback valueForKey:GETBLUETOOTHSTATE]];
}

- (void)addEventListener:(CDVInvokedUrlCommand *)command{
    BCLOG_FUNC(GAP_MODUAL)
    if ([self existCommandArguments:command.arguments]) {
        NSString *eventName = [self parseStringFromJS:command.arguments keyFromJS:EVENT_NAME];
        [self.urlAndCallback setValue:command.callbackId forKey:eventName];
    }else{
        [self error:command.callbackId];
    }
}

- (void)openBluetooth:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(GAP_MODUAL)
    [self error:command.callbackId];
}

- (void)startScan:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(GAP_MODUAL)
    if ([self existCommandArguments:command.arguments]){
        NSMutableArray *serviceUUIDs = [self parseArrayFromJS:command.arguments keyFromJS:SERVICE_UUIDS];
        if (serviceUUIDs) {
            if (serviceUUIDs.count > 0){
                [self.myCentralManager scanForPeripheralsWithServices:serviceUUIDs options:0];
            }else{
                [self.myCentralManager scanForPeripheralsWithServices:nil options:0];
            }
        }else{
            [self.myCentralManager scanForPeripheralsWithServices:nil options:0];
        }
        self.isFindingPeripheral = FALSE;
        NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
        [callbackInfo setValue:SUCCESS forKey:MES];
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }else{
        [self error:command.callbackId];
    }
}

- (void)stopScan:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(GAP_MODUAL)
    [self.myCentralManager stopScan];
    self.isFindingPeripheral = TRUE;
    NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
    [callbackInfo setValue:SUCCESS forKey:MES];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)creatPair:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(GAP_MODUAL)
    [self error:command.callbackId];
}

- (void)removePair:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(GAP_MODUAL)
    [self error:command.callbackId];
}

- (void)getPairedDevices:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(GAP_MODUAL)
    [self error:command.callbackId];
}

- (void)getConnectedDevices:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(GAP_MODUAL)
    [self.urlAndCallback setValue:command.callbackId forKey:GETCONNECTEDDEVICES];
    [self.myCentralManager retrieveConnectedPeripherals];
}

- (void)connect:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(GAP_MODUAL)
    if ([self existCommandArguments:command.arguments]){
        NSString *deviceAddress = [self parseStringFromJS:command.arguments keyFromJS:DEVICE_ADDRESS];
        [self.urlAndCallback setValue:command.callbackId forKey:deviceAddress];
        if ([self isNormalString:deviceAddress]) {
            CBPeripheral *peripheral = [self getPeripheral:deviceAddress];
            if (peripheral) {
                if (IS_IOS_VERSION) {
                    if (peripheral.state == CBPeripheralStateConnected) {
                        [self connectRequest:deviceAddress callbackId:command.callbackId isKeepCallback:FALSE];
                    }else if(peripheral.state == CBPeripheralStateDisconnected){
                        [self.myCentralManager connectPeripheral:peripheral options:nil];
                    }
                }else{
                    if (peripheral.isConnected) {
                        [self connectRequest:deviceAddress callbackId:command.callbackId isKeepCallback:FALSE];
                    }else{
                        [self.myCentralManager connectPeripheral:peripheral options:nil];
                    }
                }
            }else{
                if (!self.isFindingPeripheral) {
                    self.isFindingPeripheral = TRUE;
                    [self.myCentralManager scanForPeripheralsWithServices:nil options:nil];
                    [self.urlAndCallback setValue:deviceAddress forKey:PERIPHERALADDRESS];
                    stopScanTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(stopToScan) userInfo:nil repeats:NO];
                }else{
                    [self error:command.callbackId];
                }
            }
        }else{
            [self error:command.callbackId];
        }
    }else{
        [self error:command.callbackId];
    }
}

- (void)connectRequest:(NSString *)deviceID callbackId:(NSString *)callback isKeepCallback:(BOOL)isKeepCallback{
    NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
    [callbackInfo setValue:SUCCESS forKey:MES];
    [callbackInfo setValue:deviceID forKey:DEVICE_ADDRESS];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
    if (isKeepCallback) {
        [result setKeepCallbackAsBool:TRUE];
    }
    [self.commandDelegate sendPluginResult:result callbackId:callback];
}

- (void)stopToScan{
    self.isFindingPeripheral = FALSE;
    [self.myCentralManager stopScan];
    [self error:[self.urlAndCallback valueForKey:[self.urlAndCallback valueForKey:PERIPHERALADDRESS]]];
}

- (void)disconnect:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(GAP_MODUAL)
    if ([self existCommandArguments:command.arguments]) {
        NSString *deviceAddress = [self parseStringFromJS:command.arguments keyFromJS:DEVICE_ADDRESS];
        [self.urlAndCallback setValue:command.callbackId forKey:deviceAddress];
        if ([self isNormalString:deviceAddress]) {
            CBPeripheral *peripheral = [self getPeripheral:deviceAddress];
            if (peripheral) {
                if (peripheral.isConnected) {
                    [self.myCentralManager cancelPeripheralConnection:peripheral];
                }else{
                    [self connectRequest:deviceAddress callbackId:command.callbackId isKeepCallback:FALSE];
                }
            }else{
                [self error:command.callbackId];
            }
        }else{
            [self error:command.callbackId];
        }
    }else{
        [self error:command.callbackId];
    }
}

- (void)getServices:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(GATT_MODUAL)
    if ([self existCommandArguments:command.arguments]) {
        NSString *deviceAddress = [self parseStringFromJS:command.arguments keyFromJS:DEVICE_ADDRESS];
        if ([self isNormalString:deviceAddress]){
            CBPeripheral *peripheral=[self getPeripheral:deviceAddress];
            [self.urlAndCallback setValue:command.callbackId forKey:[NSString stringWithFormat:@"getServices:%@",deviceAddress]];
            if (peripheral) {
                if (peripheral.services.count > 0){
                    NSMutableDictionary *callbackInfo = [self storeServiceInfo:peripheral];
                    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
                    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                }else{
                    peripheral.delegate = self;
                    [peripheral discoverServices:nil];
                }
            }else{
                [self error:command.callbackId];
            }
        }else{
            [self error:command.callbackId];
        }
    }else{
        [self error:command.callbackId];
    }
}

- (void)getCharacteristics:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(GATT_MODUAL)
    if ([self existCommandArguments:command.arguments]){
        NSString *serviceIndex = [self parseStringFromJS:command.arguments keyFromJS:SERVICE_INDEX];
        NSString *deviceAddress = [self parseStringFromJS:command.arguments keyFromJS:DEVICE_ADDRESS];
        if ([self isNormalString:deviceAddress]){
            CBPeripheral *peripheral=[self getPeripheral:deviceAddress];
            if (peripheral) {
                if ([self isNormalString:serviceIndex]){
                    [self.urlAndCallback setValue:command.callbackId forKey:[NSString stringWithFormat:@"%d%@",[serviceIndex intValue],deviceAddress]];
                    if (peripheral.services.count > [serviceIndex intValue]) {
                        CBService *service = [peripheral.services objectAtIndex:[serviceIndex intValue]];
                        if (service.characteristics.count > 0) {
                            NSMutableDictionary *callbackInfo = [self storeChatacteristicInfo:peripheral service:service];
                            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
                            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                        }else{
                            peripheral.delegate = self;
                            [peripheral discoverCharacteristics:nil forService:service];
                        }
                    } else {
                        [self error:command.callbackId];
                    }
                } else {
                    [self error:command.callbackId];
                }
            }else{
                [self error:command.callbackId];
            }
        }else{
            [self error:command.callbackId];
        }
    }else {
        [self error:command.callbackId];
    }
}

- (void)getDescriptors:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(GATT_MODUAL)
    if ([self existCommandArguments:command.arguments]){
        NSString *charateristicIndex = [self parseStringFromJS:command.arguments keyFromJS:CHARACTERISTIC_INDEX];
        NSString *serviceIndex = [self parseStringFromJS:command.arguments keyFromJS:SERVICE_INDEX];
        NSString *deviceAddress = [self parseStringFromJS:command.arguments keyFromJS:DEVICE_ADDRESS];
        if ([self isNormalString:deviceAddress]){
            CBPeripheral *peripheral = [self getPeripheral:deviceAddress];
            if (peripheral) {
                if ([self isNormalString:serviceIndex] && (peripheral.services.count > [serviceIndex intValue])){
                    CBService *service = [peripheral.services objectAtIndex:[serviceIndex intValue]];
                    if ([self isNormalString:charateristicIndex]){
                        [self.urlAndCallback setValue:command.callbackId forKey:[NSString stringWithFormat:@"%d%d%@",[charateristicIndex intValue],[serviceIndex intValue],deviceAddress]];
                        if (service.characteristics.count > [charateristicIndex intValue]) {
                            CBCharacteristic *characteristic = [service.characteristics objectAtIndex:[charateristicIndex intValue]];
                            if (characteristic.descriptors.count > 0) {
                                NSMutableDictionary *callbackInfo = [self storeDescriptorInfo:peripheral characteristic:characteristic];
                                CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
                                [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                            }else{
                                peripheral.delegate = self;
                                [peripheral discoverDescriptorsForCharacteristic:characteristic];
                            }
                        }else{
                            [self error:command.callbackId];
                        }
                    } else{
                        [self error:command.callbackId];
                    }
                }else{
                    [self error:command.callbackId];
                }
                
            }else{
                [self error:command.callbackId];
            }
        }else{
            [self error:command.callbackId];
        }
    } else{
        [self error:command.callbackId];
    }
}

- (void)getRSSI:(CDVInvokedUrlCommand*)command{
    if ([self existCommandArguments:command.arguments]) {
        NSString *deviceAddress = [self parseStringFromJS:command.arguments keyFromJS:DEVICE_ADDRESS];
        [self.urlAndCallback setValue:command.callbackId forKey:[NSString stringWithFormat:@"getRssi%@",deviceAddress]];
        if ([self isNormalString:deviceAddress]) {
            CBPeripheral *peripheral = [self getPeripheral:deviceAddress];
            if (peripheral) {
                peripheral.delegate = self;
                [peripheral readRSSI];
            }else{
                [self error:command.callbackId];
            }
        }else{
            [self error:command.callbackId];
        }
    }else{
        [self error:command.callbackId];
    }
}

- (void)writeValue:(CDVInvokedUrlCommand*)command{
    if ([self existCommandArguments:command.arguments]){
        [self.urlAndCallback setValue:command.callbackId forKey:WRITE];
        NSString *deviceAddress = [self parseStringFromJS:command.arguments keyFromJS:DEVICE_ADDRESS];
        if ([self isNormalString:deviceAddress]) {
            CBPeripheral *peripheral = [self getPeripheral:deviceAddress];
            if (peripheral) {
                NSString *valueWrite = [self parseStringFromJS:command.arguments keyFromJS:WRITE_VALUE];
                NSString *descriptorIndex = [self parseStringFromJS:command.arguments keyFromJS:DESCRIPTOR_INDEX];
                NSString *characteristicIndex = [self parseStringFromJS:command.arguments keyFromJS:CHARACTERISTIC_INDEX];
                NSString *serviceIndex = [self parseStringFromJS:command.arguments keyFromJS:SERVICE_INDEX];
                NSData *data = [NSData dataFromBase64String:valueWrite];
                if (data) {
                    if ([self isNormalString:serviceIndex]){
                        if (peripheral.services.count > [serviceIndex intValue]) {
                            CBService *service=[peripheral.services objectAtIndex:[serviceIndex intValue]];
                            if ([self isNormalString:characteristicIndex]){
                                if (service.characteristics.count > [characteristicIndex intValue]) {
                                    CBCharacteristic *characteristic = [service.characteristics objectAtIndex:[characteristicIndex intValue]];
                                    if ([self isNormalString:descriptorIndex]){
                                        if (characteristic.descriptors.count > [descriptorIndex intValue]) {
                                            peripheral.delegate = self;
                                            CBDescriptor *descripter = [characteristic.descriptors objectAtIndex: [descriptorIndex intValue] ];
                                            [peripheral writeValue:data forDescriptor:descripter];
                                            BCLOG_DATA(data,@"writeDescriptor",deviceAddress,[self CBUUIDFiltrToString:descripter.UUID])
                                        }else{
                                            [self error:command.callbackId];
                                        }
                                    }else{
                                        peripheral.delegate = self;
                                        if (characteristic.properties & CBCharacteristicPropertyWriteWithoutResponse) {
                                            [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
                                        }else if (characteristic.properties & CBCharacteristicPropertyWrite){
                                            [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
                                        }
                                        BCLOG_DATA(data,@"writeCharacteristic",deviceAddress,[self CBUUIDFiltrToString:characteristic.UUID])
                                    }
                                }else{
                                    [self error:command.callbackId];
                                }
                            }else{
                                [self error:command.callbackId];
                            }
                        }else{
                            [self error:command.callbackId];
                        }
                    }else{
                        [self error:command.callbackId];
                    }
                }else{
                    [self error:command.callbackId];
                }
            }else{
                [self error:command.callbackId];
            }
        }else{
            [self error:command.callbackId];
        }
    }else{
        [self error:command.callbackId];
    }
}

- (void)readValue:(CDVInvokedUrlCommand*)command{
    if ([self existCommandArguments:command.arguments]){
        NSString *descriptorIndex = [self parseStringFromJS:command.arguments keyFromJS:DESCRIPTOR_INDEX];
        NSString *characteristicIndex = [self parseStringFromJS:command.arguments keyFromJS:CHARACTERISTIC_INDEX];
        NSString *serviceIndex = [self parseStringFromJS:command.arguments keyFromJS:SERVICE_INDEX];
        NSString *deviceAddress = [self parseStringFromJS:command.arguments keyFromJS:DEVICE_ADDRESS];
        if ([self isNormalString:deviceAddress]){
            CBPeripheral *peripheral=[self getPeripheral:deviceAddress];
            if (peripheral) {
                if ([self isNormalString:serviceIndex]){
                    if (peripheral.services.count > [serviceIndex intValue]) {
                        CBService *service = [peripheral.services objectAtIndex:[serviceIndex intValue]];
                        if([self isNormalString:characteristicIndex]){
                            if (service.characteristics.count > [characteristicIndex intValue]){
                                CBCharacteristic *characteristic=[service.characteristics objectAtIndex:[characteristicIndex intValue]];
                                if ([self isNormalString:descriptorIndex]){
                                    if (characteristic.descriptors.count > [descriptorIndex intValue]) {
                                        [self.urlAndCallback setValue:command.callbackId forKey:READDESCRIPTOR];
                                        peripheral.delegate = self;
                                        [peripheral readValueForDescriptor:[characteristic.descriptors objectAtIndex:[descriptorIndex intValue]]];
                                    }else{
                                        [self error:command.callbackId];
                                    }
                                }else{
                                    [self.urlAndCallback setValue:command.callbackId forKey:READCHARACTERISTIC];
                                    peripheral.delegate = self;
                                    [peripheral readValueForCharacteristic:[service.characteristics objectAtIndex:[characteristicIndex intValue]]];
                                }
                            }else{
                                [self error:command.callbackId];
                            }
                        }else{
                            [self error:command.callbackId];
                        }
                    }else{
                        [self error:command.callbackId];
                    }
                }else{
                    [self error:command.callbackId];
                }
            }else{
                [self error:command.callbackId];
            }
        }else{
            [self error:command.callbackId];
        }
    } else{
        [self error:command.callbackId];
    }
}

- (void)setNotification:(CDVInvokedUrlCommand*)command{
    if ([self existCommandArguments:command.arguments]){
        [self.urlAndCallback setValue:command.callbackId forKey:SETNOTIFICATION];
        NSString *deviceAddress = [self parseStringFromJS:command.arguments keyFromJS:DEVICE_ADDRESS];
        if ([self isNormalString:deviceAddress]){
            CBPeripheral *peripheral = [self getPeripheral:deviceAddress];
            if (peripheral) {
                NSString *characteristicIndex = [self parseStringFromJS:command.arguments keyFromJS:CHARACTERISTIC_INDEX];
                NSString *serviceIndex = [self parseStringFromJS:command.arguments keyFromJS:SERVICE_INDEX];
                NSString *enable = [self parseStringFromJS:command.arguments keyFromJS:ENABLE];
                if ([self isNormalString:serviceIndex]){
                    if (peripheral.services.count > [serviceIndex intValue]) {
                        CBService *service = [peripheral.services objectAtIndex:[serviceIndex intValue]];
                        if ([self isNormalString:characteristicIndex]){
                            if (service.characteristics.count > [characteristicIndex intValue]) {
                                CBCharacteristic *characteristic = [service.characteristics objectAtIndex:[characteristicIndex intValue]];
                                peripheral.delegate = self;
                                [self.urlAndCallback setValue:enable forKey:ISON];
                                if ([enable boolValue]) {
                                    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                                }else{
                                    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
                                }
                            } else{
                                [self error:command.callbackId];
                            }
                        }else{
                            [self error:command.callbackId];
                        }
                    }else{
                        [self error:command.callbackId];
                    }
                }else{
                    [self error:command.callbackId];
                }
            }else{
                [self error:command.callbackId];
            }
        }else{
            [self error:command.callbackId];
        }
    }else{
        [self error:command.callbackId];
    }
}

- (void)getDeviceAllData:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(GATT_MODUAL)
    if ([self existCommandArguments:command.arguments]) {
        NSString *deviceAddress = [self parseStringFromJS:command.arguments keyFromJS:DEVICE_ADDRESS];
        [self.urlAndCallback setValue:command.callbackId forKey:[NSString stringWithFormat:@"perInfoCommand%@",deviceAddress]];
        if ([self isNormalString:deviceAddress]) {
            if (!self.peripheralsInfo) {
                self.peripheralsInfo=[[NSMutableArray alloc] init];
            }else{
                [self.peripheralsInfo removeAllObjects];
            }
            CBPeripheral *peripheral = [self getPeripheral:deviceAddress];
            if (peripheral) {
                self.isAddAllData=TRUE;
                peripheral.delegate=self;
                [peripheral discoverServices:nil];
            }else{
                [self error:command.callbackId];
            }
        }else{
            [self error:command.callbackId];
        }
    }else{
        [self error:command.callbackId];
    }
}

- (void)getServiceInfo:(CBPeripheral *)peripheral{
    if (peripheral.services.count > 0) {
        for (int i = 0; i < peripheral.services.count; i++) {
            CBService *service = [peripheral.services objectAtIndex:i];
            NSMutableDictionary *serviceInfo = [[NSMutableDictionary alloc] init];
            [serviceInfo setValue:[self getServiceName:service.UUID] forKey:SERVICE_NAME];
            [serviceInfo setValue:[NSString stringWithFormat:@"%@",[self CBUUIDFiltrToString:service.UUID]] forKey:SERVICE_UUID];
            [serviceInfo setValue:[NSString stringWithFormat:@"%d",i] forKey:SERVICE_INDEX];
            [self.peripheralsInfo addObject:serviceInfo];
        }
        serviceNum = 0;
        [self getCharacteristicObjects:peripheral];
    } else {
        NSString *deviceAddress = [self getPeripheralUUID:peripheral];
        NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
        [callbackInfo setValue:self.peripheralsInfo forKey:SERVICES];
        [callbackInfo setValue:deviceAddress forKey:DEVICE_ADDRESS];
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
        [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback objectForKey:[NSString stringWithFormat:@"perInfoCommand%@",deviceAddress]]];
    }
}

- (void)getCharacteristicObjects:(CBPeripheral *)peripheral{
    if (peripheral.services.count > serviceNum) {
        [peripheral discoverCharacteristics:nil forService:[peripheral.services objectAtIndex:serviceNum]];
    }
}

- (void)getAllCharacteristicInfo:(CBService *)service peripheral:(CBPeripheral *)peripheral{
    NSMutableArray *characteristicInfo=[[NSMutableArray alloc] init];
    for (int i = 0; i < service.characteristics.count; i++) {
        CBCharacteristic *characteristic = [service.characteristics objectAtIndex:i];
        NSMutableDictionary *characteristicInfoDic = [[NSMutableDictionary alloc] init];
        [characteristicInfoDic setValue:[self getServiceName:characteristic.UUID] forKey:CHARACTERISTIC_NAME];
        [characteristicInfoDic setValue:[self CBUUIDFiltrToString:characteristic.UUID] forKey:CHARACTERISTIC_UUID];
        [characteristicInfoDic setValue:[self printCharacteristicProperties:characteristic] forKey:CHARACTERISTIC_PROPERTY];
        [characteristicInfoDic setValue:[NSString stringWithFormat:@"%d",i] forKey:CHARACTERISTIC_INDEX];
        [characteristicInfo addObject:characteristicInfoDic];
    }
    [[self.peripheralsInfo objectAtIndex:serviceNum] setValue:characteristicInfo forKey:CHARACTERISTICS];
    if (self.peripheralsInfo.count-1 > serviceNum) {
        serviceNum = serviceNum+1;
        [self getCharacteristicObjects:peripheral];
    }else{
        serviceNum = 0;
        characteristicNum = 0;
        [self getDescriptorObjects:peripheral NSIntgerServiceNum:serviceNum NSIntgerCharacteristicNum:characteristicNum];
    }
}

- (void)getDescriptorObjects:(CBPeripheral *)peripheral NSIntgerServiceNum:(NSInteger)serNum NSIntgerCharacteristicNum:(NSInteger)characterNum{
    if (self.peripheralsInfo.count > serviceNum) {
        CBService *service = [peripheral.services objectAtIndex:serNum];
        if (service.characteristics.count > characterNum) {
            CBCharacteristic *characteristic=[service.characteristics objectAtIndex:characterNum];
            [peripheral discoverDescriptorsForCharacteristic:characteristic];
        }else{
            serviceNum = serviceNum + 1;
            characteristicNum = 0;
            [self getDescriptorObjects:peripheral NSIntgerServiceNum:serviceNum NSIntgerCharacteristicNum:characteristicNum];
        }
    }else{
        self.isAddAllData = FALSE;
        NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
        [callbackInfo setValue:self.peripheralsInfo forKey:SERVICES];
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
        [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback objectForKey:[NSString stringWithFormat:@"perInfoCommand%@",[self getPeripheralUUID:peripheral]]]];
    }
}

- (void)addDescriptorArray:(CBPeripheral *)peripheral CBCharacteristic:(CBCharacteristic *)characteristic{
    NSMutableArray *descriptorInfo=[[NSMutableArray alloc] init];
    for (int i = 0; i < characteristic.descriptors.count; i++) {
        CBDescriptor *descriptor = [characteristic.descriptors objectAtIndex:i];
        NSMutableDictionary *descriptorInfoDic = [[NSMutableDictionary alloc] init];
        [descriptorInfoDic setValue:[self getServiceName:descriptor.UUID] forKey:DESCRIPTOR_NAME];
        [descriptorInfoDic setValue:[self CBUUIDFiltrToString:descriptor.UUID] forKey:DESCRIPTOR_UUID];
        [descriptorInfoDic setValue:[NSString stringWithFormat:@"%d",i] forKey:DESCRIPTOR_INDEX];
        [descriptorInfo addObject:descriptorInfoDic];
    }
    [[[[self.peripheralsInfo objectAtIndex:serviceNum] objectForKey:CHARACTERISTICS] objectAtIndex:characteristicNum] setValue:descriptorInfo forKey:DESCRIPTORS];
    NSMutableArray *characteristicCount=[[self.peripheralsInfo objectAtIndex:serviceNum] objectForKey:CHARACTERISTICS];
    if (characteristicCount.count-1 > characteristicNum) {
        [self getDescriptorObjects:peripheral NSIntgerServiceNum:serviceNum NSIntgerCharacteristicNum:characteristicNum];
        characteristicNum = characteristicNum + 1;
    }else{
        serviceNum = serviceNum + 1;
        characteristicNum = 0;
        [self getDescriptorObjects:peripheral NSIntgerServiceNum:serviceNum NSIntgerCharacteristicNum:characteristicNum];
    }
}

- (void)addServices:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(1)
    if ([self existCommandArguments:command.arguments]) {
        [self.urlAndCallback setValue:command.callbackId forKey:ADDSERVICE];
        NSMutableDictionary *servicePacket=[[NSString stringWithFormat:@"%@",[command.arguments objectAtIndex:0]] JSONObject];
        NSMutableArray *services = [[NSMutableArray alloc] initWithArray:[servicePacket valueForKey:SERVICES]];
        if (services.count > 0) {
            CBMutableDescriptor *newDescriptor;
            for (int i=0; i < services.count; i++) {
                NSString *newServiceUUID = [NSString stringWithFormat:@"%@",[[services objectAtIndex:i] valueForKey:SERVICE_UUID]];
                NSString *newServiceType = [NSString stringWithFormat:@"%@",[[services objectAtIndex:i] valueForKey:SERVICE_TYPE]];
                NSString *uniqueID = [NSString stringWithFormat:@"%@",[[services objectAtIndex:i] valueForKey:UINQUE_ID]];
                NSMutableArray *characteristics = [[services objectAtIndex:i] valueForKey:CHARACTERISTICS];
                NSMutableArray *newCharacteristics = [[NSMutableArray alloc] init];
                if (characteristics.count > 0) {
                    for (int j = 0; j < characteristics.count; j++) {
                        NSString *newCharacteristicValue = [NSString stringWithFormat:@"%@",[[characteristics objectAtIndex:j] valueForKey:CHARACTERISTIC_VALUE]];
                        NSString *newCharacteristicUUID = [NSString stringWithFormat:@"%@",[[characteristics objectAtIndex:j] valueForKey:CHARACTERISTIC_UUID]];
                        NSString *onReadRequest = [NSString stringWithFormat:@"%@",[[characteristics objectAtIndex:j] valueForKey:ONREADREQUEST]];
                        NSString *onWriteRequest  = [NSString stringWithFormat:@"%@",[[characteristics objectAtIndex:j] valueForKey:ONWRIESTREQUEST]];
                        NSMutableArray *newCharacteristicProperty = [[NSMutableArray alloc] initWithArray:[[characteristics objectAtIndex:j] valueForKey:CHARACTERISTIC_PROPERTY]];
                        NSMutableArray *newCharacteristicPermission = [[NSMutableArray alloc] initWithArray:[[characteristics objectAtIndex:j] valueForKey:CHARACTERISTIC_PERMISSION]];
                        
                        NSMutableArray *descriptors = [[characteristics objectAtIndex:j] valueForKey:DESCRIPTORS];
                        BOOL addDescriptor = FALSE;
                        if (descriptors.count > 0) {
                            for (int k = 0; k < descriptors.count; k++) {
                                NSString *newDescriptorValue = [NSString stringWithFormat:@"%@",[[descriptors objectAtIndex:k] valueForKey:DESCRIPTOR_VALUE]];
                                NSString *descriptorUUID = [NSString stringWithFormat:@"%@",[[descriptors objectAtIndex:k] valueForKey:DESCRIPTOR_UUID]];
                                if ([descriptorUUID isEqualToString:@"00002901-0000-1000-8000-00805f9b34fb"]) {
                                    CBUUID * newDescriptorUUID = [CBUUID UUIDWithString:CBUUIDCharacteristicUserDescriptionString];
                                    addDescriptor = TRUE;
                                    newDescriptor = [[CBMutableDescriptor alloc] initWithType:newDescriptorUUID value:newDescriptorValue];
                                }
                            }
                        }
                        CBMutableCharacteristic *newCharacteristic = [self buildCharacteristicWithUUID:newCharacteristicUUID properties:newCharacteristicProperty value:newCharacteristicValue permissions:newCharacteristicPermission];
                        [self.writeReqAndCharacteristicDic setValue:newCharacteristic forKey:onWriteRequest];
                        [self.readReqAndCharacteristicDic setValue:newCharacteristic forKey:onReadRequest];
                        [self.valueAndCharacteristicDic setValue:newCharacteristic forKey:newCharacteristicValue];
                        if (addDescriptor) {
                            [newCharacteristic setDescriptors:@[newDescriptor]];
                        }
                        [newCharacteristics addObject:newCharacteristic];
                    }
                }
                CBMutableService *newService = [self buildServiceWithUUID:newServiceUUID primary:newServiceType];
                if (newCharacteristics.count > 0) {
                    [newService setCharacteristics:newCharacteristics];
                }
                if (!self.serviceAndKeyDic) {
                    self.serviceAndKeyDic = [[NSMutableDictionary alloc] init];
                }else{
                    [self.serviceAndKeyDic setValue:newService forKey:uniqueID];
                }
                [self.myPeripheralManager addService:newService];
                if (services.count == i + 1) {
                    self.isEndOfAddService = TRUE;
                }
            }
        }else{
            [self error:command.callbackId];
        }
    }else{
        [self error:command.callbackId];
    }
}

- (CBMutableService *)buildServiceWithUUID:(NSString *)uuidStr primary:(NSString *)primaryStr{
    CBUUID *serviceUUID = [CBUUID UUIDWithString:uuidStr];
    CBMutableService *service = [[CBMutableService alloc] initWithType:serviceUUID primary:![primaryStr boolValue]];
    return service;
}

- (CBMutableCharacteristic *)buildCharacteristicWithUUID:(NSString *)uuidStr properties:(NSMutableArray *)properties value:(NSString *)dataStr permissions:(NSMutableArray *)permissions{
    Byte byte = (Byte)[dataStr intValue];
    NSData *data = [[NSData alloc] initWithBytes:&byte length:1];
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:uuidStr];
    int propertyNum = [self property:properties] ^ CBCharacteristicPropertyRead;
    if (propertyNum == 0 || [self property:properties] == 0) {
        CBMutableCharacteristic *characteristic = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID properties:CBCharacteristicPropertyRead value:data permissions:CBAttributePermissionsReadable];
        return characteristic;
    }else{
        CBMutableCharacteristic *characteristic;
        characteristic = [[CBMutableCharacteristic alloc] initWithType:characteristicUUID properties:[self property:properties]  value:nil permissions:[self permission:permissions]];
        return characteristic;
    }
}

- (void)removeServices:(CDVInvokedUrlCommand*)command{
    BCLOG_FUNC(1)
    if ([self existCommandArguments:command.arguments]) {
        NSString *uniqueID = [self parseStringFromJS:command.arguments keyFromJS:UINQUE_ID];
        if ([self isNormalString:uniqueID]) {
            BOOL remove = FALSE;
            for (NSString *str in [self.serviceAndKeyDic allKeys]) {
                if ([str isEqualToString:uniqueID]) {
                    remove = TRUE;
                }
            }
            if (remove) {
                [self.myPeripheralManager removeService:[self.serviceAndKeyDic valueForKey:uniqueID]];
                NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
                [callbackInfo setValue:SUCCESS forKey:MES];
                CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
                [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            }else{
                [self error:command.callbackId];
            }
        }else{
            [self.myPeripheralManager removeAllServices];
            NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
            [callbackInfo setValue:SUCCESS forKey:MES];
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }
    }else{
        [self error:command.callbackId];
    }
}

- (void)notify:(CDVInvokedUrlCommand*)command{
    if ([self existCommandArguments:command.arguments]) {
        NSString *uniqueID = [self parseStringFromJS:command.arguments keyFromJS:UINQUE_ID];
        NSString *chatacteristicIndex = [self parseStringFromJS:command.arguments keyFromJS:CHARACTERISTIC_INDEX];
        NSString *dataString = [self parseStringFromJS:command.arguments keyFromJS:DATA];
        NSData *data = [NSData dataFromBase64String:dataString];
        CBMutableCharacteristic *characteristic = [self getNotifyCharacteristic:uniqueID characteristicIndex:chatacteristicIndex];
        if ([self.self.myPeripheralManager updateValue:data forCharacteristic:characteristic onSubscribedCentrals:nil]) {
        }else{
        }
    }else{
        [self error:command.callbackId];
    }
}

#pragma mark -
#pragma mark - CBperipheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
            break;
        default:
            [self error:[self.urlAndCallback objectForKey:ADDSERVICE]];
            break;
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
    if (!error) {
        if (self.isEndOfAddService) {
            self.isEndOfAddService = FALSE;
            [self.myPeripheralManager startAdvertising:@{ CBAdvertisementDataLocalNameKey : @"bcsocket", CBAdvertisementDataServiceUUIDsKey:@[[CBUUID UUIDWithString:@"0000ffe0-0000-1000-8000-00805f9b34fb"]]}];
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback objectForKey:ADDSERVICE]];
        }
    }else{
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback objectForKey:ADDSERVICE]];
    }
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic{
    CBCharacteristic *characteristicNotify = characteristic;
    CBService *service = characteristicNotify.service;
    NSMutableDictionary *callbackInfo = [self getUniqueIDWithService:service andCharacteristicIndex:characteristicNotify];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
    [result setKeepCallbackAsBool:TRUE];
    [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback valueForKey:EVENT_ONSUBSCRIBE]];
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic{
    CBCharacteristic *characteristicNotify = characteristic;
    CBService *service = characteristicNotify.service;
    NSMutableDictionary *callbackInfo = [self getUniqueIDWithService:service andCharacteristicIndex:characteristicNotify];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
    [result setKeepCallbackAsBool:TRUE];
    [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback valueForKey:EVENT_ONUNSUBSCRIBE]];
}

- (void)peripheralManagerReadyToUpdateSubscribers:(CBPeripheralManager *)peripheral{
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request{
    CBATTRequest *readRequest = request;
    CBMutableCharacteristic *characteristicRead = (CBMutableCharacteristic *)request.characteristic;
    if (request.characteristic.value == nil) {
        if ([self.valueAndCharacteristicDic allKeysForObject:characteristicRead].count > 0) {
            NSString *characteristicValue = [[NSString alloc] initWithFormat:@"%@",[[self.valueAndCharacteristicDic allKeysForObject:characteristicRead] objectAtIndex:0]];
            Byte byte = (Byte)[characteristicValue intValue];
            NSData *data = [NSData dataWithBytes:&byte length:1];
            characteristicRead.value = data;
            readRequest.value = data;
        }
    }else{
        readRequest.value = request.characteristic.value;
    }
    [peripheral respondToRequest:readRequest withResult:CBATTErrorSuccess];
    CBService *service = characteristicRead.service;
    NSMutableDictionary *callbackInfo = [self getUniqueIDWithService:service andCharacteristicIndex:characteristicRead];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
    [result setKeepCallbackAsBool:TRUE];
    [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback valueForKey:EVENT_ONCHARACTERISTICREAD]];
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests{
    CBATTRequest *writeRequest = [requests objectAtIndex:0];
    [peripheral respondToRequest:writeRequest withResult:CBATTErrorSuccess];
    CBCharacteristic *characteristicWrite = writeRequest.characteristic;
    CBService *service = characteristicWrite.service;
    NSMutableDictionary *callbackInfo = [self getUniqueIDWithService:service andCharacteristicIndex:characteristicWrite];
    [callbackInfo setValue:[self getBase64EncodedFromData:writeRequest.value] forKey:WRITEREQUESTVALUE];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
    [result setKeepCallbackAsBool:TRUE];
    [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback valueForKey:EVENT_ONCHARACTERISTICWRITE]];
    CBMutableCharacteristic *cha = [self getNotifyCharacteristic:[callbackInfo objectForKey:UINQUE_ID] characteristicIndex:[callbackInfo objectForKey:CHARACTERISTIC_INDEX]];
    cha.value = writeRequest.value;
}

#pragma mark -
#pragma mark CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if ([bluetoothState isEqualToString:BLUETOOTHSTARTSTATE]) {
        if (self.myCentralManager.state  == CBCentralManagerStatePoweredOn){
            bluetoothState = IS_TRUE;
        }else{
            bluetoothState = IS_FALSE;
        }
    }else{
        if (self.myCentralManager.state  == CBCentralManagerStatePoweredOn){
            bluetoothState = IS_TRUE;
            [self.commandDelegate evalJs:[NSString stringWithFormat:@"cordova.fireDocumentEvent('%@')",EVENT_BLUETOOTHOPEN]];
        }else{
            bluetoothState = IS_FALSE;
            [self.commandDelegate evalJs:[NSString stringWithFormat:@"cordova.fireDocumentEvent('%@')",EVENT_BLUETOOTHCLOSE]];
        }
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    if (self.isFindingPeripheral) {
        if ([[self.urlAndCallback valueForKey:PERIPHERALADDRESS] isEqual:[self getPeripheralUUID:peripheral]]) {
            [self.myCentralManager stopScan];
            [self.myCentralManager connectPeripheral:peripheral options:nil];
            self.isFindingPeripheral = FALSE;
            [stopScanTimer invalidate];
        }
    }
    NSMutableDictionary *callbackInfo = [self getScanData:peripheral adv:advertisementData rssi:RSSI];
    if ([[callbackInfo valueForKey:ADVERTISEMENT_DATA] valueForKey:LOCAL_NAME]) {
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
        [result setKeepCallbackAsBool:TRUE];
        [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback valueForKey:EVENT_NEWADVPACKET]];
        BCLOG_SCANDATA;
    }

    NSString *peripheralUUID = [self getPeripheralUUID:peripheral];
    if (self._peripherals.count == 0){
        self._peripherals = [[NSMutableArray alloc] initWithObjects:peripheral,nil];
    }else{
        BOOL isAdd = TRUE;
        for (int i = 0; i < [self._peripherals count]; i++)
        {
            CBPeripheral *oldPeripheral = [self._peripherals objectAtIndex:i];
            NSString *oldPeripheralUUID = [self getPeripheralUUID:oldPeripheral];
            if ([peripheralUUID isEqualToString:oldPeripheralUUID] == YES){
                isAdd = FALSE;
            }
        }
        if (isAdd){
            [self._peripherals addObject:peripheral];
        }
    }
    [self.advDataDic setValue:[self getAdvertisementData:advertisementData] forKey:peripheralUUID];
    [self.RSSIDic setValue:[NSString stringWithFormat:@"%@",RSSI] forKey:[self getPeripheralUUID:peripheral]];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSString *deviceAddress = [self getPeripheralUUID:peripheral];
    [self connectRequest:deviceAddress callbackId:[self.urlAndCallback valueForKey:deviceAddress] isKeepCallback:FALSE];
}

- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals{
    NSMutableArray *peripheralObjects = [NSMutableArray arrayWithArray:peripherals];
    NSMutableArray *callbackInfo = [self storePeripheralInfo:peripheralObjects];
    NSMutableArray *myPeripherals = [NSMutableArray arrayWithArray:peripherals];
    [self addPeripheralToAllPeripherals:myPeripherals];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:callbackInfo];
    [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback valueForKey:GETCONNECTEDDEVICES]];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSString *deviceAddress = [self getPeripheralUUID:peripheral];
    [self error:[self.urlAndCallback valueForKey:deviceAddress]];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)aPeripheral error:(NSError *)error
{
    NSString *deviceAddress = [self getPeripheralUUID:aPeripheral];
    if (!error) {
        [self connectRequest:deviceAddress callbackId:[self.urlAndCallback valueForKey:deviceAddress] isKeepCallback:TRUE];
        self.isAddAllData = FALSE;
    }else{
        if ([self.urlAndCallback valueForKey:deviceAddress]) {
            [self error:[self.urlAndCallback valueForKey:deviceAddress]];
        }else{
            self.isAddAllData = FALSE;
            [self connectRequest:deviceAddress callbackId:[self.urlAndCallback valueForKey:EVENT_DISCONNECT] isKeepCallback:TRUE];
        }
    }
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{
    if (!error) {
        NSString *RSSI = [NSString stringWithFormat:@"%@",[peripheral.RSSI description]];
        NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
        [callbackInfo setValue:RSSI forKey:PERIPHERAL_RSSI];
        [callbackInfo setValue:[self getPeripheralUUID:peripheral] forKey:DEVICE_ADDRESS];
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
        [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback objectForKey:[NSString stringWithFormat:@"getRssi%@",[self getPeripheralUUID:peripheral]]]];
        BCLOG_RSSI
    }else{
        [self error:[self.urlAndCallback objectForKey:[NSString stringWithFormat:@"getRssi%@",[self getPeripheralUUID:peripheral]]]];
    }
}

#pragma mark -
#pragma mark CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (self.isAddAllData) {
        [self getServiceInfo:peripheral];
    }else{
        NSString *deviceAddress = [self getPeripheralUUID:peripheral];
        if (!error) {
            NSMutableDictionary *callbackInfo = [self storeServiceInfo:peripheral];
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
            [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback valueForKey:[NSString stringWithFormat:@"getServices:%@",deviceAddress]]];
        }else{
            [self error:[self.urlAndCallback valueForKey:[NSString stringWithFormat:@"getServices:%@",deviceAddress]]];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (self.isAddAllData) {
        [self getAllCharacteristicInfo:service peripheral:peripheral];
    }else{
        NSString *deviceAddress = [self getPeripheralUUID:peripheral];
        if (!error) {
            NSMutableDictionary *callbackInfo = [self storeChatacteristicInfo:peripheral service:service];
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
            [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback objectForKey:[NSString stringWithFormat:@"%d%@",[self getServiceIndex:peripheral service:service],deviceAddress]]];
        }else{
            [self error:[self.urlAndCallback objectForKey:[NSString stringWithFormat:@"%d%@",[self getServiceIndex:peripheral service:service],[NSString stringWithFormat:@"%@",deviceAddress]]]];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (self.isAddAllData) {
        [self addDescriptorArray:peripheral CBCharacteristic:characteristic];
    }else{
        NSString *deviceAddress = [self getPeripheralUUID:peripheral];
        if (!error) {
            NSMutableDictionary *callbackInfo = [self storeDescriptorInfo:peripheral characteristic:characteristic];
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
            [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback objectForKey:[NSString stringWithFormat:@"%d%d%@",[self getCharacterIndex:characteristic.service character:characteristic],[self getServiceIndex:peripheral service:characteristic.service],deviceAddress]]];
        }else{
            [self error:[self.urlAndCallback objectForKey:[NSString stringWithFormat:@"%d%d%@",[self getCharacterIndex:characteristic.service character:characteristic],[self getServiceIndex:peripheral service:characteristic.service],deviceAddress]]];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (!error) {
        NSString *deviceAddress = [self getPeripheralUUID:peripheral];
        NSString *date = [NSString stringWithFormat:@"%@",[self getDate]];
        CBService *service = characteristic.service;
        if ([self.urlAndCallback valueForKey:ISON]) {
            NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
            NSString *serviceIndex = [NSString stringWithFormat:@"%d",[self getServiceIndex:peripheral service:service]];
            NSString *characteristicIndex = [NSString stringWithFormat:@"%d",[self getCharacterIndex:service character:characteristic]];
            NSString *value = [NSString stringWithFormat:@"%@",[self getBase64EncodedFromData:[characteristic value]]];
            BCLOG_DATA([characteristic value],@"characteristicNotify",deviceAddress,[self CBUUIDFiltrToString:characteristic.UUID])
            [callbackInfo setValue:value forKey:VALUE];
            [callbackInfo setValue:date forKey:DATE];
            [callbackInfo setValue:deviceAddress forKey:DEVICE_ADDRESS];
            [callbackInfo setValue:serviceIndex forKey:SERVICE_INDEX];
            [callbackInfo setValue:characteristicIndex forKey:CHARACTERISTIC_INDEX];
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
            [result setKeepCallbackAsBool:TRUE];
            [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback valueForKey:SETNOTIFICATION]];
        }
        if ([self.urlAndCallback valueForKey:READCHARACTERISTIC]){
            NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
            NSString *value = [NSString stringWithFormat:@"%@",[self getBase64EncodedFromData:[characteristic value]]];
            BCLOG_DATA([characteristic value],@"readCharacteristic",deviceAddress,[self CBUUIDFiltrToString:characteristic.UUID])
            [callbackInfo setValue:value forKey:VALUE];
            [callbackInfo setValue:date forKey:DATE];
            CDVPluginResult* result;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
            [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback valueForKey:READCHARACTERISTIC]];
        }
    }else{
        if ([self.urlAndCallback valueForKey:READCHARACTERISTIC]) {
            [self error:[self.urlAndCallback valueForKey:READCHARACTERISTIC]];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    if (!error) {
        NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
        NSString *date = [NSString stringWithFormat:@"%@",[self getDate]];
        NSString *descriptorValue = [NSString stringWithFormat:@"%@",descriptor.value];
        NSData *aData = [descriptorValue dataUsingEncoding: NSUTF8StringEncoding];
        BCLOG_DATA(aData,@"readDescriptor",[self getPeripheralUUID:peripheral],[self CBUUIDFiltrToString:descriptor.UUID]);
        NSData *descriptorData = [descriptorValue dataUsingEncoding:NSUTF8StringEncoding];
        NSString *value = [NSString stringWithFormat:@"%@",[self getBase64EncodedFromData:descriptorData]];
        [callbackInfo setValue:value forKey:VALUE];
        [callbackInfo setValue:date forKey:DATE];
        CDVPluginResult* result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
        [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback valueForKey:READDESCRIPTOR]];
    }else{
        [self error:[self.urlAndCallback valueForKey:READDESCRIPTOR]];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (!error) {
        NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
        [callbackInfo setValue:SUCCESS forKey:MES];
        CDVPluginResult* result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
        [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback valueForKey:WRITE]];
    }else{
        [self error:[self.urlAndCallback valueForKey:WRITE]];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    if (!error) {
        NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
        [callbackInfo setValue:SUCCESS forKey:MES];
        CDVPluginResult* result;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:callbackInfo];
        [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback valueForKey:WRITE]];
    }else{
        [self error:[self.urlAndCallback valueForKey:WRITE]];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSString *enable = [NSString stringWithFormat:@"%@",[self.urlAndCallback valueForKey:ISON]];
    if (!error) {
        if ([enable boolValue]) {
            [peripheral readValueForCharacteristic:characteristic];
        }else{
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:result callbackId:[self.urlAndCallback valueForKey:SETNOTIFICATION]];
        }
    }else{
        [self error:[self.urlAndCallback valueForKey:SETNOTIFICATION]];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(NSError *)error {
}

# pragma mark -
# pragma mark MISC
# pragma mark -

- (BOOL)existCommandArguments:(NSArray*)comArguments{
    NSMutableArray *commandArguments=[[NSMutableArray alloc] initWithArray:comArguments];
    if (commandArguments.count > 0) {
        return TRUE;
    }else{
        return FALSE;
    }
}

- (BOOL)isNormalString:(NSString*)string{
    if (![string isEqualToString:@"(null)"] && ![string isEqualToString:@"null"] && string.length > 0){
        return TRUE;
    }else{
        return FALSE;
    }
}

- (NSString*)parseStringFromJS:(NSArray*)commandArguments keyFromJS:(NSString*)key{
    NSString *string = [NSString stringWithFormat:@"%@",[[commandArguments objectAtIndex:0] valueForKey:key]];
    return string;
}

- (NSMutableArray*)parseArrayFromJS:(NSArray*)commandArguments keyFromJS:(NSString*)key{
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[[commandArguments objectAtIndex:0] valueForKey:key]];
    return array;
}

- (NSMutableDictionary*)parseDictionaryFromJS:(NSArray*)commandArguments keyFromJS:(NSString*)key{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:[[commandArguments objectAtIndex:0] valueForKey:key]];
    return dictionary;
}

- (NSString*)getBase64EncodedFromData:(NSData*)data{
    NSData *newData = [[NSData alloc] initWithData:data];
    NSString *value = [newData base64EncodedString];
    return value;
}

- (void)error:(NSString *)string{
    NSMutableDictionary *callbackInfo = [[NSMutableDictionary alloc] init];
    [callbackInfo setValue:ERROR forKey:MES];
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:callbackInfo];
    [self.commandDelegate sendPluginResult:result callbackId:string];
    BCLOG_ERROR
}

- (void)postErrorInformation{
    NSArray *symbols = [NSThread  callStackSymbols];
    if ([symbols count] > 1) {
        NSString *errorFunc = [NSString stringWithFormat:@"%@",[symbols objectAtIndex:2]];
        NSRange funcNameRange = [errorFunc rangeOfString:@"-[BCBluetooth "];
        if (funcNameRange.length > 0) {
            errorFunc = [errorFunc substringFromIndex:funcNameRange.location + funcNameRange.length];
        }
        funcNameRange = [errorFunc rangeOfString:@":]"];
        if (funcNameRange.length > 0) {
            errorFunc = [errorFunc substringToIndex:funcNameRange.location];
        }
        errorFunc = [@"error: " stringByAppendingString:errorFunc];
        [self post:errorFunc];
    }
}


- (NSMutableDictionary *)getScanData:(CBPeripheral*)peripheralObj adv:(NSDictionary*)advData rssi:(NSNumber*)RSSI{
    NSMutableDictionary *peripheralInfo = [[NSMutableDictionary alloc] init];
    NSString *peripheralUUID = [NSString stringWithFormat:@"%@",[self getPeripheralUUID:peripheralObj]];
    if ([peripheralObj name] != nil) {
        [peripheralInfo setValue:[peripheralObj name] forKey:DEVICE_NAME];
    }else {
        [peripheralInfo setValue:@"null" forKey:DEVICE_NAME];
    }
    if (peripheralUUID != nil) {
        [peripheralInfo setValue:peripheralUUID forKey:DEVICE_ADDRESS];
        if ([peripheralUUID isEqualToString:@"NULL"]) {
            [peripheralInfo setValue:@"null" forKey:DEVICE_ADDRESS];
        }
    }else {
        [peripheralInfo setValue:@"null" forKey:DEVICE_ADDRESS];
    }
    if ([peripheralObj isConnected]) {
        [peripheralInfo setValue:IS_TRUE forKey:IS_CONNECTED];
    }else {
        [peripheralInfo setValue:IS_FALSE forKey:IS_CONNECTED];
    }
    if (advData) {
        [peripheralInfo setValue:[self getAdvertisementData:advData] forKey:ADVERTISEMENT_DATA];
    }
    if (RSSI) {
        [peripheralInfo setValue:[NSString stringWithFormat:@"%@",RSSI] forKey:PERIPHERAL_RSSI];
    }
    [peripheralInfo setValue:@"BLE" forKey:@"type"];
    return peripheralInfo;
}

- (NSString*)getDate{
    NSDate *valueDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = DATE_FORMATE;
    NSString *dateString = [dateFormatter stringFromDate:valueDate];
    return dateString;
}

- (NSMutableArray*)storePeripheralInfo:(NSMutableArray*)peripheralObjs{
    NSMutableArray* callbackInfo = [[NSMutableArray alloc] init];
    if (peripheralObjs.count > 0) {
        for (int i = 0; i < peripheralObjs.count; i++)
        {
            NSMutableDictionary *peripheralInfo = [[NSMutableDictionary alloc] init];
            CBPeripheral *peripheral = [peripheralObjs objectAtIndex:i];
            NSString *peripheralUUID = [NSString stringWithFormat:@"%@",[self getPeripheralUUID:peripheral]];
            if ([peripheralObjs objectAtIndex:i] != nil){
                if ([[peripheralObjs objectAtIndex:i] name] != nil) {
                    [peripheralInfo setValue:[[peripheralObjs objectAtIndex:i] name] forKey:DEVICE_NAME];
                }else {
                    [peripheralInfo setValue:@"null" forKey:DEVICE_NAME];
                }
                if (peripheralUUID != nil) {
                    [peripheralInfo setValue:peripheralUUID forKey:DEVICE_ADDRESS];
                    if ([peripheralUUID isEqualToString:@"NULL"]) {
                        NSString *peripherialIndex = [NSString stringWithFormat:@"%d",i];
                        [peripheralInfo setValue:peripherialIndex forKey:DEVICE_ADDRESS];
                    }
                }else {
                    [peripheralInfo setValue:@"null" forKey:DEVICE_ADDRESS];
                }
                if ([[peripheralObjs objectAtIndex:i] isConnected]) {
                    [peripheralInfo setValue:IS_TRUE forKey:IS_CONNECTED];
                }else {
                    [peripheralInfo setValue:IS_FALSE forKey:IS_CONNECTED];
                }
                if (self.advDataDic) {
                    [peripheralInfo setValue:[self.advDataDic valueForKey:peripheralUUID] forKey:ADVERTISEMENT_DATA];
                }
                if (self.RSSIDic) {
                    [peripheralInfo setValue:[self.RSSIDic valueForKey:peripheralUUID] forKey:PERIPHERAL_RSSI];
                }
            }
            [callbackInfo addObject:peripheralInfo];
        }
    }
    return callbackInfo;
}

- (NSMutableDictionary *)storeServiceInfo:(CBPeripheral*)peripheral{
    NSMutableArray *servicesInfo = [[NSMutableArray alloc] init];
    for(int i = 0; i < peripheral.services.count; i++){
        CBService *service = [peripheral.services objectAtIndex:i];
        NSMutableDictionary *serviceInformation = [[NSMutableDictionary alloc] init];
        [serviceInformation setValue:[self getServiceName:service.UUID] forKey:SERVICE_NAME];
        [serviceInformation setValue:[NSString stringWithFormat:@"%@",[self CBUUIDFiltrToString:service.UUID]] forKey:SERVICE_UUID];
        [serviceInformation setValue:[NSString stringWithFormat:@"%d",i] forKey:SERVICE_INDEX];
        [servicesInfo addObject:serviceInformation];
        BCLOG_UUID(service)
    }
    NSString *deviceAddress = [self getPeripheralUUID:peripheral];
    NSMutableDictionary *serviceAndDeviceAddress = [[NSMutableDictionary alloc] init];
    [serviceAndDeviceAddress setValue:servicesInfo forKey:SERVICES];
    [serviceAndDeviceAddress setValue:deviceAddress forKey:DEVICE_ADDRESS];
    return serviceAndDeviceAddress;
}

- (NSMutableDictionary *)storeChatacteristicInfo:(CBPeripheral*)peripheral service:(CBService*)service{
    NSMutableArray *characteristicsInfo = [[NSMutableArray alloc] init];
    for (int i = 0; i < service.characteristics.count; i++) {
        CBCharacteristic *character = [service.characteristics objectAtIndex:i];
        NSMutableDictionary *characteristicInformation = [[NSMutableDictionary alloc] init];
        [characteristicInformation setValue:[self getServiceName:character.UUID] forKey:CHARACTERISTIC_NAME];
        [characteristicInformation setValue:[self CBUUIDFiltrToString:character.UUID] forKey:CHARACTERISTIC_UUID];
        [characteristicInformation setValue:[self printCharacteristicProperties:character] forKey:CHARACTERISTIC_PROPERTY];
        [characteristicInformation setValue:[NSString stringWithFormat:@"%d",i] forKey:CHARACTERISTIC_INDEX];
        [characteristicsInfo addObject:characteristicInformation];
        BCLOG_UUID(character)
    }
    NSString *deviceAddress = [self getPeripheralUUID:peripheral];
    NSMutableDictionary *characteristicAndDeviceAddress = [[NSMutableDictionary alloc] init];
    [characteristicAndDeviceAddress setValue:characteristicsInfo forKey:CHARACTERISTICS];
    [characteristicAndDeviceAddress setValue:deviceAddress forKey:DEVICE_ADDRESS];
    return characteristicAndDeviceAddress;
}

- (NSMutableDictionary *)storeDescriptorInfo:(CBPeripheral*)peripheral characteristic:(CBCharacteristic*)characteristic{
    NSMutableArray *descriptorsInfo = [[NSMutableArray alloc] init];
    for (int i = 0; i < characteristic.descriptors.count; i++) {
        CBDescriptor *descriptor = [characteristic.descriptors objectAtIndex:i];
        NSMutableDictionary *descriptorInformation = [[NSMutableDictionary alloc] init];
        [descriptorInformation setValue:[self getServiceName:descriptor.UUID] forKey:DESCRIPTOR_NAME];
        [descriptorInformation setValue:[self CBUUIDFiltrToString:descriptor.UUID] forKey:DESCRIPTOR_UUID];
        [descriptorInformation setValue:[NSString stringWithFormat:@"%d",i] forKey:DESCRIPTOR_INDEX];
        [descriptorsInfo addObject:descriptorInformation];
        BCLOG_UUID(descriptor)
    }
    NSString *deviceAddress = [self getPeripheralUUID:peripheral];
    NSMutableDictionary *descriptorAndDeviceAddress = [[NSMutableDictionary alloc] init];
    [descriptorAndDeviceAddress setValue:descriptorsInfo forKey:DESCRIPTORS];
    [descriptorAndDeviceAddress setValue:deviceAddress forKey:DEVICE_ADDRESS];
    return descriptorAndDeviceAddress;
}

- (void)addPeripheralToAllPeripherals:(NSMutableArray*)peripheralObj{
    if (self._peripherals.count == 0) {
        if (peripheralObj.count > 0) {
            for (int j = 0; j < peripheralObj.count; j++) {
                CBPeripheral *myPeripheral = [peripheralObj objectAtIndex:j];
                [self._peripherals addObject:myPeripheral];
            }
        }
    }else{
        if (peripheralObj.count > 0) {
            for (int i = 0; i < peripheralObj.count; i++) {
                BOOL isAddAll = TRUE;
                CBPeripheral *myPeripheral = [peripheralObj objectAtIndex:i];
                NSString *myPeripheralUUID = [self getPeripheralUUID:myPeripheral];
                for (int j = 0; j < self._peripherals.count; j++) {
                    CBPeripheral *peripheralFromAll = [self._peripherals objectAtIndex:j];
                    NSString *peripheralFromAllUUID = [self getPeripheralUUID:peripheralFromAll];
                    if ([myPeripheralUUID isEqualToString:peripheralFromAllUUID] == YES){
                        isAddAll = FALSE;
                    }
                }
                if (isAddAll){
                    [self._peripherals addObject:myPeripheral];
                }
            }
        }
    }
}

- (CBCharacteristicProperties )property:(NSArray *)propertyArr{
    CBCharacteristicProperties property = 0;
    if (propertyArr.count > 0) {
        for (int i = 0; i < propertyArr.count; i++) {
            if ([[propertyArr objectAtIndex:i] isEqualToString:PROPERTY_READ]){
                property = property | CBCharacteristicPropertyRead;
            }
            if ([[propertyArr objectAtIndex:i] isEqualToString:PROPERTY_WRITE_WITHOUT_RESPONSE]){
                property = property | CBCharacteristicPropertyWriteWithoutResponse;
            }
            if ([[propertyArr objectAtIndex:i] isEqualToString:PROPERTY_WRITE]){
                property = property | CBCharacteristicPropertyWrite;
            }
            if ([[propertyArr objectAtIndex:i] isEqualToString:PROPERTY_NOTIFY]){
                property = property | CBCharacteristicPropertyNotify;
            }
            if ([[propertyArr objectAtIndex:i] isEqualToString:PROPERTY_INDICATE]){
                property = property | CBCharacteristicPropertyIndicate;
            }
            if ([[propertyArr objectAtIndex:i] isEqualToString:PROPERTY_AUTHENTICATED_SIGNED_WTRTES]){
                property = property | CBCharacteristicPropertyAuthenticatedSignedWrites;
            }
            if ([[propertyArr objectAtIndex:i] isEqualToString:PROPERTY_NOTIFY_ENCRYPTION_REQUIRED]){
                property = property | CBCharacteristicPropertyNotifyEncryptionRequired;
            }
            if ([[propertyArr objectAtIndex:i] isEqualToString:PROPERTY_INDICATE_ENCRYPTION_REQUIRED]){
                property = property | CBCharacteristicPropertyIndicateEncryptionRequired;
            }
        }
    }
    return property;
}

- (CBAttributePermissions )permission:(NSArray *)propertyArr{
    CBAttributePermissions permission = 0;
    if (propertyArr.count > 0) {
        for (int i = 0; i < propertyArr.count; i++) {
            if ([[propertyArr objectAtIndex:i] isEqualToString:PERMISSION_READ]){
                permission = permission | CBAttributePermissionsReadable;
            }
            if ([[propertyArr objectAtIndex:i] isEqualToString:PERMISSION_WRITE]){
                permission = permission | CBAttributePermissionsWriteable;
            }
            if ([[propertyArr objectAtIndex:i] isEqualToString:PERMISSION_READ_ENCRYPTED]){
                permission = permission | CBAttributePermissionsReadEncryptionRequired;
            }
            if ([[propertyArr objectAtIndex:i] isEqualToString:PERMISSION_WRITE_ENCRYPTED]){
                permission = permission | CBAttributePermissionsWriteEncryptionRequired;
            }
        }
        return permission;
    }else{
        return 0x00;
    }
}

- (NSString *)CBUUIDFiltrToString:(CBUUID *)UUID{
    NSString *results = [UUID.data description];
    if (results.length<16) {
        results = [results stringByReplacingOccurrencesOfString:@"<" withString:@"0000"];
        results = [results stringByReplacingOccurrencesOfString:@">" withString:@"-0000-1000-8000-00805f9b34fb"];
    }else{
        results = [results stringByReplacingOccurrencesOfString:@"<" withString:@""];
        results = [results stringByReplacingOccurrencesOfString:@">" withString:@""];
    }
    return results;
}

- (NSString *)UUIDFiltrToString:(CBUUID *)UUID{
    NSString *results = [UUID.data description];
    results = [results stringByReplacingOccurrencesOfString:@"<" withString:@""];
    results = [results stringByReplacingOccurrencesOfString:@">" withString:@""];
    return results;
}

- (const char *) UUIDToString:(CFUUIDRef)UUID {
    if (!UUID){
        return "NULL";
    }
    NSString *uuid = CFBridgingRelease(CFUUIDCreateString(nil,UUID));
    const char *char_content = [uuid cStringUsingEncoding:NSASCIIStringEncoding];
    return char_content;
}

- (NSMutableArray *)getUUIDArr:(NSMutableArray *)array{
    if (array.count > 0) {
        NSMutableArray *UUIDs = [[NSMutableArray alloc] init];
        for (int i = 0; i < array.count; i++) {
            NSString *uuidStr = [array objectAtIndex:i];
            CBUUID *uuid = [CBUUID UUIDWithNSUUID:[[NSUUID alloc] initWithUUIDString:uuidStr]];
            [UUIDs addObject:uuid];
        }
        return UUIDs;
    }else{
        return nil;
    }
}

- (CBPeripheral *)getPeripheral:(NSString *)strDeviceAddress{
    CBPeripheral *peripheral=nil;
    if (self._peripherals.count > 0) {
        for (int i = 0; i < [self._peripherals count]; i++)
        {
            CBPeripheral* peripheral = [self._peripherals objectAtIndex:i];
            const char *peripheralUUIDChar = [self UUIDToString:peripheral.UUID];
            NSString *peripheralUUIDStr = [NSString stringWithFormat:@"%s",peripheralUUIDChar];
            if ([[[NSUUID alloc] initWithUUIDString:peripheralUUIDStr] isEqual:[[NSUUID alloc] initWithUUIDString:strDeviceAddress]]) {
                return peripheral;
            }
            NSString *peripheralIndex = [NSString stringWithFormat:@"%d",i];
            if([peripheralIndex isEqualToString:strDeviceAddress]){
                return peripheral;
            }
        }
    }
    return peripheral;
}

- (NSString *)getPeripheralUUID:(CBPeripheral *)peripheral{
    CBPeripheral *newPeripheral = peripheral;
    const char *newPeripheralUUIDChar = [self UUIDToString:newPeripheral.UUID];
    if (!newPeripheralUUIDChar) {
        NSString *newPeripheralUUIDStr = NOTAVAILABLE;
        return newPeripheralUUIDStr;
    }else{
        NSString *newPeripheralUUIDStr = [NSString stringWithFormat:@"%s",newPeripheralUUIDChar];
        return newPeripheralUUIDStr;
    }
}

- (int)getServiceIndex:(CBPeripheral *)peripheral service:(CBService *)service{
    CBPeripheral *newPeripheral = peripheral;
    int serviceIndex = 0;
    if (newPeripheral.services.count > 0) {
        for (int i = 0; i < newPeripheral.services.count; i++) {
            if ([service isEqual:[newPeripheral.services objectAtIndex:i]]) {
                serviceIndex = i;
            }
        }
    }
    return serviceIndex;
}

- (int)getCharacterIndex:(CBService *)service character:(CBCharacteristic *)characteristic{
    int characteristicIndex = 0;
    if (service.characteristics.count > 0) {
        for (int i = 0; i < service.characteristics.count; i++) {
            if ([characteristic isEqual:[service.characteristics objectAtIndex:i]]) {
                characteristicIndex = i;
            }
        }
    }
    return characteristicIndex;
}

- (NSMutableDictionary *)getUniqueIDWithService:(CBService *)service andCharacteristicIndex:(CBCharacteristic *)characteristic{
    if ([self.serviceAndKeyDic allKeys].count > 0) {
        NSMutableDictionary *uniqueIDAndCharacteristicIndex = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < [self.serviceAndKeyDic allKeys].count; i++) {
            if ([service isEqual:[self.serviceAndKeyDic valueForKey:[[self.serviceAndKeyDic allKeys] objectAtIndex:i]]]) {
                NSString *uniqueID = [[self.serviceAndKeyDic allKeys] objectAtIndex:i];
                [uniqueIDAndCharacteristicIndex setValue:uniqueID forKey:UINQUE_ID];
                if (service.characteristics.count > 0) {
                    for (int j = 0; j < service.characteristics.count; j++) {
                        if ([characteristic isEqual:[service.characteristics objectAtIndex:j]]) {
                            NSString *characteristicIndex = [NSString stringWithFormat:@"%d",j];
                            [uniqueIDAndCharacteristicIndex setValue:characteristicIndex forKey:CHARACTERISTIC_INDEX];
                        }
                    }
                }
                
            }
        }
        return uniqueIDAndCharacteristicIndex;
    }else{
        return nil;
    }
}

- (CBMutableCharacteristic *)getNotifyCharacteristic:(NSString *)uniqueID characteristicIndex:(NSString *)characteristicIndex{
    if ([self isNormalString:uniqueID]) {
        if ([self isNormalString:characteristicIndex]) {
            CBMutableService *service = [self.serviceAndKeyDic objectForKey:uniqueID];
            if ([characteristicIndex intValue] < service.characteristics.count) {
                CBMutableCharacteristic *characterristic = [service.characteristics objectAtIndex:[characteristicIndex intValue]];
                return characterristic;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

- (NSMutableDictionary *)getAdvertisementData:(NSDictionary *)advertisementData
{
    NSMutableDictionary *advertisementDataDic = [[NSMutableDictionary alloc] init];
    NSMutableArray *serviceUUIDs = [[NSMutableArray alloc] init];
    NSMutableArray *overFlowServiceUUIDs = [[NSMutableArray alloc] init];
    NSMutableArray *solicitServiceUUIDs = [[NSMutableArray alloc] init];
    if ([advertisementData valueForKey:KCBADVDATA_LOCALNAME]){
        NSString *localName = [NSString stringWithFormat:@"%@",[advertisementData valueForKey:KCBADVDATA_LOCALNAME]];
        [advertisementDataDic setValue:localName forKey:LOCAL_NAME];
    }
    if ([advertisementData valueForKey:KCBADVDATA_SERVICE_UUIDS]){
        NSMutableArray *advServiceUUIDs = [advertisementData valueForKey:KCBADVDATA_SERVICE_UUIDS];
        for (int i = 0; i < advServiceUUIDs.count; i++) {
            CBUUID *UUID = [[advertisementData valueForKey:KCBADVDATA_SERVICE_UUIDS] objectAtIndex:i];
            NSString *UUIDStr = [self UUIDFiltrToString:UUID];
            [serviceUUIDs addObject:UUIDStr];
        }
        [advertisementDataDic setValue:serviceUUIDs forKey:SERVICE_UUIDS];
    }
    if ([advertisementData valueForKey:KCBADVDATA_TXPOWER_LEVEL]){
        NSString *txPowerLevel = [NSString stringWithFormat:@"%@",[advertisementData valueForKey:KCBADVDATA_TXPOWER_LEVEL]];
        [advertisementDataDic setValue:txPowerLevel forKey:TXPOWER_LEVEL];
    }
    if ([advertisementData valueForKey:KCBADVDATA_SERVICE_DATA]){
        NSString *serviceData = [NSString stringWithFormat:@"%@",[advertisementData valueForKey:KCBADVDATA_SERVICE_DATA]];
        [advertisementDataDic setValue:serviceData forKey:SERVICE_DATA];
    }
    if ([advertisementData valueForKey:KCBADVDATALOCAL_NAME]){
        NSData *manufacturer = [advertisementData valueForKey:KCBADVDATALOCAL_NAME];
        NSString *manufacturerData = [NSString stringWithFormat:@"%@",[self getBase64EncodedFromData:manufacturer]];
        [advertisementDataDic setValue:manufacturerData forKey:MANUFACTURER_DATA];
    }
    if ([advertisementData valueForKey:KCBADVDATA_OVERFLOW_SERVICE_UUIDS]){
        NSMutableArray *overFlowAdvServiceUUIDs = [advertisementData valueForKey:KCBADVDATA_OVERFLOW_SERVICE_UUIDS];
        for (int i = 0; i < overFlowAdvServiceUUIDs.count; i++) {
            CBUUID *UUID = [[advertisementData valueForKey:KCBADVDATA_OVERFLOW_SERVICE_UUIDS] objectAtIndex:i];
            NSString *UUIDStr = [self UUIDFiltrToString:UUID];
            [overFlowServiceUUIDs addObject:UUIDStr];
        }
        [advertisementDataDic setValue:overFlowServiceUUIDs forKey:OVERFLOW_SERVICE_UUIDS];
    }
    if ([advertisementData valueForKey:KCBADVDATA_ISCONNECTABLE]){
        NSString *isConnectable = [NSString stringWithFormat:@"%@",[advertisementData valueForKey:KCBADVDATA_ISCONNECTABLE]];
        [advertisementDataDic setValue:isConnectable forKey:ISCONNECTABLE];
    }
    if ([advertisementData valueForKey:KCBADCDATA_SOLICITED_SERVICE_UUIDS]){
        NSMutableArray *solicitedAdvServiceUUIDs = [advertisementData valueForKey:KCBADCDATA_SOLICITED_SERVICE_UUIDS];
        for (int i = 0; i < solicitedAdvServiceUUIDs.count; i++) {
            CBUUID *UUID = [[advertisementData valueForKey:KCBADCDATA_SOLICITED_SERVICE_UUIDS] objectAtIndex:i];
            NSString *UUIDStr = [self UUIDFiltrToString:UUID];
            [solicitServiceUUIDs addObject:UUIDStr];
        }
        [advertisementDataDic setValue:solicitServiceUUIDs forKey:SOLICITED_SERVICE_UUIDS];
    }
    return advertisementDataDic;
}

- (NSMutableArray *)printCharacteristicProperties:(CBCharacteristic *)characteristic
{
    CBCharacteristicProperties property = [characteristic properties];
    NSMutableArray *characteristicProperty = [[NSMutableArray alloc] init];
    if (property & CBCharacteristicPropertyRead){
        NSString *read = PROPERTY_READ;
        [characteristicProperty addObject:read];
    }
    if (property & CBCharacteristicPropertyWriteWithoutResponse){
        NSString *writeWithoutResponse = PROPERTY_WRITE_WITHOUT_RESPONSE;
        [characteristicProperty addObject:writeWithoutResponse];
    }
    if (property & CBCharacteristicPropertyWrite){
        NSString *write = PROPERTY_WRITE;
        [characteristicProperty addObject:write];
    }
    if (property & CBCharacteristicPropertyNotify){
        NSString *notify = PROPERTY_NOTIFY;
        [characteristicProperty addObject:notify];
    }
    if (property & CBCharacteristicPropertyIndicate) {
        NSString *indicate = PROPERTY_INDICATE;
        [characteristicProperty addObject:indicate];
    }
    if (property & CBCharacteristicPropertyAuthenticatedSignedWrites){
        NSString *authenticatedSignedWrites = PROPERTY_AUTHENTICATED_SIGNED_WTRTES;
        [characteristicProperty addObject:authenticatedSignedWrites];
    }
    if (property & CBCharacteristicPropertyNotifyEncryptionRequired){
        NSString *notifyEncryptionRequired = PROPERTY_NOTIFY_ENCRYPTION_REQUIRED;
        [characteristicProperty addObject:notifyEncryptionRequired];
    }
    if (property & CBCharacteristicPropertyIndicateEncryptionRequired){
        NSString *indicateEncryptionRequired = PROPERTY_INDICATE_ENCRYPTION_REQUIRED;
        [characteristicProperty addObject:indicateEncryptionRequired];
    }
    return characteristicProperty;
}

- (UInt16) CBUUIDToInt:(CBUUID *) UUID {
    char b1[16];
    [UUID.data getBytes:b1];
    return ((b1[0] << 8) | b1[1]);
}

- (NSString *)getServiceName:(CBUUID *)UUID{
    UInt16 _uuid = [self CBUUIDToInt:UUID];
    switch(_uuid)
    {
        case 0x1800: return @"Generic Access"; break;
        case 0x1801: return @"Generic Attribute"; break;
        case 0x1802: return @"Immediate Alert"; break;
        case 0x1803: return @"Link Loss"; break;
        case 0x1804: return @"Tx Power"; break;
        case 0x1805: return @"Current Time Service"; break;
        case 0x1806: return @"Reference Time Update Service"; break;
        case 0x1807: return @"Next DST Change Service"; break;
        case 0x1808: return @"Glucose"; break;
        case 0x1809: return @"Health Thermometer"; break;
        case 0x180A: return @"Device Information"; break;
        case 0x180B: return @"Network Availability Service"; break;
        case 0x180C: return @"Watchdog"; break;
        case 0x180D: return @"Heart Rate"; break;
        case 0x180E: return @"Phone Alert Status Service"; break;
        case 0x180F: return @"Battery Service"; break;
        case 0x1810: return @"Blood Pressure"; break;
        case 0x1811: return @"Alert Notification Service"; break;
        case 0x1812: return @"Human Interface Device"; break;
        case 0x1813: return @"Scan Parameters"; break;
        case 0x1814: return @"RUNNING SPEED AND CADENCE"; break;
        case 0x1815: return @"Automation IO"; break;
        case 0x1816: return @"Cycling Speed and Cadence"; break;
        case 0x1817: return @"Pulse Oximeter"; break;
        case 0x1818: return @"Cycling Power Service"; break;
        case 0x1819: return @"Location and Navigation Service"; break;
        case 0x181A: return @"Continous Glucose Measurement Service"; break;
        case 0x2A00: return @"Device Name"; break;
        case 0x2A01: return @"Appearance"; break;
        case 0x2A02: return @"Peripheral Privacy Flag"; break;
        case 0x2A03: return @"Reconnection Address"; break;
        case 0x2A04: return @"Peripheral Preferred Connection Parameters"; break;
        case 0x2A05: return @"Service Changed"; break;
        case 0x2A06: return @"Alert Level"; break;
        case 0x2A07: return @"Tx Power Level"; break;
        case 0x2A08: return @"Date Time"; break;
        case 0x2A09: return @"Day of Week"; break;
        case 0x2A0A: return @"Day Date Time"; break;
        case 0x2A0B: return @"Exact Time 100"; break;
        case 0x2A0C: return @"Exact Time 256"; break;
        case 0x2A0D: return @"DST Offset"; break;
        case 0x2A0E: return @"Time Zone"; break;
        case 0x2A0F: return @"Local Time Information"; break;
        case 0x2A10: return @"Secondary Time Zone"; break;
        case 0x2A11: return @"Time with DST"; break;
        case 0x2A12: return @"Time Accuracy"; break;
        case 0x2A13: return @"Time Source"; break;
        case 0x2A14: return @"Reference Time Information"; break;
        case 0x2A15: return @"Time Broadcast"; break;
        case 0x2A16: return @"Time Update Control Point"; break;
        case 0x2A17: return @"Time Update State"; break;
        case 0x2A18: return @"Glucose Measurement"; break;
        case 0x2A19: return @"Battery Level"; break;
        case 0x2A1A: return @"Battery Power State"; break;
        case 0x2A1B: return @"Battery Level State"; break;
        case 0x2A1C: return @"Temperature Measurement"; break;
        case 0x2A1D: return @"Temperature Type"; break;
        case 0x2A1E: return @"Intermediate Temperature"; break;
        case 0x2A1F: return @"Temperature in Celsius"; break;
        case 0x2A20: return @"Temperature in Fahrenheit"; break;
        case 0x2A21: return @"Measurement Interval"; break;
        case 0x2A22: return @"Boot Keyboard Input Report"; break;
        case 0x2A23: return @"System ID"; break;
        case 0x2A24: return @"Model Number String"; break;
        case 0x2A25: return @"Serial Number String"; break;
        case 0x2A26: return @"Firmware Revision String"; break;
        case 0x2A27: return @"Hardware Revision String"; break;
        case 0x2A28: return @"Software Revision String"; break;
        case 0x2A29: return @"Manufacturer Name String"; break;
        case 0x2A2A: return @"IEEE 11073-20601 Regulatory Certification Data List"; break;
        case 0x2A2B: return @"Current Time"; break;
        case 0x2A2C: return @"Elevation"; break;
        case 0x2A2D: return @"Latitude"; break;
        case 0x2A2E: return @"Longitude"; break;
        case 0x2A2F: return @"Position 2D"; break;
        case 0x2A30: return @"Position 3D"; break;
        case 0x2A31: return @"Scan Refresh"; break;
        case 0x2A32: return @"Boot Keyboard Output Report"; break;
        case 0x2A33: return @"Boot Mouse Input Report"; break;
        case 0x2A34: return @"Glucose Measurement Context"; break;
        case 0x2A35: return @"Blood Pressure Measurement"; break;
        case 0x2A36: return @"Intermediate Cuff Pressure"; break;
        case 0x2A37: return @"Heart Rate Measurement"; break;
        case 0x2A38: return @"Body Sensor Location"; break;
        case 0x2A39: return @"Heart Rate Control Point"; break;
        case 0x2A3A: return @"Removable"; break;
        case 0x2A3B: return @"Service Required"; break;
        case 0x2A3C: return @"Scientific Temperature in Celsius"; break;
        case 0x2A3D: return @"String"; break;
        case 0x2A3E: return @"Network Availability"; break;
        case 0x2A3F: return @"Alert Status"; break;
        case 0x2A40: return @"Ringer Control Point"; break;
        case 0x2A41: return @"Ringer Setting"; break;
        case 0x2A42: return @"Alert Category ID Bit Mask"; break;
        case 0x2A43: return @"Alert Category ID"; break;
        case 0x2A44: return @"Alert Notification Control Point"; break;
        case 0x2A45: return @"Unread Alert Status"; break;
        case 0x2A46: return @"New Alert"; break;
        case 0x2A47: return @"Supported New Alert Category"; break;
        case 0x2A48: return @"Supported Unread Alert Category"; break;
        case 0x2A49: return @"Blood Pressure Feature"; break;
        case 0x2A4A: return @"HID Information"; break;
        case 0x2A4B: return @"Report Map"; break;
        case 0x2A4C: return @"HID Control Point"; break;
        case 0x2A4D: return @"Report"; break;
        case 0x2A4E: return @"Protocol Mode"; break;
        case 0x2A4F: return @"Scan Interval Window"; break;
        case 0x2A50: return @"PnP ID"; break;
        case 0x2A51: return @"Glucose Features"; break;
        case 0x2A52: return @"Record Access Control Point"; break;
        case 0x2A53: return @"RSC Measurement"; break;
        case 0x2A54: return @"RSC Feature"; break;
        case 0x2A55: return @"SC Control Point"; break;
        case 0x2A56: return @"Digital Input"; break;
        case 0x2A57: return @"Digital Output"; break;
        case 0x2A58: return @"Analog Input"; break;
        case 0x2A59: return @"Analog Output"; break;
        case 0x2A5A: return @"Aggregate Input"; break;
        case 0x2A5B: return @"CSC Measurement"; break;
        case 0x2A5C: return @"CSC Feature"; break;
        case 0x2A5D: return @"Sensor Location"; break;
        case 0x2A5E: return @"Pulse Oximetry Spot-check Measurement"; break;
        case 0x2A5F: return @"Pulse Oximetry Continuous Measurement"; break;
        case 0x2A60: return @"Pulse Oximetry Pulsatile Event"; break;
        case 0x2A61: return @"Pulse Oximetry Features"; break;
        case 0x2A62: return @"Pulse Oximetry Control Point"; break;
        case 0x2A63: return @"Cycling Power Measurement Characteristic"; break;
        case 0x2A64: return @"Cycling Power Vector Characteristic"; break;
        case 0x2A65: return @"Cycling Power Feature Characteristic"; break;
        case 0x2A66: return @"Cycling Power Control Point Characteristic"; break;
        case 0x2A67: return @"Location and Speed Characteristic"; break;
        case 0x2A68: return @"Navigation Characteristic"; break;
        case 0x2A69: return @"Position Quality Characteristic"; break;
        case 0x2A6A: return @"LN Feature Characteristic"; break;
        case 0x2A6B: return @"LN Control Point Characteristic"; break;
        case 0x2A6C: return @"CGM Measurement Characteristic"; break;
        case 0x2A6D: return @"CGM Features Characteristic"; break;
        case 0x2A6E: return @"CGM Status Characteristic"; break;
        case 0x2A6F: return @"CGM Session Start Time Characteristic"; break;
        case 0x2A70: return @"Application Security Point Characteristic"; break;
        case 0x2A71: return @"CGM Specific Ops Control Point Characteristic"; break;
        default:
            return @"Custom Profile";
            break;
    }
}

# pragma mark -
# pragma mark DEBUG
# pragma mark -

- (void)logFunc:(int)modualNumber information:(NSString *)information{
    NSRange foundModual = [information rangeOfString:@" "];
    if (foundModual.length > 0) {
        information = [information substringFromIndex:foundModual.location + foundModual.length];
        information = [information stringByReplacingOccurrencesOfString:@":]" withString:@""];
    }
    if (modualNumber == GAP_MODUAL) {
        information = [@"gap: enter " stringByAppendingString:information];
    }if (modualNumber == GATT_MODUAL) {
        information = [@"gatt: enter " stringByAppendingString:information];
    }if (modualNumber == DATA_MODUAL) {
        information = [@"data: enter " stringByAppendingString:information];
    }
    [self post:information];
}

- (void)logRSSI:(NSString *)information device:(NSString *)deviceUUID{
    NSString *getRssi = [NSString stringWithFormat:@"device = %@  get rssi = %@",deviceUUID,information];
    [self post:getRssi];
}

- (void)logScanDeviceUUID:(NSString *)deviceUUID RSSI:(NSString *)deviceRSSI{
    NSString *scanDeviceInfo = [NSString stringWithFormat:@"device = %@  scan rssi = %@",deviceUUID,deviceRSSI];
    [self post:scanDeviceInfo];
}

- (void)logUUID:(CBUUID *)UUID{
    NSString *results = [UUID.data description];
    results = [results stringByReplacingOccurrencesOfString:@"<" withString:@""];
    results = [results stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSString *result = [NSString stringWithFormat:@"uuid = %@",results];
    [self post:result];
}

- (void)logValue:(NSData *)value operation:(NSString *)operation device:(NSString *)deviceUUID UUID:(NSString *)UUID{
    [self post:[@"data: " stringByAppendingString:[NSString stringWithFormat:@"%@ :",operation]]];
    [self post:[NSString stringWithFormat:@"device = %@",deviceUUID]];
    [self post:[NSString stringWithFormat:@"uuid = %@",UUID]];
    [self post:@"value:"];

    Byte *valueByte = (Byte *)[value bytes];
    NSString *valueString = [NSString stringWithFormat:@"%@",value];
    valueString = [valueString uppercaseString];
    valueString = [valueString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    valueString = [valueString stringByReplacingOccurrencesOfString:@">" withString:@""];
    valueString = [valueString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger valueStringLength = valueString.length;
    for (int j = 0; j < valueStringLength / 16 + 1; j++) {
        NSString *valueInfo = @"";
        NSMutableString *result = [[NSMutableString alloc] init];
        NSString *asciiString;
        if (valueString.length <= 16) {
            result = [[NSMutableString alloc] initWithString:valueString];
            for (int i = 0; i < valueString.length / 2; i++) {
                [result insertString:@" " atIndex:2 + 2 * i + i];
            }
            asciiString = [self getAsciiString:valueByte infoDataLength:valueString.length / 2 byteIndex:j * 8];
            for (int k = 0; k < 8 - valueString.length / 2; k++) {
                asciiString = [@"     " stringByAppendingString:asciiString];
            }
            j++;
            valueInfo = [self changeToHexString:(j-1) * 8];
        }else{
            NSString *subString = [valueString substringToIndex:16];
            result = [[NSMutableString alloc] initWithString:subString];
            valueString = [valueString substringFromIndex:16];
            for (int i = 0; i < subString.length / 2; i++) {
                [result insertString:@" " atIndex:2 + 2 * i + i];
            }
            asciiString = [self getAsciiString:valueByte infoDataLength:8 byteIndex:j * 8];
            valueInfo = [self changeToHexString:j * 8];
        }
        valueInfo = [valueInfo stringByAppendingString:(NSString *)result];
        valueInfo = [valueInfo stringByAppendingString:asciiString];
        [self post:valueInfo];
    }
}

- (NSString *)getAsciiString:(Byte *)byte infoDataLength:(int)infoDataLength byteIndex:(int)byteIndex{
    NSString *result = [[NSString alloc] init];
    for (int i = 0; i < infoDataLength; i++) {
        NSData *data = [[NSData alloc] initWithBytes:&byte[i + byteIndex] length:1];
        NSString *asciiString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        if (byte[i + byteIndex] < 34 || byte[i + byteIndex] > 125) {
            result = [result stringByAppendingString:@"."];
        }else{
            result = [result stringByAppendingString:asciiString];
        }
    }
    result = [NSString stringWithFormat:@"     %@",result];
    return result;
}

-(NSString *)changeToHexString:(long long int)num
{
    NSString *letterOfHexValue;
    NSString *result =@"";
    long long int remainderNum;
    for (int i = 0; i < 9; i++) {
        remainderNum=num % 16;
        num=num / 16;
        switch (remainderNum)
        {
            case 10:
                letterOfHexValue =@"A";break;
            case 11:
                letterOfHexValue =@"B";break;
            case 12:
                letterOfHexValue =@"C";break;
            case 13:
                letterOfHexValue =@"D";break;
            case 14:
                letterOfHexValue =@"E";break;
            case 15:
                letterOfHexValue =@"F";break;
            default:letterOfHexValue=[[NSString alloc]initWithFormat:@"%lli",remainderNum];
                
        }
        result = [letterOfHexValue stringByAppendingString:result];
        if (num == 0) {
            break;
        }
    }
    if (result.length < 4) {
        for (int i = 0; i < 4 - result.length; ) {
            result = [@"0" stringByAppendingString:result];
        }
    }
    result = [result stringByAppendingString:@" : "];
    return result;
}

- (void)post:(NSString *)info{
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGINFORMATION object:info];
}

@end