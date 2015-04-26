//
//  ProfileScreen.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "ProfileScreen.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation ProfileScreen

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:APPORANGECOLOR];
    
    
    UILabel *NavTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    NavTitle.backgroundColor = [UIColor clearColor];
    NavTitle.font =ScreenTitleFontWithOutBold;
    NavTitle.textAlignment = NSTextAlignmentCenter;
    NavTitle.textColor = [UIColor whiteColor];
    [NavTitle setText:@"Edit Profile"];
    [NavTitle sizeToFit];
    [self.navigationItem setTitleView:NavTitle];
    
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackTapped:)];
    [leftBarItem setTintColor:kWhiteColor];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    
//    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(btnSaveGroupTapped:)];
//    [rightBarItem setTintColor:kWhiteColor];
//    [self.navigationItem setRightBarButtonItem:rightBarItem];
    
    [[btnProfile layer] setCornerRadius:btnProfile.frame.size.width/2];
    [btnProfile setClipsToBounds:YES];
    [[btnProfile layer] setBorderWidth:3.0f];
    [[btnProfile layer] setBorderColor:kWhiteColor.CGColor];
    
    [lblMobileNo setFont:KSetFont(kDefaultFontName, 18)];
    [txtBirthday setFont:KSetFont(kDefaultFontName, 18)];
    [txtFirstName setFont:KSetFont(kDefaultFontName, 18)];
    [txtLastName setFont:KSetFont(kDefaultFontName, 18)];
    
    
    [self.tableView setBackgroundColor:kWhiteColor];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self.tableView addGestureRecognizer:singleTap];
    [[btnSave titleLabel] setFont:KSetFont(kDefaultFontName, 20.0f)];
    [btnSave setTitleColor:COLOR_WITH_RGBA(255.0f, 255.0f, 255.0f, 1.0) forState:UIControlStateNormal];
    [btnSave setBackgroundColor:APPORANGECOLOR];
    
    [txtBirthday setInputView:datePicker];
    
    [datePicker setMaximumDate:[NSDate date]];
    
    if (ShareObj.objLoginUser!=nil) {
        
        [txtFirstName setText:ShareObj.objLoginUser.firstName];
        [txtLastName setText:ShareObj.objLoginUser.lastName];
        NSString *strImg=[NSString stringWithFormat:@"%@",ShareObj.objLoginUser.userId];
        NSString *strImgName=kProfilePicForThumb(strImg);
        NSString *strImgPath=[Common getImage:strImgName fromDirectory:kProfileDictionaryName];
        UIImage *img=[UIImage imageWithContentsOfFile:strImgPath];
        [btnProfile setImage:(img!=nil)?[UIImage imageWithContentsOfFile:strImgPath]:[UIImage imageNamed:@"takePhoto"] forState:UIControlStateNormal];
        
        [txtFirstName setText:ShareObj.objLoginUser.firstName];
        [txtLastName setText:ShareObj.objLoginUser.lastName];
        [txtBirthday setText:[Common getBirthdayFormat:ShareObj.objLoginUser.birthDate]];
    
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
#pragma mark- Button Action Methods

-(IBAction)btnBackTapped:(id)sender
{
    ContainerViewController *objContainer = (ContainerViewController *)self.parentViewController.parentViewController;
    [objContainer moveNavigationMenu];
}

- (IBAction)btnSaveTapped:(id)sender {
    
    [actView startAnimating];
    [self.view endEditing:YES];
    userIntrectionEnable(0);
    NSMutableDictionary *diccUser=[[NSMutableDictionary alloc] init];
    [diccUser setObject:txtFirstName.text forKey:kfirstName];
    [diccUser setObject:txtLastName.text forKey:klastName];
    [diccUser setObject:txtBirthday.text forKey:kbirthdate];
    [diccUser setObject:(imgProfile)?imgProfile:@"" forKey:kprofilePic];
    [diccUser setObject:kupdateProfile forKey:kmode];
    
    [APIConnection postRequestData:diccUser
                            Action:ENUMAPIActionUpdateProfile
             WithCompletionHandlar:^(id result, BOOL status) {
                 
                 NSLog(@"response = %@",result);
                 
                 userIntrectionEnable(1);
                 [actView   stopAnimating];
                 
                 if(status)
                 {
                     if ([[result objectForKey:kstatus] integerValue]==1) {
                         
                         NSMutableDictionary *dicc=[[result objectForKey:kuserDetails] mutableCopy];
                         [dicc setObject:ShareObj.objLoginUser.mobileNmber forKey:kcontactNumber];
                         [dicc setObject:ShareObj.objLoginUser.countryCode forKey:kcountryCode];
                         [dicc setObject:ShareObj.objLoginUser.countryName forKey:kcountryName];
                         [dicc setObject:ShareObj.objLoginUser.userId forKey:kuserId];
                         
                         LoginUserDetails *objLogin=[LoginUserDetails SaveLoginUserDeatilsWithData:[result objectForKey:kuserDetails]];
                         [ShareObj setObjLoginUser:objLogin];
                         
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

- (IBAction)dateChanged:(id)sender {
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:kDefaultShortDateFormat];
    NSString *strDate = [df stringFromDate:datePicker.date];
    [txtBirthday setText:strDate];
}

- (IBAction)btnProfileTapped:(id)sender {
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
                    [btnProfile setImage:imgProfile forState:UIControlStateNormal];
                    
                }
            }
                break;
                
            case UIImagePickerControllerSourceTypePhotoLibrary:
            {
                imgProfile=[[(UIImage *)[info objectForKey:UIImagePickerControllerEditedImage] fixOrientation] compressImageForWidth:SCREENWIDTH*2 AndHeight:SCREENWIDTH*2];
                [btnProfile setImage:imgProfile forState:UIControlStateNormal];
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


@end
