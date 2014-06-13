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
#import "BCPageManager.h"

@implementation BCPageManager
@synthesize pages;
@synthesize homePage;
@synthesize page;
@synthesize numberOfPage;

@synthesize menuViewDown;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pages = [[NSMutableArray alloc] init];
        BCPageController *homeWebView = [[BCPageController alloc] init];
        homeWebView.isFirstView = TRUE;
        homeWebView.startPage = URL_HOMEPAGE;
        homePage = homeWebView;
        [self addSubview:homePage.view];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (NSInteger)numberOfPage{
    return [self.pages count];
}

- (void)initMenuViewWithPage:(BCPageController *)appPage hide:(BOOL)hidden{
    menuViewDown = [[UIImageView alloc] initWithFrame:CGRectMake(_MainScreenFrame.size.width, 0, _MainScreenFrame.size.width, 57)];
    menuViewDown.backgroundColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
    menuViewDown.userInteractionEnabled = YES;
    menuViewDown.hidden = hidden;
    [self addSubview:menuViewDown];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(-10, 0, 80, 57)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
    backButton.tag = BUTTON_GOMAINVIEW;
    [backButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [menuViewDown addSubview:backButton];
    
    UILabel *deviceName = [[UILabel alloc] initWithFrame:CGRectMake(menuViewDown.bounds.size.width/2 - 120, 0, 240, 57)];
    deviceName.text = [appPage.deviceInfo objectForKey:KEY_DEVICENAME];
    deviceName.font = [UIFont fontWithName:@"Arial" size:16];
    deviceName.textAlignment = UITextAlignmentCenter;
    deviceName.backgroundColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
    deviceName.textColor = [UIColor whiteColor];
    [menuViewDown addSubview:deviceName];
}

- (void)btnClick:(id)btn{
    NSMutableDictionary *redictCallbackInfo = [[NSMutableDictionary alloc] init];
    [redictCallbackInfo setValue:CALLBACKREDICTSUCCESS forKey:CALLBACKREDICT];
    [redictCallbackInfo setValue:self.page.startPage forKey:KEY_URL];
    [[NSNotificationCenter defaultCenter] postNotificationName:CALLBACKREDICT object:redictCallbackInfo];
    [self.page btnClick:btn];
}

#pragma mark -
#pragma mark create destroy show
#pragma mark -
- (BCPageController *)createPageWithUrl:(NSString *)webURL andDeviceInfo:(NSMutableDictionary *)deviceInfo{
    BCPageController *appPage = [[BCPageController alloc] init];
    appPage.startPage = webURL;
    appPage.isFirstView = NO;
    appPage.deviceInfo = deviceInfo;
    appPage.isExistBackground = [[deviceInfo valueForKey:KEY_EXISTBACKGROUND] boolValue];
    appPage.delegate = self;
    [self.pages addObject:appPage];
    appPage.view.hidden = YES;
    return appPage;
}

- (void)destroyPage:(NSString *)webURL{
    for (BCPageController *appPage in self.pages) {
        if ([appPage.startPage isEqualToString:webURL]) {
            for (UIView *view in self.subviews) {
                if ([view isEqual:appPage.view]) {
                    [view removeFromSuperview];
                }
            }
            [self.pages removeObject:appPage];
        }
    }
}

- (void)showPage:(NSString *)webURL hide:(BOOL)hidden{
    if ([webURL isEqualToString:URL_HOMEPAGE]) {
        for (UIView *view in self.subviews) {
            view.hidden = YES;
        }
        homePage.view.hidden = NO;
    }else{
        for (BCPageController *appPage in self.pages) {
            if ([appPage.startPage isEqualToString:webURL]) {
                for (UIView *view in self.subviews) {
                    view.hidden = YES;
                }
                appPage.view.transform = CGAffineTransformIdentity;
                appPage.view.hidden = hidden;
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                    appPage.view.frame=CGRectMake(_MainScreenFrame.size.width, 0, _MainScreenFrame.size.width, _MainScreenFrame.size.height);
                }else{
                    appPage.view.frame=CGRectMake(_MainScreenFrame.size.width, 0, _MainScreenFrame.size.width, _MainScreenFrame.size.height);
                }
                appPage.view.backgroundColor=[UIColor clearColor];
                appPage.webView.backgroundColor=[UIColor clearColor];
                [self addSubview:appPage.view];
                
                self.page = appPage;
                [self initMenuViewWithPage:appPage hide:hidden];
            }
        }
    }
}

#pragma mark -
#pragma mark create page
#pragma mark -

- (void)createPage:(NSString *)webURL andPageInfo:(NSMutableDictionary *)webInfo{
    BOOL newPage = TRUE;
    if ([webURL isEqualToString:@""]) {
        return;
    }
    BCPageController *appPage = nil;
    for (int i = 0; i < self.pages.count; i++) {
        BCPageController *webview = [self.pages objectAtIndex:i];
        if ([webview.startPage isEqualToString:webURL]) {
            appPage = webview;
            newPage = FALSE;
            break;
        }
    }
    if (!appPage) {
        appPage = [self createPageWithUrl:webURL andDeviceInfo:webInfo];
    }
    [self showPage:webURL hide:NO];
    if (newPage) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        }else{
            [UIView animateWithDuration:0.1 animations:^(void){
                appPage.view.transform = CGAffineTransformTranslate(appPage.view.transform, _MainScreenFrame.size.width,0);
            }completion:^(BOOL finished){
                
            }];
        }
    }
    
    [UIView animateWithDuration:0.2 animations:^(void){
        menuViewDown.transform = CGAffineTransformTranslate(menuViewDown.transform, -_MainScreenFrame.size.width,0);
        appPage.view.transform = CGAffineTransformTranslate(appPage.view.transform, -_MainScreenFrame.size.width,0);
    }completion:^(BOOL finished){
        
    }];
}

#pragma mark -
#pragma mark hide page
#pragma mark -

- (void)hidePage:(NSMutableDictionary *)webInfo{
    BCPageController *appPage = [[BCPageController alloc] init];
    if (self.pages.count>0) {
        for (BCPageController *viewController in self.pages) {
            if ([viewController.startPage isEqualToString:[webInfo objectForKey:KEY_URL]]) {
                appPage = viewController;
            }
        }
    }
    homePage.view.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^(void){
        appPage.view.transform = CGAffineTransformTranslate(appPage.view.transform, _MainScreenFrame.size.width,0);
        [menuViewDown removeFromSuperview];
    }completion:^(BOOL finished){
        if (!appPage.isExistBackground) {
            [[NSNotificationCenter defaultCenter] postNotificationName:DELETECURRENTVIEW object:webInfo];
        }
    }];
}

#pragma mark -
#pragma mark delete page
#pragma mark -

- (void)deletePage:(NSMutableDictionary* )webInfo
{
    NSString *strURL=[webInfo objectForKey:KEY_URL];
    [self destroyPage:strURL];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


@end
