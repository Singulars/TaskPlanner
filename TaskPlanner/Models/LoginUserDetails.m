//
//  LoginUserDetails.m
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/21/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "LoginUserDetails.h"


@implementation LoginUserDetails

@dynamic userId;
@dynamic firstName;
@dynamic lastName;
@dynamic birthDate;
@dynamic countryName;
@dynamic mobileNmber;
@dynamic countryCode;


+ (NSNumber *)generateID {
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSNumber *timeStampObj = [NSNumber numberWithInteger:timeStamp];
    return timeStampObj;
}

+(id)SaveLoginUserDeatilsWithData:(NSDictionary *)dataDict
{
    
    NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
    NSError *error = nil;
    
    LoginUserDetails *objUpdate=[self fetchLoginUserById:[[dataDict objectForKey:kuserId] integerValue]];
    if (objUpdate!=nil) {
        
        [objUpdate setUserId:@([[dataDict objectForKey:kuserId] integerValue])];
        [objUpdate setFirstName:[dataDict objectForKey:kfirstName]];
        [objUpdate setLastName:[dataDict objectForKey:klastName]];
        [objUpdate setMobileNmber:[dataDict objectForKey:kcontactNumber]];
        [objUpdate setBirthDate:[dataDict objectForKey:kbirthdate]];
        [objUpdate setCountryName:[dataDict objectForKey:kcountryName]];
        [objUpdate setCountryCode:[dataDict objectForKey:kcountryCode]];
       
        
        if ([context save:&error]) {
            NSLog(@"saved successfully");
            
            return objUpdate;
        } else {
            NSLog(@"Failed to save User : %@", [error userInfo]);
            return nil;
        }
        
    }
    else{
        
        LoginUserDetails *loginObjInsert =  [NSEntityDescription insertNewObjectForEntityForName:kLoginUserDetails inManagedObjectContext:context];
        
        [loginObjInsert setUserId:@([[dataDict objectForKey:kuserId] integerValue])];
        [loginObjInsert setFirstName:[dataDict objectForKey:kfirstName]];
        [loginObjInsert setLastName:[dataDict objectForKey:klastName]];
        [loginObjInsert setMobileNmber:[dataDict objectForKey:kcontactNumber]];
        [loginObjInsert setBirthDate:[dataDict objectForKey:kbirthdate]];
        [loginObjInsert setCountryName:[dataDict objectForKey:kcountryName]];
        [loginObjInsert setCountryCode:[dataDict objectForKey:kcountryCode]];
        
        if ([context save:&error]) {
            NSLog(@"saved successfully");
            return loginObjInsert;
        } else {
            NSLog(@"Failed to save User : %@", [error userInfo]);
            return nil;
        }
        
    }
    return nil;
}

+(void)deleteLoginUserDetail
{
    @try {
        NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:kLoginUserDetails inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        [request setReturnsObjectsAsFaults:NO];
        NSError *error;
        NSArray *object = [context executeFetchRequest:request error:&error];
        
        if([object count] > 0)
            [context deleteObject:[object objectAtIndex:0]];
        
        if ([context save:&error]) {
            NSLog(@"User Deleted Succesfully!");
        } else {
            NSLog(@"User Deletion Failed : %@", [error userInfo]);
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

+(id)fetchLoginUserById:(NSInteger)userId
{
    @try {
        NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:kLoginUserDetails inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        
        // *** Set Predicate to Find Users with ID ***
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(userId = %d)", userId];
        [request setPredicate:predicate];
        [request setReturnsObjectsAsFaults:NO];
        
        NSError *error;
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        if([objects count] > 0)
            return [objects objectAtIndex:0];
        else
            return nil;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

+(id)fetchLoginUserDetails
{
    
    @try {
        NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:kLoginUserDetails inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        
        [request setReturnsObjectsAsFaults:NO];
        
        NSError *error;
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        if([objects count] > 0)
            return [objects objectAtIndex:0];
        else
            return nil;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


+(id)initWithObject :(NSDictionary *)dataDict
{
    NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:kLoginUserDetails inManagedObjectContext:context];
    LoginUserDetails *loginUserObj = (LoginUserDetails *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    
    [loginUserObj setUserId:@([[dataDict objectForKey:kuserId] integerValue])];
    [loginUserObj setFirstName:[dataDict objectForKey:kfirstName]];
    [loginUserObj setLastName:[dataDict objectForKey:klastName]];
    [loginUserObj setMobileNmber:[dataDict objectForKey:kcontactNumber]];
    [loginUserObj setBirthDate:[dataDict objectForKey:kbirthdate]];
    [loginUserObj setCountryName:[dataDict objectForKey:kcountryName]];
    [loginUserObj setCountryCode:[dataDict objectForKey:kcountryCode]];
    
    return loginUserObj;
}


@end
