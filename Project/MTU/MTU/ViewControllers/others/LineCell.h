//
//  LineCell.h
//  Lingua SA
//
//  Created by 陈玉亮 on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineCell : UITableViewCell
{
    
}
@property (nonatomic, retain) IBOutlet UITextView * m_text;
@property (nonatomic, retain) IBOutlet UIImageView * m_Img;
@property (nonatomic, retain) IBOutlet UILabel * m_Caption;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView * m_waiter;
@end
