//
//  ProfileImageDownloader.m
//  TwoTwit
//
//  Created by nayan mistry on 12/01/15.
//  Copyright (c) 2015 nayan mistry. All rights reserved.
//

#import "ProfileImageDownloader.h"

@implementation ProfileImageDownloader

@synthesize imageData;
@synthesize strImageName;
@synthesize ImgDownloaded;
@synthesize delegate;
@synthesize wantToSave;


- (void)setImageWithURL:(NSString *)urlString
{
    [self setContentMode:UIViewContentModeScaleAspectFill];
    NSString *strPath=[Common getImage:strImageName fromDirectory:kProfileDictionaryName];
    UIImage *image=[UIImage imageWithContentsOfFile:strPath];
    [self setImage:(image==nil)?[UIImage imageNamed:@"userDefaultIcon"]:image forState:UIControlStateNormal];
    
    if (ShareObj.isInternetConnected) {
        
        NSURL *url = [NSURL URLWithString:[urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0f];
        NSURLConnection *cn = [NSURLConnection connectionWithRequest:request delegate:self];
        [cn start];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%s %@",__FUNCTION__,[error debugDescription]);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.imageData = [[NSMutableData alloc] initWithCapacity:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.imageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if([self.imageData length] > 0)
    {
         ImgDownloaded=[UIImage imageWithData:self.imageData];
         [self setImage:ImgDownloaded forState:UIControlStateNormal];
        
        if (ImgDownloaded!=nil && !wantToSave) {
            [Common saveImage:self.imageData :strImageName Indirectory:kProfileDictionaryName];
           
        }
        
        if ([delegate respondsToSelector:@selector(ProfileImageDownloaded:)]) {
            [delegate ProfileImageDownloaded:self];
        }
    }
    
    [self setContentMode:UIViewContentModeScaleToFill];
}



@end
