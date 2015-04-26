//
//  Birthdays.m
//  TaskPlanner
//
//  Created by Chirag on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "Birthdays.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface Birthdays ()
{
    NSMutableArray *friendDetail;
}
@end

@implementation Birthdays

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
    [NavTitle setText:@"Birthdays"];
    [NavTitle sizeToFit];
    [self.navigationItem setTitleView:NavTitle];
    
    UIBarButtonItem *leftBarItem;
    leftBarItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackTapped:)];
    [leftBarItem setTintColor:kWhiteColor];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithTitle:@"Sync" style:UIBarButtonItemStylePlain target:self action:@selector(btnSaveTapped:)];
    [rightBarItem setTintColor:kWhiteColor];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
}
-(IBAction)btnSaveTapped:(id)sender
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    [login logInWithReadPermissions:@[@"public_profile",@"email",@"user_friends",@"user_birthday"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
        } else if (result.isCancelled) {
            // Handle cancellations
        } else {
            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/me/friends" parameters:nil]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id user, NSError *error)
             {
                 if (!error) {
                     NSDictionary *dictUser = (NSDictionary *)user;
                     NSArray *friendCount = [[NSArray alloc]initWithArray:[dictUser valueForKey:@"data"]];
                     
                     //facebook friends array allocation
                     friendDetail = [[NSMutableArray alloc] init];
                     for (NSDictionary *dic in friendCount)
                     {
                         [[[FBSDKGraphRequest alloc] initWithGraphPath:[dic valueForKey:@"id"] parameters:nil]
                          startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id user, NSError *error)
                          {
                              if (!error) {
                                  NSDictionary *friends = (NSDictionary *)user;
                                  [friendDetail addObject:friends];
                                  NSLog(@"%@",friendDetail);
                                  [tblEvent reloadData];
                              }
                          }];
                     }
                 }
             }];
        }
    }];
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
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [friendDetail count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *strCellID=[NSString stringWithFormat:@"Cell_%li",(long)indexPath.row];
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strCellID];
    if (cell==nil)
    {
        [lblNoEvent setHidden:YES];
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellID];
        
        ProfileImageDownloader  *btnProfile=[[ProfileImageDownloader alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
        [[btnProfile layer] setCornerRadius:btnProfile.frame.size.width/2];
        [btnProfile setClipsToBounds:YES];
        [[btnProfile layer] setBorderWidth:3.0f];
        [[btnProfile layer] setBorderColor:kWhiteColor.CGColor];
        
        NSString *strImageName=[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",[[friendDetail objectAtIndex:indexPath.row]valueForKey:@"id"]];
        [btnProfile setStrImageName:[NSString stringWithFormat:@"%@.png",[[friendDetail objectAtIndex:indexPath.row]valueForKey:@"id"]]];
        [btnProfile setImageWithURL:strImageName];
        [cell addSubview:btnProfile];

        UILabel *lblName=[[UILabel alloc] initWithFrame:CGRectMake(60, 10, SCREENWIDTH-80, 30)];
        [lblName setBackgroundColor:CLEARCOLOUR];
        [lblName setText:[[friendDetail objectAtIndex:indexPath.row]valueForKey:@"name"]];
        [lblName setFont:KSetFont(kDefaultBoldFontName, 15.0f)];
        [cell addSubview:lblName];
        
        
        UILabel *lblDesc=[[UILabel alloc] initWithFrame:CGRectMake(60, 30, SCREENWIDTH-80, 30)];
        [lblDesc setBackgroundColor:CLEARCOLOUR];
        [lblDesc setText:[[friendDetail objectAtIndex:indexPath.row]valueForKey:@"birthday"]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
