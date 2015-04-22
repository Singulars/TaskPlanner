//
//  RegistrationScreen.h
//  TaskPlanner
//
//  Created by Verma Mukesh on 19/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationScreen : UITableViewController<UITextFieldDelegate,APIConnectionDelegate,UIPickerViewDelegate, UIPickerViewDataSource>
{
    IBOutlet UILabel *lblTask;
    IBOutlet UILabel *lblPlanner;
    IBOutlet UILabel *lblInstruction;
    IBOutlet UILabel *lblCountryCode;
    IBOutlet UITextField *txtNumber;
    IBOutlet UIButton *btnContinue;
    NSMutableArray *arrCountryCodes;
    IBOutlet UIPickerView *countryPickerView;
    NSInteger selectedRow;
    IBOutlet UIActivityIndicatorView *countryActView,*activityLogin;
    IBOutlet UITextField *txtCountry;
}

- (IBAction)btnContinueTapped:(id)sender;

@end
