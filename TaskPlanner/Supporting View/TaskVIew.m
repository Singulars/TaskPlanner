//
//  TaskVIew.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 19/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "TaskVIew.h"
#import "CreateNewReminer.h"
#import "TaskCell.h"

@implementation TaskVIew

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:CLEARCOLOUR];
        
        tblReminder=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        if (IS_IPHONE4) {
            [tblReminder setFrame:CGRectMake(tblReminder.frame.origin.x, tblReminder.frame.origin.y, tblReminder.frame.size.width, tblReminder.frame.size.height)];
        }
        [tblReminder setBackgroundColor:CLEARCOLOUR];
        [tblReminder setDelegate:self];
        [tblReminder setDataSource:self];
        [tblReminder setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [self addSubview:tblReminder];
        arrReminder=[[NSMutableArray alloc] initWithArray:[Reminders fetchReminderDetails]];
        
        lblNoReminders=[[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y-40, 320, 40)];
        [lblNoReminders setBackgroundColor:CLEARCOLOUR];
        [lblNoReminders setText:@"NO REMINDER"];
        [lblNoReminders setTextAlignment:NSTextAlignmentCenter];
        [lblNoReminders setTextColor:[UIColor lightGrayColor]];
        [lblNoReminders setFont:KSetFont(kDefaultFontName, 25.0f)];
        [self addSubview:lblNoReminders];
    }
    return self;
}

#pragma mark-
#pragma mark- UITableView Delegate and Datasource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrReminder count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Reminders *objReminder=[arrReminder objectAtIndex:indexPath.row];
    NSString *strCellID=[NSString stringWithFormat:@"Cell_%@",objReminder.reminderId];
    
    TaskCell *cell=[tableView dequeueReusableCellWithIdentifier:strCellID];
    if (cell==nil)
    {
        [lblNoReminders setHidden:YES];
        cell=[[TaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellID withReminderData:objReminder];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *VC=UIViewParentController(self);
    CreateNewReminer *objViewcontroller = (CreateNewReminer *)[VC.storyboard instantiateViewControllerWithIdentifier:@"CreateNewReminer"];
    [objViewcontroller setIsFromHomeScreen:YES];
    [VC.navigationController pushViewController:objViewcontroller animated:YES];
}

@end
