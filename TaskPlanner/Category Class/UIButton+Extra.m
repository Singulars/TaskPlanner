//
//  UIButton+Extra.m
//  TwoTwit
//
//  Created by Iphone on 03/02/15.
//  Copyright (c) 2015 nayan mistry. All rights reserved.
//

#import "UIButton+Extra.h"

@implementation UIButton (Extra)

-(void)setButtonForUserProfileWithTitle:(NSString *)title AttributeOn:(NSString *)attribute
{
    NSMutableAttributedString *attrFollowers = [[NSMutableAttributedString alloc] initWithString:title];
    [attrFollowers addAttribute:NSFontAttributeName value:KSetFont(kDefaultFontName,(IS_IPAD)?14:9) range:[title rangeOfString:attribute]];
    [self.titleLabel setNumberOfLines:2];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self setAttributedTitle:attrFollowers forState:UIControlStateNormal];
}
@end
