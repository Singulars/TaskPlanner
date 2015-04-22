//
//  UIImage+Extra.h
//  GoGeo
//
//  Created by nayan mistry on 07/04/14.
//  Copyright (c) 2014 nayan mistry. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (Extra)

- (UIImage *)fixOrientation;
-(UIImage *)compressImageForWidth:(float)MaxImageW AndHeight:(float)MaxImageH;
- (UIImage *) renderAtSize:(const CGSize) size;
- (UIImage *) maskWithImage:(const UIImage *) maskImage;
- (UIImage *) maskWithColor:(UIColor *) color;
- (UIImage *)imageWithColor:(UIColor *)color1;
-(UIImage *)ResizeForChatImageDisaply;
- (UIImage *)resizeImagewithWidth:(CGFloat)width withHeight:(CGFloat)height;
- (UIImage *)cropImageWithSize:(CGRect)rect;
+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaleToSize:(CGSize)size;
@end
