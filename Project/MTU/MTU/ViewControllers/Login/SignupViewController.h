//
//  SignupViewController.h
//  MTU
//
//  Created by     on 8/1/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSWebManager.h"
#import "JSWaiter.h"

@interface SignupViewController : UIViewController<UITextFieldDelegate, JSWebManagerDelegate>
{
    float       m_originalScrollVwHeight;
    IBOutlet UIScrollView* scrolVw;
    
    IBOutlet UITextField* txt_username;
    IBOutlet UITextField* txt_password;
    IBOutlet UITextField* txt_email;
    UITextField*        m_curText;
    JSWebManager*       m_webMgr;
}
@end
