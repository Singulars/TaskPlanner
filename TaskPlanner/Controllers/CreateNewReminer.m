//
//  CreateNewReminer.m
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/21/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "CreateNewReminer.h"
#import "FriendPickerScreen.h"

#define SelectFriendRowNo 5

@interface CreateNewReminer ()

@end

@implementation CreateNewReminer

@synthesize isFromHomeScreen;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:NO];
    [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:APPORANGECOLOR];
    
    UILabel *NavTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    NavTitle.backgroundColor = [UIColor clearColor];
    NavTitle.font =ScreenTitleFontWithOutBold;
    NavTitle.textAlignment = NSTextAlignmentCenter;
    NavTitle.textColor = [UIColor whiteColor];
    [NavTitle setText:(isFromHomeScreen)?@"Edit Reminder":@"New Reminder"];
    [NavTitle sizeToFit];
    [self.navigationItem setTitleView:NavTitle];
    
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:(isFromHomeScreen)?@"leftIcon":@"menuIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackTapped:)];
    [leftBarItem setTintColor:kWhiteColor];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(btnSaveTapped:)];
    [rightBarItem setTintColor:kWhiteColor];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
    
    [datePicker setMinimumDate:[NSDate date]];
    [remindOnDate setMinimumDate:[NSDate date]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark- UITableview Dalegate and DataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
            return 200.0f;
            break;
        case 2:
            return (isDatePickerIsShown)?220.0f:44.0f;
            break;
        case 3:
            return (isRemindOnShown)?220.0f:44.0f;
            break;
            
        default:
            return 44.0f;
            break;
    }
    
    return 44.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case SelectFriendRowNo:
        {
            FriendPickerScreen *objScr=[self.storyboard instantiateViewControllerWithIdentifier:@"FriendPickerScreen"];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:objScr];
            objScr.isFromCreateScreen=TRUE;
            [self presentViewController:navController animated:YES completion:nil];
        }
            break;
        case 2:
        {
            isDatePickerIsShown=!isDatePickerIsShown;
            [tableView beginUpdates];
            [tableView endUpdates];
        }
            break;
        case 3:
        {
            isRemindOnShown=!isRemindOnShown;
            [tableView beginUpdates];
            [tableView endUpdates];
        }
            break;

        default:
            break;
    }
}


#pragma mark-
#pragma mark- Button Action Methods

-(IBAction)btnBackTapped:(id)sender
{
    if (isFromHomeScreen) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    ContainerViewController *objContainer = (ContainerViewController *)self.parentViewController.parentViewController;
    [objContainer moveNavigationMenu];
}

-(IBAction)btnSaveTapped:(id)sender
{
    NSMutableDictionary *dicc=[[NSMutableDictionary alloc] init];
    [dicc setObject:txtTitle.text forKey:kreminderTitle];
    [dicc setObject:tvNotes.text forKey:kreminderDescription];
    [dicc setObject:@(switchRemindMe.isOn) forKey:kisRemindMeOn];
    [dicc setObject:lblReminderDate.text forKey:kreminderDate];
    [dicc setObject:@"" forKey:kallFriendIds];
    [dicc setObject:ShareObj.objLoginUser.userId forKey:kuserId];
    [dicc setObject:kcreateReminder forKey:kmode];
    
    [APIConnection postRequestData:dicc Action:ENUMAPIActionCreateReminder WithCompletionHandlar:^(id result, BOOL status) {
        
        if(status)
        {
            if ([[result objectForKey:kstatus] integerValue]==0) {
                MY_ALERT(APP_NAME,[result objectForKey:kmessage], nil);
                
            }
            else
            {
            }
        }
        else
        {
            MY_ALERT(APP_NAME,result, nil);
            
        }

        
    }];

}

- (IBAction)dateValueChanged:(id)sender {
    
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:kReminderDateormat];
    NSString *strDate = [df stringFromDate:datePicker.date];
    [lblReminderDate setText:strDate];
}

- (IBAction)switchValueChanged:(id)sender {
}

- (IBAction)remindDateValueChanged:(id)sender {
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:kReminderDateormat];
    NSString *strDate = [df stringFromDate:remindOnDate.date];
    [lblRemindOnDate setText:strDate];
}

#pragma mark-
#pragma mark- UITextView Delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (void) textViewDidEndEditing:(UITextView*)textView {
    lblTvPlaceholder.hidden = textView.text.length > 0;
}

- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text {

    return YES;
}

- (void) textViewDidChange:(UITextView*)textView {
    
    CGRect line = [textView caretRectForPosition:
                   textView.selectedTextRange.start];
    CGFloat overflow = line.origin.y + line.size.height
    - ( textView.contentOffset.y + textView.bounds.size.height
       - textView.contentInset.bottom - textView.contentInset.top );
    if ( overflow > 0 ) {
        
        CGPoint offset = textView.contentOffset;
        offset.y += overflow + 7;
        [UIView animateWithDuration:.2 animations:^{
            [textView setContentOffset:offset];
        }];
    }
    lblTvPlaceholder.hidden = textView.text.length > 0;
}

#pragma mark-
#pragma mark- UITextfield Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (newString.length>0) {
        
    }
    else {
        
        
    }
    
    return YES;
}

@end
