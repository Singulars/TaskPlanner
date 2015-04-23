//
//  Friends.m
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/22/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "Friends.h"


@implementation Friends

@dynamic friendId;
@dynamic firstName;
@dynamic lastName;
@dynamic isRemiderSet;
@dynamic friendBirthDate;
@dynamic contactNumber;

+ (NSNumber *)generateID {
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSNumber *timeStampObj = [NSNumber numberWithInteger:timeStamp];
    return timeStampObj;
}

+(id)SaveLFriendDeatilsWithData:(NSDictionary *)dataDict
{
    
    NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
    NSError *error = nil;
    
    Friends *objUpdate=[self fetchFrienUserById:[[dataDict objectForKey:kuserId] integerValue]];
    if (objUpdate!=nil) {
        
        [objUpdate setFriendId:@([[dataDict objectForKey:kuserId] integerValue])];
        [objUpdate setFirstName:[dataDict objectForKey:kfirstName]];
        [objUpdate setLastName:[dataDict objectForKey:klastName]];
        [objUpdate setContactNumber:[dataDict objectForKey:kcontactNumber]];
        [objUpdate setFriendBirthDate:[dataDict objectForKey:kbirthdate]];
        
        
        if ([context save:&error]) {
            NSLog(@"saved successfully");
            
            return objUpdate;
        } else {
            NSLog(@"Failed to save User : %@", [error userInfo]);
            return nil;
        }
        
    }
    else{
        
        Friends *ObjInsert =  [NSEntityDescription insertNewObjectForEntityForName:kFriends inManagedObjectContext:context];
        
        [ObjInsert setFriendId:@([[dataDict objectForKey:kuserId] integerValue])];
        [ObjInsert setFirstName:[dataDict objectForKey:kfirstName]];
        [ObjInsert setLastName:[dataDict objectForKey:klastName]];
        [ObjInsert setContactNumber:[dataDict objectForKey:kcontactNumber]];
        [ObjInsert setFriendBirthDate:[dataDict objectForKey:kbirthdate]];
        
        if ([context save:&error]) {
            NSLog(@"saved successfully");
            return ObjInsert;
        } else {
            NSLog(@"Failed to save User : %@", [error userInfo]);
            return nil;
        }
        
    }
    return nil;
}

+(void)deleteAllFrindsDetail
{
    @try {
        NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:kFriends inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        [request setReturnsObjectsAsFaults:NO];
        NSError *error;
        NSArray *object = [context executeFetchRequest:request error:&error];
        
        for (NSInteger i=0; i<[object count]; i++) {
            [context deleteObject:[object objectAtIndex:i]];
        }
        
        
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

+(void)deleteFriendDetailByID:(NSInteger)userId
{
    @try {
        NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:kFriends inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(userId = %d)", userId];
        [request setPredicate:predicate];
        
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


+(id)fetchFrienUserById:(NSInteger)userId
{
    @try {
        NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:kFriends inManagedObjectContext:context];
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

+(id)fetchAllFriendsDetails
{
    
    @try {
        NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:kFriends inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        
        [request setReturnsObjectsAsFaults:NO];
        
        NSError *error;
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        return objects;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


+(id)initWithObject :(NSDictionary *)dataDict
{
    NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:kFriends inManagedObjectContext:context];
    Friends *ObjInsert = (Friends *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    
    [ObjInsert setFriendId:@([[dataDict objectForKey:kuserId] integerValue])];
    [ObjInsert setFirstName:[dataDict objectForKey:kfirstName]];
    [ObjInsert setLastName:[dataDict objectForKey:klastName]];
    [ObjInsert setContactNumber:[dataDict objectForKey:kcontactNumber]];
    [ObjInsert setFriendBirthDate:[dataDict objectForKey:kbirthdate]];
    return ObjInsert;
}



@end
