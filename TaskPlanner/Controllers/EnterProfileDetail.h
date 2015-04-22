//
//  EnterProfileDetail.h
//  TaskPlanner
//
//  Created by Verma Mukesh on 19/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterProfileDetail : UITableViewController<APIConnectionDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ProfileImageDownloaderDelegate>
{
    IBOutlet UILabel *lblMobileNo;
    IBOutlet UILabel *lblTask;
    IBOutlet UILabel *lblPlanner;
    IBOutlet UILabel *lblInstruction;
    IBOutlet UILabel *lblCountryCode;
    IBOutlet UITextField *txtFirstName,*txtLastName,*txtBirthday;
    IBOutlet UIButton *btnContinue;
    IBOutlet UIActivityIndicatorView *activityLogin;
    IBOutlet ProfileImageDownloader *btnProfilePic;
    IBOutlet UIDatePicker *datePicker;
    UIImage *imgProfile;
    BOOL isProfileUpdated;
}

@property(nonatomic,strong) NSString *strMobileNo;
@property(nonatomic,strong) NSString *strCC;

- (IBAction)dateChanged:(id)sender;
- (IBAction)btnContinueTapped:(id)sender;
- (IBAction)btnProfilePicTapped:(id)sender;
@end
