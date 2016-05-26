//
//  LoginViewController.m
//  MTU
//
//  Created by zhangbuse34 on 6/30/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "JSWebManager.h"
#import "JSWaiter.h"
#import "SignupViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

-(IBAction)OnLogin:(id)sender
{
    [JSWaiter ShowWaiter:self title:@"Login..." type:0];
    [m_webMgr Login:txt_username.text password:txt_password.text];
}

-(void)WebManagerFailed:(NSError*)error
{
    [JSWaiter HideWaiter];
    [[[[UIAlertView alloc] initWithTitle:@"Error" message:@"Connection Failed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
}

-(void)ReceivedValue:(ASIHTTPRequest*)req
{
    [JSWaiter HideWaiter];
    if (req.error)
    {
        [[[[UIAlertView alloc] initWithTitle:@"Failed" message:[req.error localizedDescription]  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
    }
    else
    {
        NSDictionary* ret = [m_webMgr->m_jsonManager->m_jsonDecoder objectWithData:[req responseData]];
        
        if ([[ret objectForKey:@"status"] isEqualToString:@"failed"])
            [[[[UIAlertView alloc] initWithTitle:@"Login" message:@"Login Info is wrong." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
        else if ([[ret objectForKey:@"status"] isEqualToString:@"success"])
        {
            APP->m_userInfo = [[NSMutableDictionary alloc] init];
            [APP->m_userInfo addEntriesFromDictionary:[ret objectForKey:@"login_user"]];
            [APP->m_userInfo addEntriesFromDictionary:[ret objectForKey:@"account_type"]];
            [APP->m_userInfo setObject:txt_password.text forKey:@"userpass"];
            [APP SetTabBarView];
        }
    }
}

-(IBAction)OnSignUp:(id)sender
{
    NSString* xibName;
    if (IS_IPHONE_4)
        xibName = @"SignupViewController_480h";
    else
        xibName = @"SignupViewController";
    SignupViewController* vw = [[SignupViewController alloc] initWithNibName:xibName bundle:nil];
    [self.navigationController pushViewController:vw animated:YES];
    [vw release];
}

- (IBAction)textFieldFinished:(id)sender
{
    [txt_password resignFirstResponder];
    [txt_username resignFirstResponder];
}
@end
