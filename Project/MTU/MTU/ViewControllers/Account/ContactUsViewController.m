//
//  ContactUsVViewController.m
//  MTU
//
//  Created by     on 7/31/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import "ContactUsViewController.h"


@interface ContactUsViewController ()

@end

@implementation ContactUsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)OnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)OnEmail:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        [mailer setToRecipients:[NSArray arrayWithObjects:@"help@www.MuayThaiu.com", nil]];
        
        [self presentViewController:mailer animated:YES completion:nil];
        
        [mailer release];
    }
    else
    {
        NSString* strTitle, *strMessage, *strOK;
        strTitle = @"Failure";
        strOK = @"OK";
        strMessage = @"Your device doesn't support the composer sheet";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                        message:strMessage
                                                       delegate:nil
                                              cancelButtonTitle:strOK
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

-(IBAction)OnLink:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.MuayThaiu.com"]];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissViewControllerAnimated:YES completion:nil];
}
@end
