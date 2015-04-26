//
//  ProfileScreen.h
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileScreen : UITableViewController<APIConnectionDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ProfileImageDownloaderDelegate>
{
    __weak IBOutlet ProfileImageDownloader *btnProfile;
    __weak IBOutlet UILabel *lblMobileNo;
    __weak IBOutlet UITextField *txtFirstName;
    __weak IBOutlet UITextField *txtLastName;
    __weak IBOutlet UITextField *txtBirthday;
    __weak IBOutlet UIButton *btnSave;
    __weak IBOutlet UIActivityIndicatorView *actView;
    IBOutlet UIDatePicker *datePicker;
     UIImage *imgProfile;
    
}
- (IBAction)btnProfileTapped:(id)sender;
- (IBAction)btnSaveTapped:(id)sender;
- (IBAction)dateChanged:(id)sender;
@end
