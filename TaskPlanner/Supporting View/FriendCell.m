//
//  FriendCell.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "FriendCell.h"

@implementation FriendCell

@synthesize objFData;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFriendData:(Friends *)friendData
{
    objFData=friendData;
    self=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
        ProfileImageDownloader *imgPicture=[[ProfileImageDownloader alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
        [imgPicture setBackgroundColor:CLEARCOLOUR];
        [[imgPicture layer] setCornerRadius:imgPicture.frame.size.width/2];
        [imgPicture setClipsToBounds:YES];
        [self addSubview:imgPicture];
        
        UILabel *lblName=[[UILabel alloc] initWithFrame:CGRectMake(65, 10, SCREENWIDTH-80, 30)];
        [lblName setBackgroundColor:CLEARCOLOUR];
        [lblName setText:[NSString stringWithFormat:@"%@ %@",friendData.firstName,friendData.lastName]];
        [lblName setFont:KSetFont(kDefaultFontName, 15.0f)];
        [self addSubview:lblName];
    }
    return self;
}

@end
