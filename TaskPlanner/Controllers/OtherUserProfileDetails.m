//
//  OtherUserProfileDetails.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "OtherUserProfileDetails.h"

@implementation OtherUserProfileDetails

@synthesize objFriendData;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UILabel *NavTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    NavTitle.backgroundColor = [UIColor clearColor];
    NavTitle.font =ScreenTitleFontWithOutBold;
    NavTitle.textAlignment = NSTextAlignmentCenter;
    NavTitle.textColor = [UIColor whiteColor];
    [NavTitle setText:[NSString stringWithFormat:@"%@ %@",objFriendData.firstName,objFriendData.lastName]];
    [NavTitle sizeToFit];
    [self.navigationItem setTitleView:NavTitle];
    
   [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:APPORANGECOLOR];
    
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackTapped:)];
    [leftBarItem setTintColor:kWhiteColor];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    
    [[btnProfile layer] setCornerRadius:btnProfile.frame.size.width/2];
    [[btnProfile layer] setBorderWidth:3.0f];
    [btnProfile setContentMode:UIViewContentModeCenter];
    [[btnProfile layer] setBorderColor:APPORANGECOLOR.CGColor];
    [btnProfile setClipsToBounds:YES];
    
    [self.tableView setBackgroundColor:kWhiteColor];
    
    NSString *strImageName=[NSString stringWithFormat:@"%@.png",objFriendData.friendId];
    [btnProfile setStrImageName:strImageName];
    [btnProfile setImageWithURL:kProfileImageUrl(strImageName)];
    
    
    [lblMobileNo setFont:KSetFont(kDefaultFontName, 20.0f)];
    [lblMobileNo setTextColor:APPBLACKCOLOR];

    [lblFirstName setFont:KSetFont(kDefaultFontName, 20.0f)];
    [lblFirstName setTextColor:APPBLACKCOLOR];
    [lblLastName setFont:KSetFont(kDefaultFontName, 20.0f)];
    [lblLastName setTextColor:APPBLACKCOLOR];
    
    [lblLastName setText:objFriendData.lastName];
    [lblFirstName setText:objFriendData.firstName];
    [lblBirthday setText:[Common getBirthdayFormat:objFriendData.friendBirthDate]];
    [lblMobileNo setText:[Common getBirthdayFormat:objFriendData.contactNumber]];
    
    
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
}

#pragma mark-
#pragma mark- Button Action Methods

-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
