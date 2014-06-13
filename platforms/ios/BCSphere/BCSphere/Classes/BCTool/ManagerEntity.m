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

#import "ManagerEntity.h"
#import "EventName.h"

@implementation ManagerEntity
@synthesize arrayWebView;
@synthesize arrayDevice;
@synthesize myAllPeripherals;
@synthesize _peripherals;
@synthesize RSSIdic;
@synthesize advDataDic;
@synthesize debugModual;
-(id)init{
    if(self =[super init]){
        arrayWebView = [[NSMutableArray alloc] init];
        arrayDevice = [[NSMutableArray alloc] init];
        myAllPeripherals = [[NSMutableArray alloc] init];
        _peripherals = [[NSMutableArray alloc] init];
        RSSIdic = [[NSMutableDictionary alloc] init];
        advDataDic = [[NSMutableDictionary alloc] init];
        debugModual = [[NSString alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openDebug:) name:DEBUGOPEN object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeDebug) name:DEBUGREMOVE object:nil];
        
    }
    return self;
}

- (void)openDebug:(NSNotification *)object{
    NSString *modual = [object object];
    self.debugModual = modual;
}

- (void)closeDebug{
    self.debugModual = @"";
}
@end
