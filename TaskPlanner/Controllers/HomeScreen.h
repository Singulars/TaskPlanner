//
//  HomeScreen.h
//  TaskPlanner
//
//  Created by Verma Mukesh on 19/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskVIew.h"
#import "EventView.h"

@interface HomeScreen : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UIScrollView *scrContainerView;
    EventView *eventView;
    TaskVIew *taskView;
    IBOutlet UIButton *btnReminder;
    IBOutlet UIButton *btnEvent;
    IBOutlet UIView *btnBackView;
    
}
- (IBAction)btnReminder:(id)sender;
- (IBAction)btnEventTapped:(id)sender;

@end
