//
//  ProfileImageDownloader.h
//  TwoTwit
//
//  Created by nayan mistry on 12/01/15.
//  Copyright (c) 2015 nayan mistry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileImageDownloaderDelegate <NSObject>

@optional

-(void)ProfileImageDownloaded:(id)obj;

@end

@interface ProfileImageDownloader : UIButton
{
    NSMutableData *imageData;
}

- (void)setImageWithURL:(NSString *)urlString;

@property(nonatomic,strong) id<ProfileImageDownloaderDelegate> delegate;
@property(nonatomic, retain) NSMutableData *imageData;
@property(nonatomic,strong)  NSString *strImageName;
@property(nonatomic,strong) UIImage *ImgDownloaded;
@property(nonatomic,strong) NSNumber *profileUserId;
@property(nonatomic,assign) BOOL wantToSave;
@end
