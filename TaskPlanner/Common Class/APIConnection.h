//
//  APIConnection.h
//  TwoTwit
//
//  Created by nayan mistry on 06/01/15.
//  Copyright (c) 2015 nayan mistry. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef enum : NSInteger {
    
    ENUMAPIActionReg,
    ENUMAPIActionGetCountry,
    ENUMAPIActionSignUp,
    ENUMAPIActionCreateReminder,
    ENUMAPIActionUpdateProfile
    
} ENUMAPIAction;


@protocol APIConnectionDelegate <NSObject>

@optional
-(void)connectionDidFinishWithConnectionError:(NSString *)strError;
- (void)connectionFailedForAction:(NSNumber *)action andWithResponse:(NSDictionary *)result;
- (void)connectionDidFinishedForAction:(NSNumber *)action andWithResponse:(NSDictionary *)result;
- (void)connectionDidFinishWithNullValue:(NSNumber *)action;
@end

@interface APIConnection : NSURLConnection
{
    NSMutableDictionary *requestParams;
}

@property (nonatomic,strong) NSMutableDictionary *requestParams;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, strong) id <APIConnectionDelegate> delegate;
@property (nonatomic, readwrite) NSInteger curAction;

+ (void)postRequestData:(NSDictionary *)postVars
                 Action:(ENUMAPIAction)action
  WithCompletionHandlar:(void (^) (id result, BOOL status))completionBlock;



- (id)initWithwithParmas:(NSMutableDictionary *)params;
-(void)postAPIRequest:(void (^)(id, NSError*))completionBlock;
-(void)postAPIRequest;
@end
