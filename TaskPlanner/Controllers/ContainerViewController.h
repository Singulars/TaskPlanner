//
//  ContainerViewController.h
//  TaskPlanner
//
//  Created by Naresh Kharecha on 4/21/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuScreen.h"

@interface ContainerViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UIPanGestureRecognizer *panRecognizer;
    UIBarButtonItem *btnBarMenu;
}

@property(nonatomic,strong) MenuScreen *objMenuViewController;

@property (nonatomic,retain)UIViewController    *objViewController;

-(void)loadSelectedViewController:(UIViewController *)viewController;
-(void)moveNavigationMenu;

@end
