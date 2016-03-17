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

#ifndef BCSphere_EventName_h
#define BCSphere_EventName_h


#define _MainScreenFrame                [[UIScreen mainScreen] bounds]

#define URL_HOMEPAGE                    @"apps/homepage/index.html"
#define URL_ERRORPAGE                   @"apps/errorpage/index.html"
#define URL_DEBUG                       @"apps/bclogpage/index.html"

#define DEBUGOPEN                       @"openDebug"
#define DEBUGBACK                       @"debugBack"
#define DEBUGREMOVE                     @"debugRemove"
#define DEBUG                           @"debug"
#define DEBUGINTROMATION                @"debugInformation"
#define GETCHANGVIEW                    @"getChange"
#define GO_HOMEPAGE                     @"goHomePage"
#define GO_PAGE                         @"openNewApp"
#define DELETECURRENTVIEW               @"deleteWebView"
#define DISCONNECTAPPDEVICE             @"DisConnectAllDevice"
#define CALLBACKREDICT                  @"callbackRedict"
#define REFRESHPAGE                     @"refreshPage"

#define CALLBACKREDICTSUCCESS           @"true"
#define CALLBACKREDICTERROR             @"false"

#define KEY_URL                         @"url"
#define KEY_DEVICEADDRESS               @"deviceAddress"
#define KEY_DEVICENAME                  @"deviceName"
#define KEY_DEVICETYPE                  @"deviceType"
#define KEY_EXISTBACKGROUND             @"isBackground"
#define KEY_JUMPDIRECTION               @"jumpDirection"

#define GO_BACK                         @"goBack"
#define GO_FORWARD                      @"goForward"
#define GETDEVICEID                     @"getOwnDeviceAddress"

#define BUTTON_OPENDEBUG                1111122222
#define BUTTON_GOBACK                   1111122223
#define BUTTON_GOFORWARD                1111122224
#define BUTTON_GOMAINVIEW               1111122225
#define BUTTON_CLOSE                    1111122226
#define BUTTON_REFRESH                  1111122227
#endif
