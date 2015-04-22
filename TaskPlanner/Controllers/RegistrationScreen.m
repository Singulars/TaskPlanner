//
//  RegistrationScreen.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 19/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "RegistrationScreen.h"
#import "EnterProfileDetail.h"


#define kMobileNumberLimit 10

@interface RegistrationScreen ()

@end

@implementation RegistrationScreen

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSLog(@"%@",ShareObj.objLoginUser);
    
    [self.tableView setBackgroundColor:kWhiteColor];
    [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:kWhiteColor];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self.tableView addGestureRecognizer:singleTap];
    selectedRow=0;
    arrCountryCodes=[[NSMutableArray alloc] init];
    
    [lblTask setFont:KSetFont(kDefaultFontName, 46.0f)];
    [lblTask setTextColor:APPBLACKCOLOR];
    [lblPlanner setFont:KSetFont(kDefaultFontName, 46.0f)];
    [lblPlanner setTextColor:APPORANGECOLOR];
    
    [lblInstruction setFont:KSetFont(kDefaultFontName, 20.0f)];
    [lblInstruction setTextColor:COLOR_WITH_RGBA(51.0f, 51.0f, 51.0f, 1.0)];
    
    [lblCountryCode setFont:KSetFont(kDefaultFontName, 20.0f)];
    [lblCountryCode setTextColor:COLOR_WITH_RGBA(51.0f, 51.0f, 51.0f, 1.0)];
    
    [txtNumber setFont:KSetFont(kDefaultFontName, 20.0f)];
    [txtNumber setTextColor:APPBLACKCOLOR];
    
    [txtCountry setFont:KSetFont(kDefaultFontName, 20.0f)];
    [txtCountry setTextColor:APPBLACKCOLOR];
    
    [[btnContinue titleLabel] setFont:KSetFont(kDefaultFontName, 20.0f)];
    [btnContinue setTitleColor:COLOR_WITH_RGBA(255.0f, 255.0f, 255.0f, 1.0) forState:UIControlStateNormal];
    [btnContinue setBackgroundColor:APPORANGECOLOR];
    
    [txtCountry setInputView:countryPickerView];
    if (IS_IPHONE5) {
         [self.tableView setScrollEnabled:NO];
    }
   
    [self getCountryList];
    
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

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view endEditing:YES];
        
    } completion:^(BOOL finished) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField==txtCountry) {
        if ([arrCountryCodes count]==0) {
            [textField resignFirstResponder];
            [Common ShowAlertAccordingTOInstagram:@"No country available"];
        }
        else
        {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }
    
    
    return TRUE;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return TRUE;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@" "] )
    {
        return NO;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
   
    if (textField==txtNumber) {
        if ([newString length]>kMobileNumberLimit){
            return NO;
        }
    }
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


- (IBAction)btnContinueTapped:(id)sender {
    
    if  ([txtCountry.text length]==0) {
         [Common ShowAlertAccordingTOInstagram:@"Please select your country."];
        return;
    }
    else if ([txtNumber.text length]==0) {
         [Common ShowAlertAccordingTOInstagram:@"Please enter your mobile number."];
        return;
    }
    [self LoginUser];
}

-(void)OpenProfileEditScreen
{
    EnterProfileDetail *objProScr=[self.storyboard instantiateViewControllerWithIdentifier:@"EnterProfileDetail"];
    [objProScr setStrMobileNo:txtNumber.text];
    [objProScr setStrCC:lblCountryCode.text];
    [self.navigationController pushViewController:objProScr animated:YES];
}


#pragma mark-
#pragma mark- Webservice Method

-(void)LoginUser
{
    [self.view endEditing:YES];
    [activityLogin startAnimating];
    userIntrectionEnable(0);
    NSMutableDictionary *diccUser=[[NSMutableDictionary alloc] init];
    [diccUser setObject:txtNumber.text forKey:kmobile];
    [diccUser setObject:lblCountryCode.text forKey:kcountryCode];
//    [diccUser setObject:ShareObj.deviceToken forKey:kdeviceToken];
//    [diccUser setObject:@(0) forKey:kdeviceType];
    [diccUser setObject:kisRegistered forKey:kmode];
    
    [APIConnection postRequestData:diccUser
                            Action:ENUMAPIActionReg
             WithCompletionHandlar:^(id result, BOOL status) {
                 
                 NSLog(@"response = %@",result);
                 
                 userIntrectionEnable(1);
                 [activityLogin stopAnimating];
                 
                 if(status)
                 {
                     if ([[result objectForKey:kstatus] integerValue]==0) {
                         MY_ALERT(APP_NAME,[result objectForKey:kmessage], nil);
                        
                     }
                     else
                     {
                         if ([[result objectForKey:kisRegistered] integerValue]==0) {
                             EnterProfileDetail *objProScr=[self.storyboard instantiateViewControllerWithIdentifier:@"EnterProfileDetail"];
                             [objProScr setStrMobileNo:txtNumber.text];
                             [objProScr setStrCC:lblCountryCode.text];
                             [self.navigationController pushViewController:objProScr animated:YES];
                         }
                         else {
                             LoginUserDetails *objLogin=[LoginUserDetails SaveLoginUserDeatilsWithData:[result objectForKey:kuserDetails]];
                             [ShareObj setObjLoginUser:objLogin];
                             
                             EnterProfileDetail *objProScr=[self.storyboard instantiateViewControllerWithIdentifier:@"EnterProfileDetail"];
                             [objProScr setStrMobileNo:txtNumber.text];
                             [objProScr setStrCC:lblCountryCode.text];
                             [self.navigationController pushViewController:objProScr animated:YES];
                         }
                     }
                 }
                 else
                 {
                     MY_ALERT(APP_NAME,result, nil);
                     
                 }
             }];
}

-(void)getCountryList
{
    if (!ShareObj.isInternetConnected) {
        
        [Common ShowAlertAccordingTOInstagram:kInternetNotAvailableAlert];
        return;
    }
    
    [Common ShowAlertAccordingTOInstagram:@"Please wait for while fetching country."];
    NSMutableDictionary *dicParameters = [[NSMutableDictionary alloc] init];
    [dicParameters setValue:kgetCountry forKey:kmode];
    [APIConnection postRequestData:dicParameters Action:ENUMAPIActionGetCountry WithCompletionHandlar:^(id result, BOOL status)
     {
         if (status) {
              arrCountryCodes = [[NSMutableArray alloc] initWithArray:[result valueForKey:kcountryData]];
         }
         else
         {
             MY_ALERT(APP_NAME, result, nil);
             
         }
         [countryActView stopAnimating];
         
     }];
}

#pragma mark-
#pragma mark- MISC

#pragma mark -
#pragma mark - UIKeyboard Delegate...

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

#pragma mark-
#pragma mark- UIPicker Delegate and DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [arrCountryCodes count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[arrCountryCodes objectAtIndex:row] objectForKey:kcountryName];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedRow=row;
    [txtCountry setText:[[arrCountryCodes objectAtIndex:row] objectForKey:kcountryName]];
    [lblCountryCode setText:[NSString stringWithFormat:@"%@",[[arrCountryCodes objectAtIndex:row] objectForKey:kcountryCode]]];
}


@end
