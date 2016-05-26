//
//  AccountViewController.m
//  MTU
//
//  Created by zhangbuse34 on 6/30/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import "AccountViewController.h"
#import "ContactUsViewController.h"
#import "AppDelegate.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Account", @"Account");
        CGSize size = CGSizeMake(32, 32);
        self.tabBarItem.image = [self imageWithImage:[UIImage imageNamed:@"icon_account"] scaledToSize:size];
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
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([[APP->m_userInfo objectForKey:@"account_type"] isEqualToString:@"free"])
        lbl_accountType.text = @"FREE";
    else
    {
        lbl_accountType.text = @"PAID";
        [btn_upgrade setHidden:YES];
        [img_description setHidden:YES];
    }
    lbl_username.text = [APP->m_userInfo objectForKey:@"user_login"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)OnUpgrade:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.1shoppingcart.com/SecureCart/SecureCart.aspx?mid=AC940F11-480F-4817-B784-802631B290A2&pid=0a16ccf7c4704f8da88684575babf4fc"]];
    [APP SetLoginView];
}

-(IBAction)OnContactUs:(id)sender
{
    NSString* xibName;
    if (IS_IPHONE_4)
        xibName = @"ContactUsViewController_480h";
    else
        xibName = @"ContactUsViewController";
    ContactUsViewController* vwCtrl = [[ContactUsViewController alloc] initWithNibName:xibName bundle:nil];
    [self.navigationController pushViewController:vwCtrl animated:YES];
    [vwCtrl release];
}

-(IBAction)OnLogout:(id)sender
{
    [APP SetLoginView];
}
@end
