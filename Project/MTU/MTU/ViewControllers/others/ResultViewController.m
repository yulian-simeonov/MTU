//
//  ResultViewController.m
//  MTU
//
//  Created by ZhaoXuebin on 7/31/13.
//  Copyright (c) 2013 zhangbuse34. All rights reserved.
//

#import "ResultViewController.h"
#import "ItemInfo.h"
#import "LineCell.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize delegate;
@synthesize  m_table;

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
    m_webMgr = [[JSWebManager alloc] initWithAsyncOption:TRUE];
    [m_webMgr setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)WebManagerFailed:(NSError*)error
{
//    [[[[UIAlertView alloc] initWithTitle:@"Error" message:@"Connection Failed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
}

-(void)ReceivedValue:(ASIHTTPRequest*)req
{
    if (req.error)
    {
//        [[[[UIAlertView alloc] initWithTitle:@"Failed" message:[req.error localizedDescription]  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
    }
    else
    {
        int idx = 0;
        for(ItemInfo* itm in m_videoList)
        {
            if (![itm->m_sThumb isEqual:[NSNull null]])
            {
                if ([itm->m_sThumb isEqualToString:req.url.absoluteString])
                {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                    [m_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:NO];
                    break;
                }
            }
            idx++;
        }
    }
}

#pragma mark Table dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 89;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_videoList count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LineCell * cell = nil;
    NSString* CellIdentifier = [NSString stringWithFormat:@"Line%d", indexPath.row];
    cell = (LineCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSString* strNibCell = @"LineCell";
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:strNibCell owner:self options:nil];
        cell = (LineCell*)[nib objectAtIndex:0];
        
        ItemInfo * info = [m_videoList objectAtIndex:indexPath.row];
        [cell.m_Caption setText:info->m_sTitle];
        [cell.m_text setText:info->m_sDescription];
        if (cell.m_waiter.isAnimating)
        {
            if (info->m_thumbImg)
            {
                [cell.m_Img setImage:info->m_thumbImg];
                [cell.m_waiter stopAnimating];
            }
            else
            {
                NSString* saveFolderName = [JSONManager GetSavePath:@"thumbPath"];
                NSString* filePath = [NSString stringWithFormat:@"%@/%@.png", saveFolderName, info->m_sTitle];
                if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
                {
                    if ([info->m_sThumb isEqual:[NSNull null]])
                        [cell.m_waiter stopAnimating];                    
                    else
                        [m_webMgr FileDownload:info->m_sThumb savePath:filePath];
                }
                else
                {
                    info->m_thumbImg = [[UIImage alloc] initWithContentsOfFile:filePath];
                    [cell.m_Img setImage:info->m_thumbImg];
                    [cell.m_waiter stopAnimating];
                }
            }
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(IBAction)OnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Table View delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemInfo* info = [m_videoList objectAtIndex:indexPath.row];
    MPMoviePlayerViewController *videoPlayerVw = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:info->m_sVideo]];
    videoPlayerVw.title = info->m_sTitle;
    [self presentMoviePlayerViewControllerAnimated:videoPlayerVw];
    [videoPlayerVw release];
}
@end
