//
//  EnterProfileDetail.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 19/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "EnterProfileDetail.h"
#import "RegistrationScreen.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "HomeScreen.h"

@interface EnterProfileDetail ()

@end

@implementation EnterProfileDetail

@synthesize strCC,strMobileNo;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar setHidden:NO];
    [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:APPORANGECOLOR];
    
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackTapped:)];
    [leftBarItem setTintColor:kBlackColor];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    
   
    [[btnProfilePic layer] setCornerRadius:btnProfilePic.frame.size.width/2];
    [[btnProfilePic layer] setBorderWidth:3.0f];
    [btnProfilePic setContentMode:UIViewContentModeCenter];
    [[btnProfilePic layer] setBorderColor:APPORANGECOLOR.CGColor];
    [btnProfilePic setClipsToBounds:YES];
    
    [self.tableView setBackgroundColor:kWhiteColor];
    [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:kWhiteColor];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self.tableView addGestureRecognizer:singleTap];
    
    
    [lblMobileNo setFont:KSetFont(kDefaultFontName, 20.0f)];
    [lblMobileNo setTextColor:APPBLACKCOLOR];
    
    [lblMobileNo setText:[NSString stringWithFormat:@"%@ %@",strCC,strMobileNo]];
    [lblMobileNo setTextColor:APPBLACKCOLOR];
    
    [lblTask setFont:KSetFont(kDefaultFontName, 46.0f)];
    [lblTask setTextColor:APPBLACKCOLOR];
    [lblPlanner setFont:KSetFont(kDefaultFontName, 46.0f)];
    [lblPlanner setTextColor:APPORANGECOLOR];
    
    [txtFirstName setFont:KSetFont(kDefaultFontName, 20.0f)];
    [txtFirstName setTextColor:APPBLACKCOLOR];//COLOR_WITH_RGBA(142.0f, 142.0f, 142.0f, 1.0)
    
    [txtLastName setFont:KSetFont(kDefaultFontName, 20.0f)];
    [txtLastName setTextColor:APPBLACKCOLOR];
    
    [[btnContinue titleLabel] setFont:KSetFont(kDefaultFontName, 20.0f)];
    [btnContinue setTitleColor:COLOR_WITH_RGBA(255.0f, 255.0f, 255.0f, 1.0) forState:UIControlStateNormal];
    [btnContinue setBackgroundColor:APPORANGECOLOR];
    [txtBirthday setInputView:datePicker];
    
    [datePicker setMaximumDate:[NSDate date]];
    
    if (ShareObj.objLoginUser!=nil) {
        
        [txtFirstName setText:ShareObj.objLoginUser.firstName];
        [txtLastName setText:ShareObj.objLoginUser.lastName];
        NSString *strName=[NSString stringWithFormat:@"%@.png",ShareObj.objLoginUser.userId];
        [btnProfilePic setStrImageName:strName];
        [btnProfilePic setDelegate:self];
        [btnProfilePic setImageWithURL:kProfileImageUrl(strName)];
        [btnProfilePic setImage:GET_IMAGE_WITH_NAME(@"takePhoto") forState:UIControlStateNormal];
        
    }
    
    if (IS_IPHONE5) {
        [self.tableView setScrollEnabled:NO];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark-
#pragma mark- MISC

-(void)keyboardWillShow:(NSNotification *)note{
    [self EnableDisableTableViewScrolling:YES];
}
-(void)keyboardWillHide:(NSNotification *)note{
    [self EnableDisableTableViewScrolling:NO];
}
-(void)EnableDisableTableViewScrolling:(BOOL)boolValue
{
    if (!IS_IPHONE4) {
        [self.tableView setScrollEnabled:boolValue];
    }
}


- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view endEditing:YES];
        
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark -
#pragma mark UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return TRUE;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return TRUE;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
        return TRUE;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [UIView animateWithDuration:0.3 animations:^{
        [textField resignFirstResponder];
    } completion:^(BOOL finished) {
        
    }];
    
    return TRUE;
}

#pragma mark-
#pragma mark- Button Action Method

-(void)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnContinueTapped:(id)sender {
    
    if  ([txtFirstName.text length]==0) {
        [Common ShowAlertAccordingTOInstagram:@"Please enter your first name."];
        return;
    }
    else if ([txtLastName.text length]==0) {
        [Common ShowAlertAccordingTOInstagram:@"Please enter your last name."];
        return;
    }
    else if ([txtBirthday.text length]==0) {
        [Common ShowAlertAccordingTOInstagram:@"Please enter your birthday."];
        return;
    }
    
    [self signUpNewUser];
}

-(void)signUpNewUser
{
    [self.view endEditing:YES];
    [activityLogin startAnimating];
    userIntrectionEnable(0);
    NSMutableDictionary *diccUser=[[NSMutableDictionary alloc] init];
    [diccUser setObject:strMobileNo forKey:kmobile];
    [diccUser setObject:strCC forKey:kcountryCode];
    [diccUser setObject:txtFirstName.text forKey:kfirstName];
    [diccUser setObject:txtLastName.text forKey:klastName];
    [diccUser setObject:txtBirthday.text forKey:kbirthdate];
    
//    NSMutableDictionary *diccInfo=[[NSMutableDictionary alloc] init];
//    [diccInfo setObject:@"" forKey:@"model"];
//    [diccInfo setObject:@"" forKey:@"systemName"];
//    [diccInfo setObject:@"" forKey:@"userInterfaceIdiom"];
//    [diccInfo setObject:@"" forKey:@"identifierForVendor"];
//    [diccInfo setObject:@"" forKey:@"name"];
//    [diccInfo setObject:@"" forKey:@"localizedModel"];
//    [diccInfo setObject:@"" forKey:@"systemVersion"];
    
   // [diccUser setObject:diccInfo forKey:kdeviceInfo];
    [diccUser setObject:(imgProfile)?imgProfile:@"" forKey:kprofilePic];
    [diccUser setObject:ksignUp forKey:kmode];
    
    [APIConnection postRequestData:diccUser
                            Action:ENUMAPIActionSignUp
             WithCompletionHandlar:^(id result, BOOL status) {
                 
                 NSLog(@"response = %@",result);
                 
                 userIntrectionEnable(1);
                 [activityLogin stopAnimating];
                 
                 if(status)
                 {
                     if ([[result objectForKey:kstatus] integerValue]==1) {
                         
                         LoginUserDetails *objLogin=[LoginUserDetails SaveLoginUserDeatilsWithData:[result objectForKey:kuserDetails]];
                         [ShareObj setObjLoginUser:objLogin];
                         
                         [self OpenHomeScreen];
                     }
                     else
                     {
                         MY_ALERT(APP_NAME, [result objectForKey:kmessage], nil);
                     }
                 }
                 else
                 {
                     MY_ALERT(APP_NAME,result, nil);
                     
                 }
             }];
}

-(void)OpenHomeScreen
{
      [activityLogin stopAnimating];
    ContainerViewController *objHomeScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"ContainerViewController"];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController pushViewController:objHomeScreen animated:YES];
}

- (IBAction)dateChanged:(id)sender {
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:kDefaultShortDateFormat];
    NSString *strDate = [df stringFromDate:datePicker.date];
    [txtBirthday setText:strDate];
}

- (IBAction)btnProfilePicTapped:(id)sender {
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:APP_NAME delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose Photo",@"Take Photo", nil];
    [actionSheet showInView:self.view];
}

#pragma mark
#pragma mark - ActionSheet Delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    NSLog(@"button index= %li",buttonIndex);
               switch (buttonIndex) {
                case 0:
                {
                    [self openPhotoAlbumAndChoosePhoto];
                }
                    break;
                    
                case 1:
                {
                    [self openCameraAndTakePhoto];
                }
                    break;
                case 2:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
}

-(void)openPhotoAlbumAndChoosePhoto
{
    
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [picker setAllowsEditing:YES];
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    picker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)openCameraAndTakePhoto
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.modalPresentationStyle = UIModalPresentationCurrentContext;
        [picker setAllowsEditing:YES];
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        [Common ShowAlertAccordingTOInstagram:@"Camera is not available."];
    }
}

#pragma mark
#pragma mark - Image/Video Picker Delegate


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^(void){
        
        NSString *mediaType = info[UIImagePickerControllerMediaType];
        
        switch (picker.sourceType) {
                
            case UIImagePickerControllerSourceTypeCamera:
            {
                if([mediaType isEqualToString:(NSString *)kUTTypeImage])
                {
                    imgProfile=[[(UIImage *)[info objectForKey:UIImagePickerControllerEditedImage] fixOrientation] compressImageForWidth:SCREENWIDTH*2 AndHeight:SCREENWIDTH*2];
                    [btnProfilePic setImage:imgProfile forState:UIControlStateNormal];
                    
                    isProfileUpdated=TRUE;
                }
            }
                break;
                
            case UIImagePickerControllerSourceTypePhotoLibrary:
            {
                imgProfile=[[(UIImage *)[info objectForKey:UIImagePickerControllerEditedImage] fixOrientation] compressImageForWidth:SCREENWIDTH*2 AndHeight:SCREENWIDTH*2];
                [btnProfilePic setImage:imgProfile forState:UIControlStateNormal];
                isProfileUpdated=TRUE;
            }
                break;
                
            default:
                break;
        }
        
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark-
#pragma mark- Profile image Delegate

-(void)ProfileImageDownloaded:(id)obj
{
  //  ProfileImageDownloader *profile=(ProfileImageDownloader *)obj;
}



@end
