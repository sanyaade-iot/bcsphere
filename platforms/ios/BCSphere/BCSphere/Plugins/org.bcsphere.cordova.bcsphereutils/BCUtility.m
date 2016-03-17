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

#import "BCUtility.h"

#define URL                                   @"url"
#define DEVICEADDRESS                         @"deviceAddress"
#define GO_PAGE                               @"openNewApp"
#define CALLBACKREDICT                        @"callbackRedict"
#define REFRESHPAGE                           @"refreshPage"
#define GETDEVICEID                           @"getOwnDeviceAddress"
@implementation BCUtility
@synthesize callbackAndUrl;

- (void)pluginInitialize{
    [super pluginInitialize];
    callbackAndUrl = [[NSMutableDictionary alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callbackRedict:) name:CALLBACKREDICT object:nil];

}

#pragma mark -
#pragma mark openAppWithDeviceID 获得设备唯一标识
- (void)redirectToApp:(CDVInvokedUrlCommand*)command{
    NSMutableArray *arryConnect=[[NSMutableArray alloc] initWithArray:command.arguments];
    if (arryConnect.count > 0) {
        NSMutableDictionary *pageInfo = [arryConnect objectAtIndex:0];
        if (![pageInfo valueForKey:URL] || [[pageInfo valueForKey:URL] isEqualToString:@""]) {
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }else{
            [callbackAndUrl setValue:command.callbackId forKey:[pageInfo valueForKey:URL]];
            [[NSNotificationCenter defaultCenter] postNotificationName:GO_PAGE object:pageInfo];
        }
    }
}

- (void)retry:(CDVInvokedUrlCommand*)command{
    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESHPAGE object:nil];
}

- (void)openApp:(CDVInvokedUrlCommand*)command{
    NSMutableArray *arryConnect=[[NSMutableArray alloc] initWithArray:command.arguments];
    if (arryConnect.count > 0) {
        NSMutableDictionary *dic =[command.arguments objectAtIndex:0];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"openAppForAppID" object:dic];
    }
}

- (void)callbackRedict:(NSNotification *)object{
    NSMutableDictionary *redirectInfo = [object object];
    if ([[redirectInfo valueForKey:CALLBACKREDICT] boolValue]) {
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK ];
        [self.commandDelegate sendPluginResult:result callbackId:[callbackAndUrl valueForKey:[redirectInfo valueForKey:URL]]];
    }else{
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR ];
        [self.commandDelegate sendPluginResult:result callbackId:[callbackAndUrl valueForKey:[redirectInfo valueForKey:URL]]];
    }
    
}

@end
