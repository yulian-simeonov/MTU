//
//  ItemInfo.m
//  MTU
//
//  Created by ZhaoXuebin on 7/30/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import "ItemInfo.h"

@implementation ItemInfo


- (void) initInfo
{
    m_sTitle = @"";
    m_sThumb = @"";
    m_sDescription = @"";
    m_sVideo = @"";
    m_thumbImg = nil;
}

-(void)dealloc
{
    [m_sTitle release];
    [m_sThumb release];
    [m_sDescription release];
    [m_sVideo release];
    [super dealloc];
}
@end
