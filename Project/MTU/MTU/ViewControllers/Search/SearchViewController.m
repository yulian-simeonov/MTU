//
//  SearchViewController.m
//  MTU
//
//  Created by zhangbuse34 on 6/30/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import "SearchViewController.h"
#import "LineCell.h"
#import "ItemInfo.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize  m_txt;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Search", @"Search");
        CGSize size = CGSizeMake(32, 32);
        self.tabBarItem.image = [self imageWithImage:[UIImage imageNamed:@"icon_search"] scaledToSize:size];
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
    // Dispose of any resources that can be recreated.
}

#pragma mark Text View delegate

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [m_txt resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [m_txt resignFirstResponder];
    if ( ![textField.text isEqualToString:@""])
    {
        if (self.view.frame.origin.y < 0)
            [self.view setFrame:CGRectMake(0, 0, 320, 460)];
        [JSWaiter ShowWaiter:self title:@"Searching" type:0];
        [m_webMgr SearchVideo:m_txt.text];
    }
    return YES;
}

- (IBAction) actionSearch:(id)sender
{
    [m_txt resignFirstResponder];
    if ( ![m_txt.text isEqualToString:@""])
    {
        if (self.view.frame.origin.y < 0)
            [self.view setFrame:CGRectMake(0, 0, 320, 460)];
        [JSWaiter ShowWaiter:self title:@"Searching" type:0];
        [m_webMgr SearchVideo:m_txt.text];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (IS_IPHONE_4)
        [self.view setFrame:CGRectMake(0, -65, 320, 460)];
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
    if ([ret isKindOfClass:[NSDictionary class]])
    {
        [[[[UIAlertView alloc] initWithTitle:@"" message:[ret valueForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
    }
    else
    {
        NSMutableArray* ary = [[NSMutableArray alloc] init];
        for (NSDictionary* item in ret)
        {
            ItemInfo * info  = [[[ItemInfo alloc] init] autorelease];
            [info initInfo];
            info->m_sThumb  = [item objectForKey:@"thumb"];
            info->m_sTitle  = [item objectForKey:@"title"];
            info->m_sDescription = [item objectForKey: @"description"];
            info->m_sVideo = [item objectForKey: @"video_url"];
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
}
@end
