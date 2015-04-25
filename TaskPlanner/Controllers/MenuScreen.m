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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContainerViewController *objContainer = (ContainerViewController *)self.navigationController.parentViewController;
    CreateNewReminer *objViewcontroller = (CreateNewReminer *)[self.storyboard instantiateViewControllerWithIdentifier:@"CreateNewReminer"];
    [objContainer loadSelectedViewController:objViewcontroller];
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
  
}
@end
