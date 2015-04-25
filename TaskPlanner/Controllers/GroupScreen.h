//
//  GroupScreen.h
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupCell.h"

@interface GroupScreen : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    __weak IBOutlet UICollectionView *collectionView;
    NSMutableArray *arrGroupS;
    
}


@end
