//
//  GroupScreen.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "GroupScreen.h"

@implementation GroupScreen


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    arrGroupS=[[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
    [arrGroupS addObjectsFromArray:arrGroupS];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark-
#pragma mark- UICollectionView Cell

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrGroupS count];
}

@end
