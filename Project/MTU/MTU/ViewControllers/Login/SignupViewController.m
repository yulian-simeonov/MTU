//
//  SignupViewController.m
//  MTU
//
//  Created by     on 8/1/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

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
    [scrolVw setContentSize:scrolVw.frame.size];
    m_originalScrollVwHeight = scrolVw.frame.size.height;
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

-(IBAction)OnSignup:(id)sender
{
    [txt_email resignFirstResponder];
    [txt_password resignFirstResponder];
    [txt_username resignFirstResponder];
    [JSWaiter ShowWaiter:self title:@"Signup..." type:0];
    [m_webMgr Signup:txt_username.text password:txt_password.text emailAddr:txt_email.text];
}

-(IBAction)OnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
        [[[[UIAlertView alloc] initWithTitle:@"Error" message:[req.error localizedDescription]  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
    }
    else
    {
        
        NSDictionary* ret = [m_webMgr->m_jsonManager->m_jsonDecoder objectWithData:[req responseData]];
        NSLog(@"%@", [ret valueForKey:@"status"]);
        if ([[ret valueForKey:@"status"] isEqualToString:@"failed"])
            [[[[UIAlertView alloc] initWithTitle:@"Failed" message:[ret valueForKey:@"error"]  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
        else if([[ret valueForKey:@"status"] isEqualToString:@"success"])
        {
            [[[[UIAlertView alloc] initWithTitle:@"Success" message:@"Successfully Registered."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
            [self OnBack:nil];
        }
        else
            [[[[UIAlertView alloc] initWithTitle:@"Error" message:@"Response value is Unsupported Format."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
    }
}
@end
