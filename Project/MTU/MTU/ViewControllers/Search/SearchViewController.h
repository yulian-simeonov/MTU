//
//  SearchViewController.h
//  MTU
//
//  Created by zhangbuse34 on 6/30/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultViewController.h"
#import "JSWaiter.h"
#import "JSWebManager.h"

@interface SearchViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    JSWebManager* m_webMgr;
}
@property (nonatomic, retain) IBOutlet UITextField * m_txt;

@end
