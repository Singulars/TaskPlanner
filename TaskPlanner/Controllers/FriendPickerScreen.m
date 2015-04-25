//
//  FriendPickerScreen.m
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/22/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "FriendPickerScreen.h"
#import "Friends.h"

#define BtnCheckTag 11

@interface FriendPickerScreen ()

@end

@implementation FriendPickerScreen

@synthesize isFromCreateScreen;

@synthesize arrSelectedIndexPath;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrFriends=[NSMutableArray arrayWithObjects:@"Will Smith",@"Jhonson", @"Smith C",@"Mathew C",@"Roy JO",@"Mark Henry",@"Ray Misterio",nil];
    [self.navigationController.navigationBar setHidden:NO];
    [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:APPORANGECOLOR];
    
    UILabel *NavTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    NavTitle.backgroundColor = [UIColor clearColor];
    NavTitle.font =ScreenTitleFont;
    NavTitle.textAlignment = NSTextAlignmentCenter;
    NavTitle.textColor = [UIColor whiteColor];
    [NavTitle setText:@"Select Friends"];
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
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strCellID];
    if (cell==nil)
    {
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellID];
        
        UIImageView *imgPicture=[[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
        [imgPicture setBackgroundColor:CLEARCOLOUR];
        [imgPicture setImage:GET_IMAGE_WITH_NAME(@"demoPic")];
        [[imgPicture layer] setCornerRadius:imgPicture.frame.size.width/2];
        [imgPicture setClipsToBounds:YES];
        [cell addSubview:imgPicture];
        
        UILabel *lblName=[[UILabel alloc] initWithFrame:CGRectMake(65, 10, SCREENWIDTH-80, 30)];
        [lblName setBackgroundColor:CLEARCOLOUR];
        [lblName setText:[arrFriends objectAtIndex:indexPath.row]];
        [lblName setFont:KSetFont(kDefaultFontName, 15.0f)];
        [cell addSubview:lblName];
        
        UIButton *btnCheckUnCheck=[[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-50,13,30, 30)];
        [btnCheckUnCheck setBackgroundColor:[UIColor clearColor]];
        [btnCheckUnCheck setImage:[UIImage imageNamed:@"unCheck"] forState:UIControlStateNormal];
        [btnCheckUnCheck setImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
//        NSDictionary *diccUser=[NSDictionary dictionaryWithObjectsAndKeys:objF.userId,kuserId, nil];
//        
//        if ([arrSelectedIndexPath containsObject:diccUser]) {
//            [btnCheckUnCheck setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
//        }
//        else{
//            [btnCheckUnCheck setImage:[UIImage imageNamed:@"unCheck"] forState:UIControlStateNormal];
//        }
        
        [btnCheckUnCheck setContentMode:UIViewContentModeScaleAspectFit];
        [btnCheckUnCheck setUserInteractionEnabled:NO];
        btnCheckUnCheck.tag=BtnCheckTag;
        [cell.contentView addSubview:btnCheckUnCheck];
        
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        UITableViewCell *cell=(UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        UIButton *btnCheckUnCheck=(UIButton *)[cell.contentView viewWithTag:BtnCheckTag];
        [btnCheckUnCheck setSelected:!btnCheckUnCheck.isSelected];
    
//        Friends *objF=[arrFriends objectAtIndex:indexPath.row];
//        NSDictionary *diccUser=[NSDictionary dictionaryWithObjectsAndKeys:objF.friendId,kuserId, nil];
//        
//        if ([arrSelectedIndexPath containsObject:diccUser]) {
//            [btnCheckUnCheck setImage:[UIImage imageNamed:@"unCheck"] forState:UIControlStateNormal];
//            [arrSelectedIndexPath removeObject:diccUser];
//        }
//        else{
//            [btnCheckUnCheck setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
//            [arrSelectedIndexPath addObject:diccUser];
//        }
    
}


@end
