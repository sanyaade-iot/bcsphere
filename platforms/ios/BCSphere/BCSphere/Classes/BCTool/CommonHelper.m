//
//  CommonHelper.m
//  BC
//
//  Created by NPHD on 14-1-14.
//
//

#import "CommonHelper.h"

@implementation CommonHelper
+(id)dataFilePath:(NSString *)kFilenName fileValue:(NSString *)strKey{
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:kFilenName ofType:@"plist"];
    NSDictionary *dicPlist = [NSDictionary dictionaryWithContentsOfFile:dataPath];
    return [dicPlist objectForKey:strKey];
}
+(void)setDataForPlist:(NSString *)plistName setValue:(id)setValueSender setkey:(NSString *)setKeySender{
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSMutableDictionary *dicPlist = [NSMutableDictionary dictionaryWithContentsOfFile:dataPath];
    [dicPlist setObject:setValueSender forKey:setKeySender];
    [dicPlist writeToFile:dataPath  atomically:YES];
}
+(BOOL)isFileExist:(NSString *)fileName ofType:(NSString *)strType{
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:fileName ofType:strType];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:dataPath];
    return fileExists;
}
@end
