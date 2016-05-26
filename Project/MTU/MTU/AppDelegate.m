//
//  AppDelegate.m
//  MTU
//
//  Created by zhangbuse34 on 6/30/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "AccountViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation MyTabController
// The available orientations should be defined in the Info.plist file.
// And in iOS 6+ only, you can override it in the Root View controller in the "supportedInterfaceOrientations" method.
// Only valid for iOS 6+. NOT VALID for iOS 4 / 5.
-(NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationPortraitUpsideDown;
}

// Supported orientations. Customize it for your own needs
// Only valid on iOS 4 / 5. NOT VALID for iOS 6.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end

@implementation MyNavigationController
// The available orientations should be defined in the Info.plist file.
// And in iOS 6+ only, you can override it in the Root View controller in the "supportedInterfaceOrientations" method.
// Only valid for iOS 6+. NOT VALID for iOS 4 / 5.
-(NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationPortraitUpsideDown;
}

// Supported orientations. Customize it for your own needs
// Only valid on iOS 4 / 5. NOT VALID for iOS 6.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end

@implementation AppDelegate

void interruptionListener(void *	inClientData,
                          UInt32	inInterruptionState)
{
}

void propListener(	void *                  inClientData,
                  AudioSessionPropertyID	inID,
                  UInt32                  inDataSize,
                  const void *            inData)
{
    //	RobickViewController *THIS = (RobickViewController*)inClientData;
	if (inID == kAudioSessionProperty_AudioRouteChange)
	{
		CFDictionaryRef routeDictionary = (CFDictionaryRef)inData;
		CFNumberRef reason = (CFNumberRef)CFDictionaryGetValue(routeDictionary, CFSTR(kAudioSession_AudioRouteChangeKey_Reason));
		SInt32 reasonVal;
		CFNumberGetValue(reason, kCFNumberSInt32Type, &reasonVal);
	
	}
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    OSStatus error = AudioSessionInitialize(NULL, NULL, interruptionListener, self);
	if (error) printf("ERROR INITIALIZING AUDIO SESSION! %d\n", (int)error);
	else
	{
        //		UInt32 category = kAudioSessionCategory_PlayAndRecord;
		UInt32 category = kAudioSessionCategory_MediaPlayback;
		error = AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
		if (error) printf("couldn't set audio category!");
        
		error = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange, propListener, self);
		if (error) printf("ERROR ADDING AUDIO SESSION PROP LISTENER! %d\n", (int)error);
		
		error = AudioSessionSetActive(true);
		if (error) printf("AudioSessionSetActive (true) failed");
	}
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    [self SetLoginView];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)SetLoginView
{
    LoginViewController* vwCtrl;
    if (IS_IPHONE_4)
        vwCtrl = [[[LoginViewController alloc] initWithNibName:@"LoginViewController_480h" bundle:nil] autorelease];
    else
        vwCtrl = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
    MyNavigationController* nav = [[[MyNavigationController alloc] initWithRootViewController:vwCtrl] autorelease];
    nav.navigationBarHidden = YES;
    self.window.rootViewController = nav;
}

-(void)SetTabBarView
{
    UIViewController* homeViewCtrl, *SearchViewCtrl, *AccountViewCtrl;
    if (IS_IPHONE_4)
    {
        homeViewCtrl = [[[HomeViewController alloc] initWithNibName:@"HomeViewController_480h" bundle:nil] autorelease];
        SearchViewCtrl = [[[SearchViewController alloc] initWithNibName:@"SearchViewController_480h" bundle:nil] autorelease];
        AccountViewCtrl = [[[AccountViewController alloc] initWithNibName:@"AccountViewController_480h" bundle:nil] autorelease];
    }
    else
    {
        homeViewCtrl = [[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil] autorelease];
        SearchViewCtrl = [[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil] autorelease];
        AccountViewCtrl = [[[AccountViewController alloc] initWithNibName:@"AccountViewController" bundle:nil] autorelease];
    }
    UINavigationController* nav1, *nav2, *nav3;
    nav1 = [[UINavigationController alloc] initWithRootViewController:homeViewCtrl];
    nav2 = [[UINavigationController alloc] initWithRootViewController:SearchViewCtrl];
    nav3 = [[UINavigationController alloc] initWithRootViewController:AccountViewCtrl];
    nav1.navigationBarHidden = YES;
    nav2.navigationBarHidden = YES;
    nav3.navigationBarHidden = YES;
    
    MyTabController* tabBarCtrl = [[[MyTabController alloc] init] autorelease];
    tabBarCtrl.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nil];
    [tabBarCtrl setDelegate:(id<UITabBarControllerDelegate>)self];
    self.window.rootViewController = tabBarCtrl;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
