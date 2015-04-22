//
//  UITextField+Extra.h
//  TwoTwit
//
//  Created by nayan mistry on 07/01/15.
//  Copyright (c) 2015 nayan mistry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extra)
{
}

@property(nonatomic,strong) UIButton *btnClearText;

-(void)desingTextFieldForPLaceHolder:(NSString *)placeHolder LeftViewImage:(NSString *)strImgName BorderColor:(UIColor *)borderColor PlaceHolderColor:(UIColor *)placeColor withLeftViewFrame:(CGRect)rect;

@end
