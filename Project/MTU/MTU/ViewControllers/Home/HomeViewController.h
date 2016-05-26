//
//  HomeViewController.h
//  MTU
//
//  Created by zhangbuse34 on 6/30/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSWebManager.h"

@interface HomeViewController : UIViewController< UITableViewDelegate, UITableViewDataSource, JSWebManagerDelegate>
{
    JSWebManager* m_webMgr;
}

- (IBAction) actionBtn:(id)sender;

@end
