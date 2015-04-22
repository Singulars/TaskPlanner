//
//  Friends.h
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/22/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Friends : NSManagedObject

@property (nonatomic, retain) NSNumber * friendId;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * isRemiderSet;
@property (nonatomic, retain) NSString * friendBirthDate;
@property (nonatomic, retain) NSString * contactNumber;

@end
