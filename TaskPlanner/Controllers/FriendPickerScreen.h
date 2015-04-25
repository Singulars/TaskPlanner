//
//  FriendPickerScreen.h
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/22/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendPickerScreen : UITableViewController
{
    NSMutableArray *arrFriends;
}
@property(nonatomic,strong)  NSMutableArray *arrSelectedIndexPath;
@property(nonatomic,assign) BOOL isFromCreateScreen;
@end
