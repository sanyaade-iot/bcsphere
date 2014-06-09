//
//  ManagerEntity.h
//  BC
//
//  Created by NPHD on 14-1-14.
//
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ManagerEntity : NSObject{
}
@property (strong, nonatomic) NSMutableArray *arrayWebView;
@property (strong, nonatomic) NSMutableArray *arrayDevice;
@property (strong, nonatomic) NSMutableArray *myAllPeripherals;
@property (strong, nonatomic) NSMutableArray *_peripherals;
@property (strong, nonatomic) NSMutableDictionary *RSSIdic;
@property (strong, nonatomic) NSMutableDictionary *advDataDic;
@property (strong, nonatomic) NSString *debugModual;
@end
