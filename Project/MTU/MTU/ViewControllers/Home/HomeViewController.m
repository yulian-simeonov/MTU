//
//  HomeViewController.m
//  MTU
//
//  Created by zhangbuse34 on 6/30/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import "HomeViewController.h"
#import "JSWaiter.h"
#import "LineCell.h"
#import "ItemInfo.h"
#import "ResultViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Home", @"Home");
        CGSize size = CGSizeMake(32, 32);
        self.tabBarItem.image = [self imageWithImage:[UIImage imageNamed:@"icon_home"] scaledToSize:size];
    }
    return self;
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    m_webMgr = [[JSWebManager alloc] initWithAsyncOption:true];
    [m_webMgr setDelegate:self];
}

-(void)dealloc
{
    [m_webMgr release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction) actionBtn:(id)sender
{
    UIButton * btn  = (UIButton*)sender;
    int categoryIdx = 0;
    int idx = btn.tag;
    switch ( idx) {
        case 0:
            categoryIdx = 6;
            break;
        case 1:
            categoryIdx = 16;
            break;
        case 2:
            categoryIdx = 17;
            break;
        case 3:
            categoryIdx = 18;
            break;
        case 4:
            categoryIdx = 10;
            break;
        case 5:
            categoryIdx = 19;
            break;
        case 6:
            categoryIdx = 20;
            break;
        case 7:
            categoryIdx = 21;
            break;
        case 8:
            categoryIdx = 22;
            break;
        default:
            break;
    }
    
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [m_webMgr GetVideo:[NSString stringWithFormat:@"%d", categoryIdx]];
}

-(void)WebManagerFailed:(NSError*)error
{
    [JSWaiter HideWaiter];
    [[[[UIAlertView alloc] initWithTitle:@"Error" message:@"Connection Failed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
}

-(void)ReceivedValue:(ASIHTTPRequest*)req
{
    [JSWaiter HideWaiter];
    NSDictionary* ret = [m_webMgr->m_jsonManager->m_jsonDecoder objectWithData:[req responseData]];
    NSMutableArray* ary = [[NSMutableArray alloc] init];
    for (NSDictionary* item in ret)
    {
        ItemInfo * info  = [[[ItemInfo alloc] init] autorelease];
        [info initInfo];
        info->m_sThumb  = [[item objectForKey:@"thumb"] retain];
        info->m_sTitle  = [[item objectForKey:@"title"] retain];
        info->m_sDescription = [[item objectForKey: @"description"] retain];
        info->m_sVideo = [[item objectForKey: @"video_url"] retain];
        [ary addObject:info];
    }
    NSString* xibName;
    if (IS_IPHONE_4)
        xibName = @"ResultViewController_480h";
    else
        xibName = @"ResultViewController";
    ResultViewController* controller = [[ResultViewController alloc] initWithNibName:xibName bundle:nil];
    controller->m_videoList = ary;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}
@end
