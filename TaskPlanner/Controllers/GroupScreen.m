//
//  GroupScreen.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "GroupScreen.h"
#import "GroupDetailScreen.h"

@implementation GroupScreen


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    arrGroupS=[[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
    [arrGroupS addObjectsFromArray:arrGroupS];
    
    [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:APPORANGECOLOR];
    
    UILabel *NavTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    NavTitle.backgroundColor = [UIColor clearColor];
    NavTitle.font =ScreenTitleFontWithOutBold;
    NavTitle.textAlignment = NSTextAlignmentCenter;
    NavTitle.textColor = [UIColor whiteColor];
    [NavTitle setText:@"Groups"];
    [NavTitle sizeToFit];
    [self.navigationItem setTitleView:NavTitle];
    
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackTapped:)];
    [leftBarItem setTintColor:kWhiteColor];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"createGroup"] style:UIBarButtonItemStylePlain target:self action:@selector(btnCreateNewGroupTapped:)];
    [rightBarItem setTintColor:kWhiteColor];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark-
#pragma mark- Button Action Methods

-(IBAction)btnBackTapped:(id)sender
{
    ContainerViewController *objContainer = (ContainerViewController *)self.parentViewController.parentViewController;
    [objContainer moveNavigationMenu];
}
-(IBAction)btnCreateNewGroupTapped:(id)sender
{
    GroupDetailScreen *objScr=[self.storyboard instantiateViewControllerWithIdentifier:@"GroupDetailScreen"];
    [objScr setIsNewGroup:YES];
    [self.navigationController pushViewController:objScr animated:YES];
}

#pragma mark-
#pragma mark- UICollectionView Cell

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrGroupS count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionViewP cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GroupCell *cell=[collectionViewP dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    if (!cell.iscellNil) {
        [cell CreateGroupWithData:nil];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GroupDetailScreen *objScr=[self.storyboard instantiateViewControllerWithIdentifier:@"GroupDetailScreen"];
    [objScr setIsNewGroup:NO];
    [self.navigationController pushViewController:objScr animated:YES];
}

@end
