//
//  CommonHelper.h
//  BC
//
//  Created by NPHD on 14-1-14.
//
//

#import <Foundation/Foundation.h>

@interface CommonHelper : NSObject{
    
}
+(id)dataFilePath:(NSString *)kFilenName fileValue:(NSString *)strKey;//根据文件名称和键返回对应参数
+(void)setDataForPlist:(NSString *)plistName setValue:(id)setValueSender setkey:(NSString *)setKeySender;//向对应文件中写入数据
+(BOOL)isFileExist:(NSString *)fileName ofType:(NSString *)strType;;//判断文件是否存在
@end
