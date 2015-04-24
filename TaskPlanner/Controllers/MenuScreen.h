//
//  MenuScreen.h
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/21/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuScreen : UITableViewController
{
    
    __weak IBOutlet UILabel *lblSettings;
    __weak IBOutlet UILabel *lblNotifications;
    __weak IBOutlet UILabel *lblAddEven;
    __weak IBOutlet UILabel *lblAddReminder;
    __weak IBOutlet UILabel *lblHome;
    __weak IBOutlet UILabel *lblName;
    __weak IBOutlet UIButton *btnProfile;
}
- (IBAction)btnProfileTapped:(id)sender;
@end
