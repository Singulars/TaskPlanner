//
//  Notifications.m
//  TaskPlanner
//
//  Created by Chirag on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "Notifications.h"

@interface Notifications ()

@end

@implementation Notifications

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrEvents=[NSMutableArray arrayWithObjects:@"Google Event",@"Anniversary", @"On Date",@"Birthday",@"Painting Exhibition",@"Seminar on hacking",@"Morning walk",nil];
    [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:APPORANGECOLOR];
    
    UILabel *NavTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    NavTitle.backgroundColor = [UIColor clearColor];
    NavTitle.font =ScreenTitleFont;
    NavTitle.textAlignment = NSTextAlignmentCenter;
    NavTitle.textColor = [UIColor whiteColor];
    [NavTitle setText:@"Notifications"];
    [NavTitle sizeToFit];
    [self.navigationItem setTitleView:NavTitle];
    
    UIBarButtonItem *leftBarItem;
    leftBarItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackTapped:)];
    [leftBarItem setTintColor:kWhiteColor];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    
}

-(IBAction)btnBackTapped:(id)sender
{
    ContainerViewController *objContainer = (ContainerViewController *)self.parentViewController.parentViewController;
    [objContainer moveNavigationMenu];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arrEvents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *strCellID=[NSString stringWithFormat:@"Cell_%li",(long)indexPath.row];
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strCellID];
    if (cell==nil)
    {
        [lblNoEvent setHidden:YES];
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellID];
        
        UIImageView *imgPicture=[[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
        [imgPicture setBackgroundColor:CLEARCOLOUR];
        [imgPicture setImage:GET_IMAGE_WITH_NAME(@"demoPic")];
        [[imgPicture layer] setCornerRadius:imgPicture.frame.size.width/2];
        [imgPicture setClipsToBounds:YES];
        [cell addSubview:imgPicture];
        
        UILabel *lblName=[[UILabel alloc] initWithFrame:CGRectMake(60, 10, SCREENWIDTH-80, 30)];
        [lblName setBackgroundColor:CLEARCOLOUR];
        [lblName setText:@"Google Event"];
        [lblName setFont:KSetFont(kDefaultBoldFontName, 15.0f)];
        [cell addSubview:lblName];
        
        UILabel *lblDate=[[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-120, 10, 110, 30)];
        [lblDate setBackgroundColor:CLEARCOLOUR];
        [lblDate setText:@"19/04/2015 9:30 AM"];
        [lblDate setFont:KSetFont(kDefaultFontName, 11.0f)];
        [cell addSubview:lblDate];
        
        
        UILabel *lblDesc=[[UILabel alloc] initWithFrame:CGRectMake(60, 30, SCREENWIDTH-80, 50)];
        [lblDesc setBackgroundColor:CLEARCOLOUR];
        [lblDesc setText:@"We all must take part in such kind of events."];
        [lblDesc setNumberOfLines:0];
        [lblDesc setNumberOfLines:2];
        [lblDesc setFont:KSetFont(kDefaultFontName, 13.0f)];
        [lblDesc setLineBreakMode:NSLineBreakByWordWrapping];
        [lblDesc setTextAlignment:NSTextAlignmentLeft];
        [cell addSubview:lblDesc];
    }
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
