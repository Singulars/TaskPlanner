//
//  TaskVIew.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 19/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "TaskVIew.h"

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
        arrReminder=[NSMutableArray arrayWithObjects:@"Google Event",@"Anniversary", @"On Date",@"Birthday",@"Painting Exhibition",@"Seminar on hacking",@"Morning walk",nil];
        
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
    NSString *strCellID=[NSString stringWithFormat:@"Cell_%li",(long)indexPath.row];
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strCellID];
    if (cell==nil)
    {
        [lblNoReminders setHidden:YES];
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCellID];
        
        UIImageView *imgPicture=[[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
        [imgPicture setBackgroundColor:CLEARCOLOUR];
        [imgPicture setImage:GET_IMAGE_WITH_NAME(@"demoPic")];
        [[imgPicture layer] setCornerRadius:imgPicture.frame.size.width/2];
        [imgPicture setClipsToBounds:YES];
        [cell addSubview:imgPicture];
        
        UILabel *lblName=[[UILabel alloc] initWithFrame:CGRectMake(60, 10, SCREENWIDTH-80, 30)];
        [lblName setBackgroundColor:CLEARCOLOUR];
        [lblName setText:@"Google Event"];
        [lblName setFont:KSetFont(kDefaultBoldFontName, 15.0f)];
        [cell addSubview:lblName];
        
        UILabel *lblDate=[[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-120, 10, 110, 30)];
        [lblDate setBackgroundColor:CLEARCOLOUR];
        [lblDate setText:@"19/04/2015 9:30 AM"];
        [lblDate setFont:KSetFont(kDefaultFontName, 11.0f)];
        [cell addSubview:lblDate];
        
        
        UILabel *lblDesc=[[UILabel alloc] initWithFrame:CGRectMake(60, 30, SCREENWIDTH-80, 50)];
        [lblDesc setBackgroundColor:CLEARCOLOUR];
        [lblDesc setText:@"We all must take part in such kind of events."];
        [lblDesc setNumberOfLines:0];
        [lblDesc setNumberOfLines:2];
        [lblDesc setFont:KSetFont(kDefaultFontName, 13.0f)];
        [lblDesc setLineBreakMode:NSLineBreakByWordWrapping];
        [lblDesc setTextAlignment:NSTextAlignmentLeft];
        
        [cell addSubview:lblDesc];
        
    }
    
    
    return cell;
}

@end
