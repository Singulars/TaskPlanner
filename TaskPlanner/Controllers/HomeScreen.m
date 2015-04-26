//
//  HomeScreen.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 19/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "HomeScreen.h"
#import "CreateNewReminer.h"

@interface HomeScreen ()

@end

@implementation HomeScreen

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar setHidden:NO];
    [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:APPORANGECOLOR];
    
    UILabel *NavTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    NavTitle.backgroundColor = [UIColor clearColor];
    NavTitle.font =ScreenTitleFontWithOutBold;
    NavTitle.textAlignment = NSTextAlignmentCenter;
    NavTitle.textColor = [UIColor whiteColor];
    [NavTitle setText:@"Home"];
    [NavTitle sizeToFit];
    [self.navigationItem setTitleView:NavTitle];
    
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(btnMenuTapped:)];
    [leftBarItem setTintColor:kWhiteColor];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    

    UIToolbar *toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, btnBackView.frame.size.width, btnBackView.frame.size.height)];
    [btnBackView insertSubview:toolBar atIndex:0];

    
    taskView=[[TaskVIew alloc] initWithFrame:CGRectMake(0, 0, scrContainerView.frame.size.width, scrContainerView.frame.size.height)];
    [scrContainerView addSubview:taskView];
    
    eventView=[[EventView alloc] initWithFrame:CGRectMake(SCREENWIDTH, 0, scrContainerView.frame.size.width, scrContainerView.frame.size.height)];
    [scrContainerView addSubview:eventView];
    
    [scrContainerView setContentSize:CGSizeMake(SCREENWIDTH*2, scrContainerView.frame.size.height)];
    [scrContainerView setBackgroundColor:CLEARCOLOUR];
    
    [btnEvent setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btnEvent setTitleColor:APPORANGECOLOR forState:UIControlStateSelected];
    
    [btnReminder setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btnReminder setTitleColor:APPORANGECOLOR forState:UIControlStateSelected];
    
     [[btnReminder titleLabel] setFont:KSetFont(kDefaultFontName, 16.0f)];
     [[btnEvent titleLabel] setFont:KSetFont(kDefaultFontName, 16.0f)];
     [btnReminder setSelected:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark-
#pragma mark- UIScrollDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==scrContainerView) {
        
        CGFloat pageWidth = scrollView.frame.size.width;
        float fractionalPage = scrollView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        
        NSLog(@"%li",(long)page);
        switch (page) {
            case 0:
                [btnReminder setSelected:YES];
                [btnEvent setSelected:NO];
                break;
            case 1:
                [btnReminder setSelected:NO];
                [btnEvent setSelected:YES];
                break;
                
            default:
                break;
        }
    }
}

#pragma mark-
#pragma mark- UIButton Action Method

-(IBAction)btnCreateNewEventTapped:(id)sender
{
    CreateNewReminer *objNewScr=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateNewReminer"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:objNewScr];
    [self presentViewController:navController animated:YES completion:nil];
}

-(IBAction)btnMenuTapped:(id)sender
{
    ContainerViewController *objContainer = (ContainerViewController *)self.parentViewController.parentViewController;
    [objContainer moveNavigationMenu];
}
- (IBAction)btnReminder:(id)sender {
    
    [scrContainerView setContentOffset:CGPointMake(0, 0) animated:YES];
    [btnReminder setSelected:YES];
    [btnEvent setSelected:NO];
}

- (IBAction)btnEventTapped:(id)sender {
    [scrContainerView setContentOffset:CGPointMake(SCREENWIDTH,0) animated:YES];
    [btnReminder setSelected:NO];
    [btnEvent setSelected:YES];
}
@end
