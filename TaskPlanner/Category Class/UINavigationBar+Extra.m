//
//  UINavigationBar+Extra.m
//  TwoTwit
//
//  Created by Iphone on 03/02/15.
//  Copyright (c) 2015 nayan mistry. All rights reserved.
//

#import "UINavigationBar+Extra.h"

@implementation UINavigationBar (Extra)


-(void)setTitleAttributes
{
    [self setTitleTextAttributes:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor blackColor],ScreenTitleFontWithOutBold, nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName,NSFontAttributeName, nil]]];
}
@end
