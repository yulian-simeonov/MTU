//
//  AppDelegate.h
//  MTU
//
//  Created by zhangbuse34 on 6/30/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@class ViewController;
@interface MyTabController : UITabBarController
@end

@interface MyNavigationController : UINavigationController
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
@public
    NSMutableDictionary* m_userInfo;
}
@property (strong, nonatomic) UIWindow *window;

-(void)SetLoginView;
-(void)SetTabBarView;
@end
