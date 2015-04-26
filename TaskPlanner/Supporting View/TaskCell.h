//
//  TaskCell.h
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reminders.h"

@interface TaskCell : UITableViewCell
{
    Reminders *objReminder;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withReminderData:(Reminders *)ReminderData;
@end
