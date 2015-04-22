//
//  SharedManager.h
//  TwoTwit
//
//  Created by nayan mistry on 06/01/15.
//  Copyright (c) 2015 nayan mistry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginUserDetails.h"


@interface SharedManager : NSObject
{
    BOOL isInternetConnected;
}

+(SharedManager *)sharedInstance;
@property(nonatomic,strong) LoginUserDetails *objLoginUser;
@property(nonatomic, readwrite) BOOL isInternetConnected;
@property(retain, nonatomic) NSString *deviceToken;
@property(nonatomic, strong) NSMutableDictionary *dictSettings;
@end
