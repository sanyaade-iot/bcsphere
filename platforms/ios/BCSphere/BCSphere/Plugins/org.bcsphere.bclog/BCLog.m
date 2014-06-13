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

#import "BCLog.h"

#define LOGINFORMATION                                @"logInformation"
@implementation BCLog
@synthesize logInformationCallbacks;

- (void)pluginInitialize{
    [super pluginInitialize];
    logInformationCallbacks = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLogInfomation:) name:LOGINFORMATION object:nil];
}

- (void)receiveLogInfomation:(NSNotification *)object{
    NSString *logInformation = [object object];
    if (logInformationCallbacks.count > 0) {
        for (int i = 0; i < logInformationCallbacks.count; i++) {
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:logInformation];
            [result setKeepCallbackAsBool:TRUE];
            [self.commandDelegate sendPluginResult:result callbackId:[logInformationCallbacks objectAtIndex:i]];
        }
    }
}

- (void)trace:(CDVInvokedUrlCommand *)command{
    [logInformationCallbacks addObject:command.callbackId];
}

@end
