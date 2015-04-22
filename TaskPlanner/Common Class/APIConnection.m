//
//  APIConnection.m
//  TwoTwit
//
//  Created by nayan mistry on 06/01/15.
//  Copyright (c) 2015 nayan mistry. All rights reserved.
//

#import "APIConnection.h"

@implementation APIConnection
@synthesize requestParams;
@synthesize responseData;
@synthesize delegate;
@synthesize curAction;

- (id)initWithwithParmas:(NSMutableDictionary *)params
{
    requestParams=params;
    self=[super init];
    return self;
}

-(void)postAPIRequest:(void (^)(id, NSError*))completionBlock
{
    NSURL *url = [NSURL URLWithString:WEBSERVICE_CALL_URL];

    NSString *contentType = @"application/json";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSError *err = nil;
    NSMutableDictionary *params=[[NSMutableDictionary alloc] initWithDictionary:requestParams];
    NSLog(@"Paramater %@",params);
    
    if ([[requestParams allKeys] containsObject:kprofilePic])
    {
        NSLog(@"Key Exists");
        if ([requestParams[kprofilePic] isKindOfClass:[UIImage class]])
        {
            NSData *dataImage = UIImageJPEGRepresentation([requestParams objectForKey:kprofilePic], 1.0f);
            [requestParams setObject:[dataImage base64forData] forKey:kprofilePic];
            NSLog(@"Data : %@",dataImage);
        }
        else
        {
            [requestParams setObject:@"" forKey:kprofilePic];
        }
    }
    
    NSData *body = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&err];
    [request setHTTPBody:body];
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)body.length] forHTTPHeaderField: @"Content-Length"];
    [request setTimeoutInterval:kRequestTimeOut];
    
   [NSURLConnection sendAsynchronousRequest:request queue:nil completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
       dispatch_async(dispatch_get_main_queue(), ^{
           
            NSDictionary *dictResponse = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil]];
           completionBlock(dictResponse,connectionError);
       });
    }];
    
}


+ (NSString *)getAPINameForType:(ENUMAPIAction)type
{
    
    if(type == ENUMAPIActionReg)
        return kisRegistered;
    if(type == ENUMAPIActionGetCountry)
        return kgetCountry;
    if(type == ENUMAPIActionSignUp)
        return ksignUp;//kcreateReminder
    if(type == ENUMAPIActionCreateReminder)
        return kcreateReminder;
    
    return @"";
}

+ (void)postRequestData:(NSDictionary *)postVars
                 Action:(ENUMAPIAction)action
  WithCompletionHandlar:(void (^) (id result, BOOL status))completionBlock
{
    
    NSURL *url = [NSURL URLWithString:WEBSERVICE_CALL_URL];
    
   // NSLog(@"Request URL %@",[NSString stringWithFormat:@"%@",url]);
    
    NSString *contentType = @"application/json";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSError *err = nil;
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc] initWithDictionary:postVars];
    [params setObject:[self getAPINameForType:action] forKey:@"mode"];
    
    if ([[params allKeys] containsObject:kprofilePic])
    {
        NSLog(@"Key Exists");
        if ([params[kprofilePic] isKindOfClass:[UIImage class]])
        {
            NSData *dataImage = UIImageJPEGRepresentation([params objectForKey:kprofilePic], 1.0f);
            [params setObject:[dataImage base64forData] forKey:kprofilePic];
        }
        else
        {
            [params setObject:@"" forKey:kprofilePic];
        }
    }
    
    //NSLog(@"Paramater %@",params);
    
    NSData *body = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&err];
    [request setHTTPBody:body];
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)body.length] forHTTPHeaderField: @"Content-Length"];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   if(!connectionError)
                                   {
                                       NSError *error = nil;
                                       
                                       NSDictionary *dictResponse = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error]];
                                       completionBlock(dictResponse,(error == nil));
                                   }
                                   else
                                   {
                                       completionBlock(connectionError.localizedDescription,NO);
                                   }
                               });
                              
                           }];
    
}



-(void)postAPIRequest
{
    NSURL *url = [NSURL URLWithString:WEBSERVICE_CALL_URL];
    
    NSString *contentType = @"application/json";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSError *err = nil;
 
    if ([[requestParams allKeys] containsObject:kprofilePic])
    {
        NSLog(@"Key Exists");
        if ([requestParams[kprofilePic] isKindOfClass:[UIImage class]])
        {
            NSData *dataImage = UIImageJPEGRepresentation([requestParams objectForKey:kprofilePic], 1.0f);
            [requestParams setObject:[dataImage base64forData] forKey:kprofilePic];
            NSLog(@"Data : %@",dataImage);
        }
        else
        {
            [requestParams setObject:@"" forKey:kprofilePic];
        }
    }
    
    NSData *body = [NSJSONSerialization dataWithJSONObject:requestParams options:NSJSONWritingPrettyPrinted error:&err];
    [request setHTTPBody:body];
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)body.length] forHTTPHeaderField: @"Content-Length"];
    [request setTimeoutInterval:kRequestTimeOut];
    
    NSURLConnection *cn = [NSURLConnection connectionWithRequest:request delegate:self];
    [cn start];
}

#pragma mark-
#pragma mark- Connection Delegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%s %@",__FUNCTION__,[error debugDescription]);
    if([delegate respondsToSelector:@selector(connectionDidFinishWithConnectionError:)])
    {
        [delegate performSelector:@selector(connectionDidFinishWithConnectionError:) withObject:[error localizedDescription]];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [[NSMutableData alloc] init];
   
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
     [self.responseData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *err = nil;
    NSDictionary *dictResponse = [NSDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingAllowFragments error:&err]];
    NSLog(@"response= %@",dictResponse);
    
    if([[dictResponse valueForKey:kstatus] integerValue]==1)
    {
        if([delegate respondsToSelector:@selector(connectionDidFinishedForAction:andWithResponse:)])
        {
            [delegate performSelector:@selector(connectionDidFinishedForAction:andWithResponse:) withObject:[NSNumber numberWithInteger:self.curAction] withObject:dictResponse];
        }
    }
    else  if([[dictResponse valueForKey:kstatus] integerValue]==0)
    {
        if([delegate respondsToSelector:@selector(connectionFailedForAction:andWithResponse:)])
        {
            [delegate performSelector:@selector(connectionFailedForAction:andWithResponse:) withObject:[NSNumber numberWithInteger:self.curAction] withObject:dictResponse];
        }
    }
    else
    {
        if([delegate respondsToSelector:@selector(connectionDidFinishWithNullValue:)])
        {
            [delegate performSelector:@selector(connectionDidFinishWithNullValue:) withObject:[NSNumber numberWithInteger:self.curAction]];
        }
    }
}

@end
