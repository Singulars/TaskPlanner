//
//  LoginUserDetails.h
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/21/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LoginUserDetails : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * birthDate;
@property (nonatomic, retain) NSString * countryName;
@property (nonatomic, retain) NSString * mobileNmber;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSString * countryCode;

+(id)fetchLoginUserById:(NSInteger)userId;
+ (NSNumber *)generateID;
+(id)SaveLoginUserDeatilsWithData:(NSDictionary *)dataDict;
+(id)initWithObject :(NSDictionary *)dataDict;
+(id)fetchLoginUserDetails;
+(void)deleteLoginUserDetail;

@end
