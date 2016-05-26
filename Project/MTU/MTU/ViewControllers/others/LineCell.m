//
//  LineCell.m
//  Lingua SA
//
//  Created by 陈玉亮 on 12-10-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LineCell.h"
#import "AppDelegate.h"


@interface LineCell ()

@end

@implementation LineCell

@synthesize     m_Img;
@synthesize     m_text;
@synthesize     m_Caption;
@synthesize     m_waiter;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

@end
