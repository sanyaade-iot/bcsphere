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
@synthesize delegate;

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
    if (!isFirstView) {
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 57, _MainScreenFrame.size.width, 2)];
        self.progressView.progressImage = [UIImage imageNamed:@"line.png"];
        [self.view addSubview:self.progressView];
    }
}
- (void)setProgress:(float)progress{
    if (progress < 1.0) {
        self.progressView.hidden = NO;
    }
    self.progressView.progress = progress;
    if (progress == 1.0) {
        [self performSelector:@selector(hiddenProgressView) withObject:nil afterDelay:0.5];
    }
}

- (void)hiddenProgressView{
    self.progressView.hidden = YES;
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

#pragma mark UIWebViewDelegate
static int pro = 1;
- (BOOL)webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    return [super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType];
}

- (void)webViewDidStartLoad:(UIWebView*)theWebView
{
    [super webViewDidStartLoad:theWebView];
    if (!isFirstView) {
        loadProgress = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeProgress) userInfo:nil repeats:YES];
    }
}

- (void)changeProgress{
    [self setProgress:0.05 * pro];
    if (0.05 * pro > 0.9) {
        [loadProgress invalidate];
        pro = 1;
    }else{
        pro++;
    }
}

- (void)webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error
{
    [super webView:theWebView didFailLoadWithError:error];
    if (!isFirstView) {
        [self setProgress:1.0];
        [loadProgress invalidate];
    }
}

- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    [super webViewDidFinishLoad:theWebView];
    if (!isFirstView) {
        [self setProgress:1.0];
        [loadProgress invalidate];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
