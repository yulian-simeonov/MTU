//
//  LoginViewController.h
//  MTU
//
//  Created by zhangbuse34 on 6/30/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSWebManager.h"

@interface LoginViewController : UIViewController<JSWebManagerDelegate>
{
    IBOutlet UITextField* txt_username;
    IBOutlet UITextField* txt_password;
    JSWebManager*       m_webMgr;
}


@end
