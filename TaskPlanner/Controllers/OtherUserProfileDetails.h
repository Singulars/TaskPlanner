//
//  OtherUserProfileDetails.h
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friends.h"

@interface OtherUserProfileDetails : UITableViewController<APIConnectionDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ProfileImageDownloaderDelegate>
{
    __weak IBOutlet ProfileImageDownloader *btnProfile;
    __weak IBOutlet UILabel *lblMobileNo;
    __weak IBOutlet UILabel *lblFirstName;
    __weak IBOutlet UILabel *lblLastName;
    __weak IBOutlet UILabel *lblBirthday;
}

@property(nonatomic,assign) Friends *objFriendData;

@end
