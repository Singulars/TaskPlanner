//
//  GroupDetailScreen.h
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupDetailScreen : UITableViewController<APIConnectionDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    __weak IBOutlet UILabel *lblDeleteGroup;
    __weak IBOutlet ProfileImageDownloader *btnGroupIcon;
    __weak IBOutlet UITextField *txtGroupName;
    __weak IBOutlet UILabel *lblTotalMembers;
    __weak IBOutlet ParallaxHeaderView *parallexHeaderView;
    __weak IBOutlet UIActivityIndicatorView *actView;
    __weak IBOutlet UIButton *btnDeleteGroup;
     UIImage *imgProfile;
}
@property(nonatomic,assign) BOOL isNewGroup;
- (IBAction)btnGroupIconTapped:(id)sender;
- (IBAction)btnDeleteGroupTapped:(id)sender;

@end
