//
//  ItemInfo.h
//  MTU
//
//  Created by ZhaoXuebin on 7/30/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemInfo : NSObject
{
@public
    NSString * m_sThumb;
    NSString * m_sTitle;
    NSString * m_sDescription;
    NSString * m_sVideo;
    UIImage* m_thumbImg;
}

- (void) initInfo;

@end
