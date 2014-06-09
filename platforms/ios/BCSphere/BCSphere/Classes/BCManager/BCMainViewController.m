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

#import "BCMainViewController.h"

@interface BCMainViewController ()

@end

@implementation BCMainViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goPage:) name:GO_PAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goHomePage:) name:GO_HOMEPAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeWebView:) name:DELETECURRENTVIEW object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(debugBack) name:DEBUGBACK object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(debugRemove) name:DEBUGREMOVE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDebugInformation:) name:DEBUG object:nil];

    debugInformations = [[NSMutableArray alloc] init];
    appManager = [[BCPageManager alloc] initWithFrame:self.view.frame];
    [self.view addSubview:appManager];
}

- (void)goPage:(NSNotification *)urlStr{
    NSMutableDictionary *webInfo = [urlStr object];
    NSString *url = [webInfo valueForKey:KEY_URL];
    if ([url hasPrefix:@"bc://debug"]) {
        NSRange foundModual = [url rangeOfString:@"&"];
        if (foundModual.length >0) {
            NSString *modual = [url substringFromIndex:foundModual.location + foundModual.length];
            if (modual.length>0) {
                if (!debug_view) {
                    debug_view = [[DebugView alloc] initWithFrame:CGRectMake(0, 0, _MainScreenFrame.size.width, _MainScreenFrame.size.height)];
                    [[NSNotificationCenter defaultCenter] postNotificationName:DEBUGOPEN object:modual];
                    [self.view addSubview:debug_view];
                }else{
                    debug_view.hidden = FALSE;
                    [self.view bringSubviewToFront:debug_view];
                    if (debugInformations.count > 0) {
                        [debug_view refresh:debugInformations];
                    }
                }
            }
        }
    }else{
        [self addAppWebViewForURL:url webInfo:webInfo];
    }
    
}

- (void)debugBack{
    debug_view.hidden = TRUE;
}

- (void)debugRemove{
    [debug_view removeFromSuperview];
    debug_view = nil;
    [debugInformations removeAllObjects];
}

- (void)showDebugInformation:(NSNotification *)debugObject{
    NSMutableDictionary *debug = [debugObject object];
    [debugInformations addObject:[debug valueForKey:DEBUGINTROMATION]];
    if (!debug_view.hidden) {
        [debug_view refresh:debugInformations];
    }
}

- (void)addAppWebViewForURL:(NSString *)webURL webInfo:(NSMutableDictionary *)webInfo{
    [appManager createPage:webURL andPageInfo:webInfo];
}

- (void)goHomePage:(NSNotification *)webViewInfo{
    NSMutableDictionary *webInfo = [webViewInfo object];
    [appManager hidePage:webInfo];
}

-(void)closeWebView:(NSNotification *)senderObject{
    NSMutableDictionary *dicApp=[senderObject object];
    [appManager deletePage:dicApp];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
