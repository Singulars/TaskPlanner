//
//  Settings.m
//  TaskPlanner
//
//  Created by Chirag on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "Settings.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface Settings ()

@end

@implementation Settings

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:NO];
    [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:APPORANGECOLOR];
    
    UILabel *NavTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    NavTitle.backgroundColor = [UIColor clearColor];
    NavTitle.font =ScreenTitleFontWithOutBold;
    NavTitle.textAlignment = NSTextAlignmentCenter;
    NavTitle.textColor = [UIColor whiteColor];
    [NavTitle setText:@"Settings"];
    [NavTitle sizeToFit];
    [self.navigationItem setTitleView:NavTitle];
    
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menuIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackTapped:)];
    [leftBarItem setTintColor:kWhiteColor];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    
}
#pragma mark-
#pragma mark- Button Action Methods

-(IBAction)btnBackTapped:(id)sender
{
    ContainerViewController *objContainer = (ContainerViewController *)self.parentViewController.parentViewController;
    [objContainer moveNavigationMenu];
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:APP_NAME delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Twitter", nil];
            [actionSheet showInView:self.view];
        }
            break;
        case 1:
        {
            NSLog(@"1");
        }
            break;
            
        default:
            break;
    }
}

#pragma mark
#pragma mark - ActionSheet Delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    NSLog(@"button index= %li",buttonIndex);
    switch (buttonIndex) {
        case 0:
        {
            [self facebookPost];
        }
            break;
            
        case 1:
        {
            [self twitterPost];
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
}
- (void)facebookPost
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [mySLComposerSheet setInitialText:@"iOS 6 Social Framework test!"];
        [mySLComposerSheet addImage:[UIImage imageNamed:@"demo.png"]];
        [mySLComposerSheet addURL:[NSURL URLWithString:@"http://stackoverflow.com/questions/12503287/tutorial-for-slcomposeviewcontroller-sharing"]];
        [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    break;
                    
                default:
                    break;
            }
        }];
        
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
}
- (void)twitterPost
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [mySLComposerSheet setInitialText:@"iOS 6 Social Framework test!"];
        [mySLComposerSheet addImage:[UIImage imageNamed:@"demo.png"]];
        [mySLComposerSheet addURL:[NSURL URLWithString:@"http://stackoverflow.com/questions/12503287/tutorial-for-slcomposeviewcontroller-sharing"]];
        [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    break;
                    
                default:
                    break;
            }
        }];
        
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
