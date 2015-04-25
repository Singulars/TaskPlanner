//
//  CreateNewReminer.h
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/21/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateNewReminer : UITableViewController<UITextFieldDelegate,UITextViewDelegate>
{
    
    __weak IBOutlet UILabel *lblRemindOn;
    IBOutlet UILabel *lblRemindOnDate;
    __weak IBOutlet UILabel *lblTotalFriends;
    __weak IBOutlet UILabel *lblRemindFriends;
    __weak IBOutlet UISwitch *switchRemindMe;
    __weak IBOutlet UILabel *lblRemindMe;
    __weak IBOutlet UIDatePicker *datePicker;
    __weak IBOutlet UILabel *lblReminderDate;
    __weak IBOutlet UILabel *lblDate;
    __weak IBOutlet UITextView *tvNotes;
    __weak IBOutlet UITextField *txtTitle;
    __weak IBOutlet UILabel *lblTvPlaceholder;
    __weak IBOutlet UIDatePicker *remindOnDate;
    
    BOOL isDatePickerIsShown,isRemindOnShown;
}
- (IBAction)dateValueChanged:(id)sender;
- (IBAction)switchValueChanged:(id)sender;
- (IBAction)remindDateValueChanged:(id)sender;

@end
