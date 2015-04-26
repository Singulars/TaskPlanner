//
//  MenuScreen.m
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/21/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "MenuScreen.h"
#import "ContainerViewController.h"
#import "CreateNewReminer.h"
#import "HomeScreen.h"
#import "FriendPickerScreen.h"
#import "GroupScreen.h"
#import "ProfileScreen.h"
#import "Notifications.h"
#import "Settings.h"
#import "Birthdays.h"


#define ProfileRow 0
#define HomeRow 1
#define AddReminder 4
#define AddEventRow 5
#define NotificationsRow 7
#define SettingsRow 8
#define FriendRow 2
#define GroupsRow 3
#define BirthdayRow 6


@interface MenuScreen ()

@end

@implementation MenuScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:APPORANGECOLOR];
    
    UILabel *NavTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 125, 30)];
    NavTitle.backgroundColor = [UIColor clearColor];
    NavTitle.font =ScreenTitleFontWithOutBold;
    NavTitle.textAlignment = NSTextAlignmentLeft;
    NavTitle.textColor = [UIColor whiteColor];
    [NavTitle setText:@"Menu"];
  //  [NavTitle sizeToFit];
    [self.navigationItem setTitleView:NavTitle];
    
    [parallexHeaderView setHeaderImage:[UIImage imageNamed:@"coverBG"]];
    
    [[btnProfile layer] setCornerRadius:btnProfile.frame.size.width/2];
    [btnProfile setClipsToBounds:YES];
    [self.tableView bringSubviewToFront:btnProfile];
    [[btnProfile layer] setBorderWidth:3.0f];
    [[btnProfile layer] setBorderColor:kWhiteColor.CGColor];
    
    [lblName setFont:KSetFont(kDefaultFontName, 18)];
    [lblName setTextColor:kWhiteColor];
    [lblHome setFont:KSetFont(kDefaultFontName, 18)];
    [lblHome setTextColor:COLOR_WITH_RGBA(51.0f, 51.0f, 51.0f, 1.0)];
    [lblAddEven setFont:KSetFont(kDefaultFontName, 18)];
    [lblAddEven setTextColor:COLOR_WITH_RGBA(51.0f, 51.0f, 51.0f, 1.0)];
    [lblAddReminder setFont:KSetFont(kDefaultFontName, 18)];
    [lblAddReminder setTextColor:COLOR_WITH_RGBA(51.0f, 51.0f, 51.0f, 1.0)];
    [lblSettings setFont:KSetFont(kDefaultFontName, 18)];
    [lblSettings setTextColor:COLOR_WITH_RGBA(51.0f, 51.0f, 51.0f, 1.0)];
    [lblNotifications setFont:KSetFont(kDefaultFontName, 18)];
    [lblNotifications setTextColor:COLOR_WITH_RGBA(51.0f, 51.0f, 51.0f, 1.0)];
    [lblFriends setFont:KSetFont(kDefaultFontName, 18)];
    [lblFriends setTextColor:COLOR_WITH_RGBA(51.0f, 51.0f, 51.0f, 1.0)];
    [lblGroups setFont:KSetFont(kDefaultFontName, 18)];
    [lblGroups setTextColor:COLOR_WITH_RGBA(51.0f, 51.0f, 51.0f, 1.0)];
    [lblBirthdays setFont:KSetFont(kDefaultFontName, 18)];
    [lblBirthdays setTextColor:COLOR_WITH_RGBA(51.0f, 51.0f, 51.0f, 1.0)];
    
    lastIndex=0;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSString *strImg=[NSString stringWithFormat:@"%@",ShareObj.objLoginUser.userId];
    NSString *strImgName=kProfilePicForThumb(strImg);
    NSString *strImgPath=[Common getImage:strImgName fromDirectory:kProfileDictionaryName];
    UIImage *img=[UIImage imageWithContentsOfFile:strImgPath];
    [btnProfile setImage:(img!=nil)?[UIImage imageWithContentsOfFile:strImgPath]:[UIImage imageNamed:@"takePhoto"] forState:UIControlStateNormal];
    [lblName setText:[NSString stringWithFormat:@"%@ %@",ShareObj.objLoginUser.firstName,ShareObj.objLoginUser.lastName]];
}   

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark- UITableview DataSource And DataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSLog(@"%li",indexPath.row);
//    if (lastIndex==indexPath.row) {
//        return;
//    }
//    
//    lastIndex=indexPath.row;
    
    switch (indexPath.row) {
        case HomeRow:
        {
            
            ContainerViewController *objContainer = (ContainerViewController *)self.navigationController.parentViewController;
            HomeScreen *objViewcontroller = (HomeScreen *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
            [objContainer loadSelectedViewController:objViewcontroller];
        }
            break;
        case AddReminder:
        {
            ContainerViewController *objContainer = (ContainerViewController *)self.navigationController.parentViewController;
            CreateNewReminer *objViewcontroller = (CreateNewReminer *)[self.storyboard instantiateViewControllerWithIdentifier:@"CreateNewReminer"];
            [objContainer loadSelectedViewController:objViewcontroller];
        }
            break;
        case AddEventRow:
        {
            
        }
            break;
        case NotificationsRow:
        {
            ContainerViewController *objContainer = (ContainerViewController *)self.navigationController.parentViewController;
            Notifications *objViewcontroller = (Notifications *)[self.storyboard instantiateViewControllerWithIdentifier:@"Notifications"];
            [objContainer loadSelectedViewController:objViewcontroller];
            
        }
            break;
        case SettingsRow:
        {
            ContainerViewController *objContainer = (ContainerViewController *)self.navigationController.parentViewController;
            Settings *objViewcontroller = (Settings *)[self.storyboard instantiateViewControllerWithIdentifier:@"Settings"];
            [objContainer loadSelectedViewController:objViewcontroller];
        }
            break;
       
        case FriendRow:
        {
            ContainerViewController *objContainer = (ContainerViewController *)self.navigationController.parentViewController;
             FriendPickerScreen *objScr=[self.storyboard instantiateViewControllerWithIdentifier:@"FriendPickerScreen"];
            [objContainer loadSelectedViewController:objScr];
           
        }
            break;
        case GroupsRow:
        {
            ContainerViewController *objContainer = (ContainerViewController *)self.navigationController.parentViewController;
            GroupScreen *objScr=[self.storyboard instantiateViewControllerWithIdentifier:@"GroupScreen"];
            [objContainer loadSelectedViewController:objScr];
            
        }
            break;
        case BirthdayRow:
        {
            ContainerViewController *objContainer = (ContainerViewController *)self.navigationController.parentViewController;
            Birthdays *objViewcontroller = (Birthdays *)[self.storyboard instantiateViewControllerWithIdentifier:@"Birthdays"];
            [objContainer loadSelectedViewController:objViewcontroller];
        }
            break;
        case ProfileRow:
        {
            ContainerViewController *objContainer = (ContainerViewController *)self.navigationController.parentViewController;
            ProfileScreen *objScr=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileScreen"];
            [objContainer loadSelectedViewController:objScr];
        }
            break;
            
        default:
            break;
    }
 
}


#pragma mark -
#pragma mark UISCrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // pass the current offset of the UITableView so that the ParallaxHeaderView layouts the subViews.
    [parallexHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
}

#pragma mark -
#pragma mark UIButton Action Method

- (IBAction)btnProfileTapped:(id)sender {
    
    ContainerViewController *objContainer = (ContainerViewController *)self.navigationController.parentViewController;
    ProfileScreen *objScr=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileScreen"];
    [objContainer loadSelectedViewController:objScr];
  
}
@end
