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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <Cordova/NSDictionary+Extensions.h>
#import <Cordova/NSArray+Comparisons.h>
#import <CoreBluetooth/CBService.h>
#import <Cordova/CDVPlugin.h>
#import <Cordova/NSData+Base64.h>
#import <Cordova/CDVJSON.h>
#import <CoreLocation/CoreLocation.h>

#import "ManagerEntity.h"
@interface BCBluetooth : CDVPlugin <CBCentralManagerDelegate, CBPeripheralDelegate,CBPeripheralManagerDelegate,CLLocationManagerDelegate>
{
    NSTimer *stopScanTimer;
    NSInteger serviceNum;
    NSInteger characteristicNum;
    NSString *device_address;

}

@property (strong, nonatomic) NSString *bluetoothState;
@property (strong, nonatomic) NSMutableDictionary  *urlAndCallback;

@property (strong, nonatomic) NSMutableArray *_peripherals;

@property (strong, nonatomic) NSMutableArray *peripheralsInfo;
@property (strong, nonatomic) NSMutableDictionary *advDataDic;
@property (strong, nonatomic) NSMutableDictionary *RSSIDic;

@property (strong, nonatomic) NSMutableDictionary *serviceAndKeyDic;
@property (strong, nonatomic) NSMutableDictionary *eventNameAndCallbackIdDic;
@property (strong, nonatomic) NSMutableDictionary *writeReqAndCharacteristicDic;
@property (strong, nonatomic) NSMutableDictionary *readReqAndCharacteristicDic;
@property (strong, nonatomic) NSMutableDictionary *valueAndCharacteristicDic;

@property (strong, nonatomic) CBPeripheralManager *myPeripheralManager;
@property (strong, nonatomic) CBCentralManager *myCentralManager;
@property (strong, nonatomic) NSString *debugOnOrOff;
@property (strong, nonatomic) NSTimer *stopScanTimer;

@property (assign, nonatomic) BOOL isAddAllData;
@property (assign, nonatomic) BOOL isEndOfAddService;
@property (assign, nonatomic) BOOL isFindingPeripheral;


- (void)getEnvironment:(CDVInvokedUrlCommand *)command;
- (void)getBluetoothState:(CDVInvokedUrlCommand*)command;
- (void)openBluetooth:(CDVInvokedUrlCommand*)command;
- (void)startScan:(CDVInvokedUrlCommand*)command;
- (void)stopScan:(CDVInvokedUrlCommand*)command;
- (void)addEventListener:(CDVInvokedUrlCommand *)command;
- (void)creatPair:(CDVInvokedUrlCommand*)command;
- (void)removePair:(CDVInvokedUrlCommand*)command;
- (void)getPairedDevices:(CDVInvokedUrlCommand*)command;
- (void)getConnectedDevices:(CDVInvokedUrlCommand*)command;
- (void)connect:(CDVInvokedUrlCommand*)command;
- (void)disconnect:(CDVInvokedUrlCommand*)command;
- (void)getServices:(CDVInvokedUrlCommand*)command;
- (void)getCharacteristics:(CDVInvokedUrlCommand*)command;
- (void)getDescriptors:(CDVInvokedUrlCommand*)command;
- (void)getRSSI:(CDVInvokedUrlCommand*)command;
- (void)writeValue:(CDVInvokedUrlCommand*)command;
- (void)readValue:(CDVInvokedUrlCommand*)command;
- (void)setNotification:(CDVInvokedUrlCommand*)command;
- (void)getDeviceAllData:(CDVInvokedUrlCommand*)command;
- (void)addServices:(CDVInvokedUrlCommand*)command;
- (void)removeServices:(CDVInvokedUrlCommand*)command;
@end
