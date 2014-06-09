//
//  ManagerEntity.m
//  BC
//
//  Created by NPHD on 14-1-14.
//
//

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
