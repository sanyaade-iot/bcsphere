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
