//
//  FriendCell.h
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friends.h"
#import "ProfileImageDownloader.h"

@interface FriendCell : UITableViewCell
{
   
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFriendData:(Friends *)friendData;

@property(nonatomic,assign)  Friends *objFData;

@end
