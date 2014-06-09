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

- (UIWebView*)newCordovaViewWithFrame:(CGRect)bounds
{
    if (isFirstView) {
        return [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            return [[UIWebView alloc] initWithFrame:CGRectMake(0, 57, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-80)];
            
        }else{
            return [[UIWebView alloc] initWithFrame:CGRectMake(0, 57, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100)];
            
        }
    }
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
}

- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    [super webViewDidFinishLoad:theWebView];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [self jsExecute:@"www/cordova.js"];

}

- (void)jsExecute:(NSString *)jsFilePath{
    NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:jsFilePath];
    NSString *cordovaString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView stringByEvaluatingJavaScriptFromString:cordovaString];
}


@end
