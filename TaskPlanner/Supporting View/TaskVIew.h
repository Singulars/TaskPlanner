//
//  TaskVIew.h
//  TaskPlanner
//
//  Created by Verma Mukesh on 19/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskVIew : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tblReminder;
    NSMutableArray *arrReminder;
    UILabel *lblNoReminders;
}


@end
