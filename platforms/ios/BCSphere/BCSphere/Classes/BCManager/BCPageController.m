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

#import "BCPageController.h"
#import "EventName.h"

@interface BCPageController ()

@end

@implementation BCPageController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleFingerTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
    singleFingerTwo.numberOfTouchesRequired = 2;
    singleFingerTwo.numberOfTapsRequired = 1;
    singleFingerTwo.delegate = self;
    [self.webView addGestureRecognizer:singleFingerTwo];
    
}

- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender
{
    [self openDebugWithUrl];
}

- (void)openDebugWithUrl{
    NSMutableDictionary *debugURL = [[NSMutableDictionary alloc] init];
    [debugURL setValue:URL_DEBUG forKeyPath:KEY_URL];
    [[NSNotificationCenter defaultCenter] postNotificationName:GO_PAGE object:debugURL];
}

- (void)btnClick:(id)sender{
    UIButton *btnSender = (UIButton *)sender;
    switch (btnSender.tag) {
        case BUTTON_OPENDEBUG:{
            [self openDebugWithUrl];
        }
            break;
        case BUTTON_GOBACK:{
            NSMutableDictionary *dicLS=[[NSMutableDictionary alloc] init];
            [dicLS setObject:self.startPage forKey:KEY_URL];
            [dicLS setObject:GO_BACK forKey:KEY_JUMPDIRECTION];
            [[NSNotificationCenter defaultCenter] postNotificationName:GETCHANGVIEW object:dicLS];
        }
            break;
        case BUTTON_GOFORWARD:{
            NSMutableDictionary *dicLS=[[NSMutableDictionary alloc] init];
            [dicLS setObject:self.startPage forKey:KEY_URL];
            [dicLS setObject:GO_FORWARD forKey:KEY_JUMPDIRECTION];
            [[NSNotificationCenter defaultCenter] postNotificationName:GETCHANGVIEW object:dicLS];
        }
            break;
        case BUTTON_GOMAINVIEW:{
            NSMutableDictionary *dicLS=[[NSMutableDictionary alloc] init];
            [dicLS setObject:self.startPage forKey:KEY_URL];
            [dicLS setObject:GO_FORWARD forKey:KEY_JUMPDIRECTION];
            [[NSNotificationCenter defaultCenter] postNotificationName:GO_HOMEPAGE object:dicLS];
        }
            break;
        case BUTTON_CLOSE:{
            NSMutableDictionary *dicLS=[[NSMutableDictionary alloc] init];
            [dicLS setObject:self.startPage forKey:KEY_URL];
            [[NSNotificationCenter defaultCenter] postNotificationName:DELETECURRENTVIEW object:dicLS];
        }
            break;
        case BUTTON_REFRESH:{
            
        }
            break;
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
