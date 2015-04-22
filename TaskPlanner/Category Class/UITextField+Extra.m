//
//  UITextField+Extra.m
//  TwoTwit
//
//  Created by nayan mistry on 07/01/15.
//  Copyright (c) 2015 nayan mistry. All rights reserved.
//

#import "UITextField+Extra.h"

@implementation UITextField (Extra)

@dynamic btnClearText;

-(void)desingTextFieldForPLaceHolder:(NSString *)placeHolder LeftViewImage:(NSString *)strImgName BorderColor:(UIColor *)borderColor PlaceHolderColor:(UIColor *)placeColor withLeftViewFrame:(CGRect)rect
{
    [self setPlaceholder:placeHolder];
    
    UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [strImgName length]>0?rect.size.width:5, rect.size.height)];
    [leftView setBackgroundColor:CLEARCOLOUR];
    
    UIImageView *imgLeftView=[[UIImageView alloc] init];
     [imgLeftView setFrame:CGRectMake(0, 0, [strImgName length]>0?rect.size.width-5:5, rect.size.height)];
    [imgLeftView setBackgroundColor:[strImgName length]>0?borderColor:CLEARCOLOUR];
    [imgLeftView setImage:GET_IMAGE_WITH_NAME(strImgName)];
    [imgLeftView setContentMode:UIViewContentModeCenter];
    [leftView addSubview:imgLeftView];
    
    [self setLeftView:leftView];
    [self setLeftViewMode:UITextFieldViewModeAlways];
    [[self layer] setBorderColor:borderColor.CGColor];
    [[self layer] setBorderWidth:1.0f];
    [self setValue:placeColor forKeyPath:@"_placeholderLabel.textColor"];
    
    [self setClearButtonMode:UITextFieldViewModeNever];
    
    UIView *rightView=[[UIView alloc] initWithFrame:CGRectMake(0, 0,rect.size.width-5, rect.size.height)];
    [rightView setBackgroundColor:CLEARCOLOUR];
    
}

@end
