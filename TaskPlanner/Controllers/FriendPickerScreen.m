//
//  FriendPickerScreen.m
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/22/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "FriendPickerScreen.h"
#import "Friends.h"
#import "OtherUserProfileDetails.h"
#import "FriendCell.h"

#define BtnCheckTag 11

@interface FriendPickerScreen ()

@end

@implementation FriendPickerScreen

@synthesize isFromCreateScreen;

@synthesize arrSelectedIndexPath;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrFriends=[[NSMutableArray alloc] initWithArray:[Friends fetchAllFriendsDetails]];
    [self.navigationController.navigationBar setHidden:NO];
    [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:APPORANGECOLOR];
    
    UILabel *NavTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    NavTitle.backgroundColor = [UIColor clearColor];
    NavTitle.font =ScreenTitleFontWithOutBold;
    NavTitle.textAlignment = NSTextAlignmentCenter;
    NavTitle.textColor = [UIColor whiteColor];
    [NavTitle setText:(isFromCreateScreen)?@"Select Friends":@"Friends"];
    [NavTitle sizeToFit];
    [self.navigationItem setTitleView:NavTitle];
    
    UIBarButtonItem *leftBarItem;
    if (isFromCreateScreen) {
        leftBarItem=[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(btnBackTapped:)];
        UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(btnDoneTapped:)];
        [rightBarItem setTintColor:kWhiteColor];
        [self.navigationItem setRightBarButtonItem:rightBarItem];

    }
    else
    {
        leftBarItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackTapped:)];
        
        UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"syncContacts"] style:UIBarButtonItemStylePlain target:self action:@selector(btnSyncContactsTapped:)];
        [rightBarItem setTintColor:kWhiteColor];
        [self.navigationItem setRightBarButtonItem:rightBarItem];
    }
    [leftBarItem setTintColor:kWhiteColor];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark- Button Action Methods

-(IBAction)btnBackTapped:(id)sender
{
    if (isFromCreateScreen) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    else
    {
        ContainerViewController *objContainer = (ContainerViewController *)self.parentViewController.parentViewController;
        [objContainer moveNavigationMenu];
        
    }
   
}

-(IBAction)btnSyncContactsTapped:(id)sender
{
    
}
-(IBAction)btnDoneTapped:(id)sender
{
    
}



#pragma mark -
#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrFriends count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strCellID=[NSString stringWithFormat:@"Cell_%li",(long)indexPath.row];
    Friends *objFData=[arrFriends objectAtIndex:indexPath.row];
    FriendCell *cell=[tableView dequeueReusableCellWithIdentifier:strCellID];
    if (cell==nil)
    {
        
        cell=[[FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellID withFriendData:objFData];
        
        if (isFromCreateScreen) {
            UIButton *btnCheckUnCheck=[[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-50,13,30, 30)];
            [btnCheckUnCheck setBackgroundColor:[UIColor clearColor]];
            [btnCheckUnCheck setImage:[UIImage imageNamed:@"unCheck"] forState:UIControlStateNormal];
            [btnCheckUnCheck setImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
            NSDictionary *diccUser=[NSDictionary dictionaryWithObjectsAndKeys:objFData.friendId,kuserId, nil];
            
            if ([arrSelectedIndexPath containsObject:diccUser]) {
                [btnCheckUnCheck setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
            }
            else{
                [btnCheckUnCheck setImage:[UIImage imageNamed:@"unCheck"] forState:UIControlStateNormal];
            }
            [btnCheckUnCheck setContentMode:UIViewContentModeScaleAspectFit];
            [btnCheckUnCheck setUserInteractionEnabled:NO];
            btnCheckUnCheck.tag=BtnCheckTag;
            [cell.contentView addSubview:btnCheckUnCheck];
        }
        
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (isFromCreateScreen) {
        UITableViewCell *cell=(UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        UIButton *btnCheckUnCheck=(UIButton *)[cell.contentView viewWithTag:BtnCheckTag];
        
        Friends *objF=[arrFriends objectAtIndex:indexPath.row];
        NSDictionary *diccUser=[NSDictionary dictionaryWithObjectsAndKeys:objF.friendId,kuserId, nil];
        
        if ([arrSelectedIndexPath containsObject:diccUser]) {
            [btnCheckUnCheck setImage:[UIImage imageNamed:@"unCheck"] forState:UIControlStateNormal];
            [arrSelectedIndexPath removeObject:diccUser];
        }
        else{
            [btnCheckUnCheck setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
            [arrSelectedIndexPath addObject:diccUser];
        }
    }
    else
    {
        Friends *objFData=[arrFriends objectAtIndex:indexPath.row];
        OtherUserProfileDetails *objScr=[self.storyboard instantiateViewControllerWithIdentifier:@"OtherUserProfileDetails"];
        [objScr setObjFriendData:objFData];
        [self.navigationController pushViewController:objScr animated:YES];
    }
   
}


@end
