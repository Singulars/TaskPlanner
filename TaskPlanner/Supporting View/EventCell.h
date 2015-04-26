//
//  EventCell.h
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reminders.h"

@interface EventCell : UITableViewCell
{
    Reminders *objReminder;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withEventData:(Reminders *)ReminderData;
@end
