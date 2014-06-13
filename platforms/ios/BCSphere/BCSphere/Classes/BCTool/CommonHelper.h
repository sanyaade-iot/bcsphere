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

@interface CommonHelper : NSObject{
    
}
+(id)dataFilePath:(NSString *)kFilenName fileValue:(NSString *)strKey;//根据文件名称和键返回对应参数
+(void)setDataForPlist:(NSString *)plistName setValue:(id)setValueSender setkey:(NSString *)setKeySender;//向对应文件中写入数据
+(BOOL)isFileExist:(NSString *)fileName ofType:(NSString *)strType;;//判断文件是否存在
@end
