//
//  Birthdays.h
//  TaskPlanner
//
//  Created by Chirag on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileImageDownloader.h"

@interface Birthdays : UIViewController
{
    IBOutlet UITableView *tblEvent;
    NSMutableArray *arrEvents;
    UILabel *lblNoEvent;
}
@end
