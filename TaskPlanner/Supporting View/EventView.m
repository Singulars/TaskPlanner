//
//  EventView.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 19/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "EventView.h"

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
        
        arrEvents=[NSMutableArray arrayWithObjects:@"Google Event",@"Anniversary", @"On Date",@"Birthday",@"Painting Exhibition",@"Seminar on hacking",@"Morning walk",nil];
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
    NSString *strCellID=[NSString stringWithFormat:@"Cell_%li",(long)indexPath.row];
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:strCellID];
    if (cell==nil)
    {
         [lblNoEvent setHidden:YES];
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
