//
//  GroupCell.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "GroupCell.h"

@implementation GroupCell
@synthesize iscellNil;


-(void)CreateGroupWithData:(NSMutableDictionary *)data
{
    iscellNil=TRUE;
    CGRect rect=CGRectMake(0, 0, 140, 140);
    
    ProfileImageDownloader *imgPicture=[[ProfileImageDownloader alloc] initWithFrame:CGRectMake(rect.size.width/2-40, 10, 80, 80)];
    [imgPicture setBackgroundColor:CLEARCOLOUR];
    [imgPicture setImage:GET_IMAGE_WITH_NAME(@"demoPic") forState:UIControlStateNormal];
    [[imgPicture layer] setCornerRadius:imgPicture.frame.size.width/2];
    [imgPicture setClipsToBounds:YES];
    [self addSubview:imgPicture];
    
    UILabel *lblName=[[UILabel alloc] initWithFrame:CGRectMake(0,rect.size.height-45, rect.size.width, 25)];
    [lblName setBackgroundColor:CLEARCOLOUR];
    [lblName setText:@"Relatives"];
    [lblName setTextAlignment:NSTextAlignmentCenter];
    [lblName setFont:KSetFont(kDefaultFontName, 15)];
    [lblName setTextColor:COLOR_WITH_RGBA(51.0f, 51.0f, 51.0f, 1.0)];
    [self addSubview:lblName];
    
    UILabel *lblTotalMembers=[[UILabel alloc] initWithFrame:CGRectMake(0,rect.size.height-25, rect.size.width, 25)];
    [lblTotalMembers setBackgroundColor:CLEARCOLOUR];
    [lblTotalMembers setTextAlignment:NSTextAlignmentCenter];
    [lblTotalMembers setText:@"10 Members"];
    [lblTotalMembers setFont:KSetFont(kDefaultFontName, 12)];
    [lblTotalMembers setTextColor:COLOR_WITH_RGBA(51.0f, 51.0f, 51.0f, 1.0)];
    [self addSubview:lblTotalMembers];
}
@end
