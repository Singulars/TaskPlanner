//
//  MenuScreen.m
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/21/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "MenuScreen.h"
#import "ContainerViewController.h"

@interface MenuScreen ()

@end

@implementation MenuScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:APPORANGECOLOR];
    
    UILabel *NavTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    NavTitle.backgroundColor = [UIColor clearColor];
    NavTitle.font =ScreenTitleFont;
    NavTitle.textAlignment = NSTextAlignmentLeft;
    NavTitle.textColor = [UIColor whiteColor];
    [NavTitle setText:@"Menu"];
  //  [NavTitle sizeToFit];
    [self.navigationItem setTitleView:NavTitle];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
