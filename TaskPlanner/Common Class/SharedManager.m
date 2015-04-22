//
//  SharedManager.m
//  TwoTwit
//
//  Created by nayan mistry on 06/01/15.
//  Copyright (c) 2015 nayan mistry. All rights reserved.
//

#import "SharedManager.h"

static SharedManager *sharedManager;

@implementation SharedManager
@synthesize isInternetConnected;
@synthesize deviceToken;
@synthesize objLoginUser;

+(SharedManager *)sharedInstance
{
    if(sharedManager == nil)
    {
        sharedManager = [[SharedManager alloc] init];
        sharedManager.isInternetConnected = NO;
        [sharedManager setDeviceToken:@""];
        sharedManager.isInternetConnected = NO;
       
    }
    return sharedManager;
}



@end
