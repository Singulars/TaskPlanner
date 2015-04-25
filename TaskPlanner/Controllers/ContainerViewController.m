//
//  ContainerViewController.m
//  SportsBetting
//
//  Created by Iphone on 03/03/15.
//  Copyright (c) 2015 iVerve. All rights reserved.
//

#import "ContainerViewController.h"
#import "HomeScreen.h"

static BOOL isMenuOpen = NO;

@interface ContainerViewController ()

@end

@implementation ContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    btnBarMenu=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBarTapped:)];
    
    self.objMenuViewController = (MenuScreen *)[self.storyboard instantiateViewControllerWithIdentifier:@"MenuScreen"];
     UINavigationController *navMenuController = [[UINavigationController alloc] initWithRootViewController:self.objMenuViewController];
    [self.view addSubview:navMenuController.view];
    [self addChildViewController:navMenuController];
    
    [navMenuController didMoveToParentViewController:self];
    
    HomeScreen *objNews = (HomeScreen *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreen"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:objNews];
    //[navController.navigationItem setLeftBarButtonItem:btnBarMenu];
    [navController willMoveToParentViewController:self];
    
    [self addChildViewController:navController];
    [self.view addSubview:navController.view];
    [self.objViewController didMoveToParentViewController:self];
    self.objViewController = navController;
    
    
    //[self setupGestures];
}
-(void)btnBarTapped:(id)sender
{
    ContainerViewController *objContainer = (ContainerViewController *)self.parentViewController.parentViewController;
    [objContainer moveNavigationMenu];
}

- (void)setupGestures
{
    panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    [self.objViewController.view addGestureRecognizer:panRecognizer];
}
-(void)loadSelectedViewController:(UIViewController *)viewController
{
    isMenuOpen = NO;
    [self closeNavigationMenu:viewController];
    
}
-(void)closeNavigationMenu:(UIViewController *)viewController
{
    self.navigationItem.rightBarButtonItem = nil;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        [self manageDeviceIndentity];
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self performAnimationForCenterView:viewController];
        }
    }
     ];
}
- (void)manageDeviceIndentity
{
    self.objViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
- (void)performAnimationForCenterView:(UIViewController *)vc
{
    self.objViewController.view = nil;
    [UIView transitionWithView:self.view
                      duration:0.1
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        BOOL oldState = [UIView areAnimationsEnabled];
                        [UIView setAnimationsEnabled:NO];
                        self.objViewController = vc;
                        [self setupView];
                        [UIView setAnimationsEnabled:oldState];
                    }
                    completion:^(BOOL finished) {
                        if (finished) {
                            //                            [self resetMainView];
                        }
                    }
     ];
}

-(void)setupView
{
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.objViewController];
    [navController.navigationBar setTintColor:[UIColor whiteColor]];
    [navController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil]];
    [navController.navigationBar setBarTintColor:[UIColor redColor]];
    [navController.navigationBar setTranslucent:NO];
    [navController willMoveToParentViewController:self];
    
    [self addChildViewController:navController];
    [self.view addSubview:navController.view];
    [self.objViewController didMoveToParentViewController:self];
    self.objViewController = navController;
    
    [self setupGestures];
}
-(IBAction)movePanel:(UIPanGestureRecognizer *)sender
{
    [self.view endEditing:YES];
    [[[sender view] layer] removeAllAnimations];
    
    CGPoint translatedPoint = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            if(velocity.x > 0)
            {
                if ([sender view].center.x < (SCREENWIDTH/2) ){
                    [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
                    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
                    isMenuOpen = YES;
                }
            }
            else
            {
                if ([sender view].center.x > SCREENWIDTH/2)
                {
                    [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
                    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
                    isMenuOpen = NO;
                }
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [UIView animateWithDuration:0.5 animations:^{
                if ([sender view].center.x >= SCREENWIDTH) {
                    [sender view].center = CGPointMake([sender view].center.x, [sender view].center.y);
                    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
                    isMenuOpen = YES;
                }
                else if ([sender view].center.x < SCREENWIDTH)
                {
                    [sender view].center = CGPointMake(SCREENWIDTH/2, [sender view].center.y);
                    [sender setTranslation:CGPointMake(0, 0) inView:self.view];
                    isMenuOpen = NO;
                }
            }];
        }
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
            
        default:
            break;
    }
}
-(void)moveNavigationMenu
{
    [self.view endEditing:YES];
    if (isMenuOpen) {
        [UIView animateWithDuration:0.5 animations:^{
            //[_objViewController.view setAlpha:0.5f];
           // [_objViewController.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
           // [_objViewController.view setUserInteractionEnabled:YES];
            [_objViewController view].center = CGPointMake(SCREENWIDTH/2, [_objViewController view].center.y);
        }];
        isMenuOpen = NO;
    }
    else
    {
        isMenuOpen = YES;
        [UIView animateWithDuration:0.5 animations:^{
           // [_objViewController.view setAlpha:0.0f];
            //[_objViewController.view setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
          //  [_objViewController.view setUserInteractionEnabled:NO];
            [_objViewController view].center = CGPointMake((SCREENWIDTH+(SCREENWIDTH/4)), [_objViewController view].center.y);
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
