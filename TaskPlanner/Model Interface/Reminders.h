//
//  Reminders.h
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/22/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Reminders : NSManagedObject

@property (nonatomic, retain) NSNumber * reminderId;
@property (nonatomic, retain) NSString * reminderTitle;
@property (nonatomic, retain) NSString * reminderDate;
@property (nonatomic, retain) NSString * remindOnDate;
@property (nonatomic, retain) NSNumber * isRemindMeOn;
@property (nonatomic, retain) NSString * allFriendIds;
@property (nonatomic, retain) NSString * reminderDescription;

@end
