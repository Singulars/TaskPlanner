//
//  Reminders.m
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/22/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "Reminders.h"



@implementation Reminders

@dynamic reminderId;
@dynamic reminderTitle;
@dynamic reminderDate;
@dynamic remindOnDate;
@dynamic isRemindMeOn;
@dynamic allFriendIds;
@dynamic reminderDescription;

+ (NSNumber *)generateID {
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSNumber *timeStampObj = [NSNumber numberWithInteger:timeStamp];
    return timeStampObj;
}

+(id)SaveReminderDeatilsWithData:(NSDictionary *)dataDict
{
    
    NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
    NSError *error = nil;
    
    Reminders *objUpdate=[self fetchReminderById:[[dataDict objectForKey:kreminderId] integerValue]];
    if (objUpdate!=nil) {
        
        [objUpdate setReminderId:@([[dataDict objectForKey:kreminderId] integerValue])];
        [objUpdate setReminderTitle:[dataDict objectForKey:kreminderTitle]];
        [objUpdate setReminderDescription:[dataDict objectForKey:kreminderDescription]];
        [objUpdate setReminderDate:[dataDict objectForKey:kreminderDate]];
        [objUpdate setRemindOnDate:[dataDict objectForKey:kremindOnDate]];
        [objUpdate setAllFriendIds:[dataDict objectForKey:kallFriendIds]];
        [objUpdate setIsRemindMeOn:[dataDict objectForKey:kisRemindMeOn]];
        
        
        if ([context save:&error]) {
            NSLog(@"saved successfully");
            
            return objUpdate;
        } else {
            NSLog(@"Failed to save User : %@", [error userInfo]);
            return nil;
        }
        
    }
    else{
        
        Reminders *ObjInsert =  [NSEntityDescription insertNewObjectForEntityForName:kReminders inManagedObjectContext:context];
        
        [ObjInsert setReminderId:@([[dataDict objectForKey:kreminderId] integerValue])];
        [ObjInsert setReminderTitle:[dataDict objectForKey:kreminderTitle]];
        [ObjInsert setReminderDescription:[dataDict objectForKey:kreminderDescription]];
        [ObjInsert setReminderDate:[dataDict objectForKey:kreminderDate]];
        [ObjInsert setRemindOnDate:[dataDict objectForKey:kremindOnDate]];
        [ObjInsert setAllFriendIds:[dataDict objectForKey:kallFriendIds]];
        [ObjInsert setIsRemindMeOn:[dataDict objectForKey:kisRemindMeOn]];
        
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

+(void)deleteAllReminderDetail
{
    @try {
        NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:kReminders inManagedObjectContext:context];
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

+(void)deleteReminderDetailByID:(NSInteger)reminderId
{
    @try {
        NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:kReminders inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(reminderId = %d)", reminderId];
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


+(id)fetchReminderById:(NSInteger)reminderId
{
    @try {
        NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:kReminders inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entity];
        
        // *** Set Predicate to Find Users with ID ***
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(reminderId = %d)", reminderId];
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

+(id)fetchReminderDetails
{
    
    @try {
        NSManagedObjectContext *context = [APP_DELEGATE managedObjectContext];
        NSEntityDescription *entity = [NSEntityDescription entityForName:kReminders inManagedObjectContext:context];
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:kReminders inManagedObjectContext:context];
    Reminders *ObjInsert = (Reminders *)[[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    
    [ObjInsert setReminderId:@([[dataDict objectForKey:kreminderId] integerValue])];
    [ObjInsert setReminderTitle:[dataDict objectForKey:kreminderTitle]];
    [ObjInsert setReminderDescription:[dataDict objectForKey:kreminderDescription]];
    [ObjInsert setReminderDate:[dataDict objectForKey:kreminderDate]];
    [ObjInsert setRemindOnDate:[dataDict objectForKey:kremindOnDate]];
    [ObjInsert setAllFriendIds:[dataDict objectForKey:kallFriendIds]];
    [ObjInsert setIsRemindMeOn:[dataDict objectForKey:kisRemindMeOn]];

    
    return ObjInsert;
}


@end
