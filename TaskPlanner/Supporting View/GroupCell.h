//
//  GroupCell.h
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupCell : UICollectionViewCell
{
    
}

-(void)CreateGroupWithData:(NSMutableDictionary *)data;
@property(nonatomic,assign) BOOL iscellNil;
@end
