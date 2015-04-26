//
//  TaskCell.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "TaskCell.h"

@implementation TaskCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withReminderData:(Reminders *)ReminderData
{
    objReminder=ReminderData;
    self=[super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
        ProfileImageDownloader *imgPicture=[[ProfileImageDownloader alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
        [imgPicture setBackgroundColor:CLEARCOLOUR];
        [imgPicture setImage:GET_IMAGE_WITH_NAME(@"demoPic") forState:UIControlStateNormal];
        [[imgPicture layer] setCornerRadius:imgPicture.frame.size.width/2];
        [imgPicture setClipsToBounds:YES];
        [self addSubview:imgPicture];
        
        UILabel *lblName=[[UILabel alloc] initWithFrame:CGRectMake(60, 10, SCREENWIDTH-80, 30)];
        [lblName setBackgroundColor:CLEARCOLOUR];
        [lblName setText:objReminder.reminderTitle];
        [lblName setFont:KSetFont(kDefaultBoldFontName, 15.0f)];
        [self addSubview:lblName];
        
        UILabel *lblDate=[[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-120, 10, 110, 30)];
        [lblDate setBackgroundColor:CLEARCOLOUR];
        [lblDate setText:objReminder.reminderDate];
        [lblDate setFont:KSetFont(kDefaultFontName, 11.0f)];
        [self addSubview:lblDate];
        
        
        UILabel *lblDesc=[[UILabel alloc] initWithFrame:CGRectMake(60, 30, SCREENWIDTH-80, 50)];
        [lblDesc setBackgroundColor:CLEARCOLOUR];
        [lblDesc setText:objReminder.reminderDescription];
        [lblDesc setNumberOfLines:0];
        [lblDesc setNumberOfLines:2];
        [lblDesc setFont:KSetFont(kDefaultFontName, 13.0f)];
        [lblDesc setLineBreakMode:NSLineBreakByWordWrapping];
        [lblDesc setTextAlignment:NSTextAlignmentLeft];
        
        [self addSubview:lblDesc];
    }
    return self;
}

@end
