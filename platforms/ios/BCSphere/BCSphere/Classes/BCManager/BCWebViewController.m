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

#import "BCWebViewController.h"

@interface BCWebViewController ()

@end

@implementation BCWebViewController
@synthesize isFirstView;
@synthesize deviceInfo;
@synthesize isExistBackground;

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
    self.view.backgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)getCommandInstance:(NSString*)pluginName
{
    // first, we try to find the pluginName in the pluginsMap
    // (acts as a whitelist as well) if it does not exist, we return nil
    // NOTE: plugin names are matched as lowercase to avoid problems - however, a
    // possible issue is there can be duplicates possible if you had:
    // "org.apache.cordova.Foo" and "org.apache.cordova.foo" - only the lower-cased entry will match
    NSString* className = [self.pluginsMap objectForKey:[pluginName lowercaseString]];
    
    if (className == nil) {
        return nil;
    }
    
    id obj = [self.pluginObjects objectForKey:className];
    if (!obj) {
        if ([className isEqualToString:@"BCBluetooth"]) {
            obj=[[NSClassFromString(className)alloc] initWithWebView:self.webView deviceAddress:[deviceInfo valueForKey:KEY_DEVICEADDRESS]];
        }else{
            obj = [[NSClassFromString(className)alloc] initWithWebView:self.webView];
        }
        
        if (obj != nil) {
            [self registerPlugin:obj withClassName:className];
        } else {
            NSLog(@"CDVPlugin class %@ (pluginName: %@) does not exist.", className, pluginName);
        }
    }
    return obj;
}


- (UIWebView*)newCordovaViewWithFrame:(CGRect)bounds
{
    CGFloat y = 0;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if (isFirstView) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            y = 0;
            height = [UIScreen mainScreen].bounds.size.height;
        }else{
            y = -20;
            height = [UIScreen mainScreen].bounds.size.height;
        }
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            y = 57;
            height = [UIScreen mainScreen].bounds.size.height - 80;
        }else{
            y = 57;
            height = [UIScreen mainScreen].bounds.size.height - 60;
        }
    }
    return [[UIWebView alloc] initWithFrame:CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, height)];
}

#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    return [super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType];
}

- (void)webViewDidStartLoad:(UIWebView*)theWebView
{
    [super webViewDidStartLoad:theWebView];
}

- (void)webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error
{
    [super webView:theWebView didFailLoadWithError:error];
    NSMutableDictionary *redictCallbackInfo = [[NSMutableDictionary alloc] init];
    [redictCallbackInfo setValue:CALLBACKREDICTERROR forKey:CALLBACKREDICT];
    [redictCallbackInfo setValue:self.startPage forKey:KEY_URL];
    [[NSNotificationCenter defaultCenter] postNotificationName:CALLBACKREDICT object:redictCallbackInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPage) name:REFRESHPAGE object:nil];
    [self loadWithUrl:URL_ERRORPAGE];
}

- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    [super webViewDidFinishLoad:theWebView];
    NSString* log = self.startPage;
    NSRange range = [log rangeOfString:URL_DEBUG];
    if (range.length <= 0)
    {
        [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
        [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    }
    [self jsExecute:@"www/cordova.js"];
    NSMutableDictionary *redictCallbackInfo = [[NSMutableDictionary alloc] init];
    [redictCallbackInfo setValue:CALLBACKREDICTSUCCESS forKey:CALLBACKREDICT];
    [redictCallbackInfo setValue:self.startPage forKey:KEY_URL];
    [[NSNotificationCenter defaultCenter] postNotificationName:CALLBACKREDICT object:redictCallbackInfo];
}

- (void)jsExecute:(NSString *)jsFilePath{
    NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:jsFilePath];
    NSString *cordovaString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView stringByEvaluatingJavaScriptFromString:cordovaString];
}

- (void)refreshPage{
    [self loadWithUrl:self.startPage];
}

- (void)loadWithUrl:(NSString *)url{
    NSURL* pageURL = nil;
    NSURL* newURL = [NSURL URLWithString:url];
    NSString* newFilePath = [self.commandDelegate pathForResource:[newURL path]];
    pageURL = [NSURL fileURLWithPath:newFilePath];
    NSURLRequest* newPageRequest = [NSURLRequest requestWithURL:pageURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    [self.webView loadRequest:newPageRequest];
}

@end
