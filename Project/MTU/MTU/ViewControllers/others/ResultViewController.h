//
//  ResultViewController.h
//  MTU
//
//  Created by ZhaoXuebin on 7/31/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSWebManager.h"
#import <MediaPlayer/MediaPlayer.h>
@interface ResultViewController : UIViewController<JSWebManagerDelegate>
{
    JSWebManager* m_webMgr;
@public
    NSMutableArray * m_videoList;
}

@property (nonatomic, retain) IBOutlet id delegate;

@property (nonatomic, retain) IBOutlet UITableView * m_table;
@end
