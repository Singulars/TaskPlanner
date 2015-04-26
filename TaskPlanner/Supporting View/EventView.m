//
//  EventView.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 19/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "EventView.h"
#import "CreateNewReminer.h"
#import "EventCell.h"

@implementation EventView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        tblEvent=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        if (IS_IPHONE4) {
            [tblEvent setFrame:CGRectMake(tblEvent.frame.origin.x, tblEvent.frame.origin.y, tblEvent.frame.size.width, tblEvent.frame.size.height)];
        }
        [tblEvent setBackgroundColor:CLEARCOLOUR];
        [tblEvent setDelegate:self];
        [tblEvent setDataSource:self];
        [tblEvent setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [self addSubview:tblEvent];
        
        [self setBackgroundColor:CLEARCOLOUR];
        lblNoEvent=[[UILabel alloc] initWithFrame:CGRectMake(0,  self.center.y-40, 320, 40)];
        [lblNoEvent setBackgroundColor:CLEARCOLOUR];
        [lblNoEvent setText:@"NO EVENT"];
        [lblNoEvent setTextColor:[UIColor lightGrayColor]];
        [lblNoEvent setTextAlignment:NSTextAlignmentCenter];
        [lblNoEvent setFont:KSetFont(kDefaultFontName, 25.0f)];
        [self addSubview:lblNoEvent];
        
       arrEvents=[[NSMutableArray alloc] initWithArray:[Reminders fetchReminderDetails]];
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
    return [arrEvents count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Reminders *objReminder=[arrEvents objectAtIndex:indexPath.row];
    NSString *strCellID=[NSString stringWithFormat:@"Cell_%@",objReminder.reminderId];
    
    EventCell *cell=[tableView dequeueReusableCellWithIdentifier:strCellID];
    if (cell==nil)
    {
        [lblNoEvent setHidden:YES];
        cell=[[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellID withEventData:objReminder];
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
