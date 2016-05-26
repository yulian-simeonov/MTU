//
//  WebManager.m
//  WebTest
//
//  Created by ZhiXing Li on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSWebManager.h"
#import "AppDelegate.h"

@implementation JSWebManager
@synthesize delegate;

-(id)initWithAsyncOption:(BOOL)isAsync
{
    if (self = [super init])
    {
        m_jsonManager = [[JSONManager alloc] initWithAsyncOption:isAsync];
        [m_jsonManager setDelegate:self];
        m_url = @"http://www.muaythaiu.com/index.php";
        m_isAsync = isAsync;
        m_requestActionName = None;
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
    [m_jsonManager release];
}

-(void)CancelRequest
{
    [m_jsonManager RequestCancel];
}

-(void)JSONRequestFinished:(ASIHTTPRequest*)request decoder:(JSONDecoder*)jsonDecoder
{
    if (delegate)
        [delegate ReceivedValue:request];
}

-(void)JSONRequestFailed:(NSError*)error
{
    if (delegate != nil)
    {
        [delegate WebManagerFailed:error];
    }
    m_requestActionName = None;
}

-(NSDictionary*)Login:(NSString*)userName password:(NSString*)pswd
{
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:@"login", @"action",
                            userName, @"username",
                            pswd, @"password",
                            nil];
    ASIHTTPRequest* ret = [m_jsonManager JSONRequest:m_url params:params requestMethod:POST];
    if (ret)
        return [m_jsonManager->m_jsonDecoder objectWithData:[ret responseData]];
    else
        return nil;
}

-(NSDictionary*)Signup:(NSString*)username password:(NSString*)pswd emailAddr:(NSString*)email
{
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:@"signup", @"action",
                            username, @"username",
                            pswd,  @"userpass",
                            email, @"useremail",
                            nil];
    ASIHTTPRequest* ret = [m_jsonManager JSONRequest:m_url params:params requestMethod:POST];
    if (ret)
        return [m_jsonManager->m_jsonDecoder objectWithData:[ret responseData]];
    else
        return nil;
}

-(NSDictionary*)GetVideo:(NSString*)categoryIdx
{
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:categoryIdx, @"category_idx",
                            @"getvideo", @"action",
                            [APP->m_userInfo objectForKey:@"ID"], @"user_id",
                            nil];
    ASIHTTPRequest* ret = [m_jsonManager JSONRequest:m_url params:params requestMethod:GET];
    if (ret)
    {
        NSString * str = [ret responseString];
        str  = [str substringFromIndex:2];
        str = [str substringToIndex:6];
        
        if ( [str isEqualToString:@"status"] ) {
            return  nil;
        }
        else
            return [m_jsonManager->m_jsonDecoder objectWithData:[ret responseData]];
    }
    else
        return nil;
}

-(NSDictionary*)SearchVideo:(NSString*)txt
{
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:txt, @"text", @"searchvideo", @"action", [APP->m_userInfo objectForKey:@"ID"], @"user_id", nil];
    ASIHTTPRequest* ret = [m_jsonManager JSONRequest:m_url params:params requestMethod:POST];
    if (ret)
    {
        NSString * str = [ret responseString];
        str  = [str substringFromIndex:2];
        str = [str substringToIndex:6];
        
        if ( [str isEqualToString:@"status"] ) {
            return  nil;
        }
        else
            return [m_jsonManager->m_jsonDecoder objectWithData:[ret responseData]];
    }
    else
        return nil;
}

-(NSDictionary*)UpgradeAccount:(NSDictionary*)userinfo
{
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:@"upgrade", @"action",
                            [userinfo objectForKey:@"ID"], @"user_id",
                            [userinfo objectForKey:@"username"], @"username",
                            [userinfo objectForKey:@"userpass"], @"userpass",
                            [userinfo objectForKey:@"first_name"], @"firstname",
                            [userinfo objectForKey:@"last_name"], @"lastname",
                            [userinfo objectForKey:@"address"], @"address",
                            [userinfo objectForKey:@"city"], @"city",
                            [userinfo objectForKey:@"province"], @"province",
                            [userinfo objectForKey:@"country"], @"country",
                            [userinfo objectForKey:@"creditcard"], @"creditcard",
                            [userinfo objectForKey:@"phone"], @"phone",
                            [userinfo objectForKey:@"useremail"], @"useremail",
                            nil];
    [m_jsonManager JSONRequest:m_url params:params requestMethod:GET];
    return nil;
}

- (void)FileDownload:(NSString*)url savePath:(NSString *)path
{
    [m_jsonManager DownloadFile:url SavePath:path];
}

@end
