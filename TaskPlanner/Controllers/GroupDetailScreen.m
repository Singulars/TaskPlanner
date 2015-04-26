//
//  GroupDetailScreen.m
//  TaskPlanner
//
//  Created by Verma Mukesh on 26/04/15.
//  Copyright (c) 2015 Singularsllp. All rights reserved.
//

#import "GroupDetailScreen.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation GroupDetailScreen

@synthesize isNewGroup;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [Common setBackGroundImageToNavigationBar:self.navigationController.navigationBar withImageColor:APPORANGECOLOR];
    
     [parallexHeaderView setHeaderImage:[UIImage imageNamed:@"coverBG"]];
    
    UILabel *NavTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    NavTitle.backgroundColor = [UIColor clearColor];
    NavTitle.font =ScreenTitleFontWithOutBold;
    NavTitle.textAlignment = NSTextAlignmentCenter;
    NavTitle.textColor = [UIColor whiteColor];
    [NavTitle setText:(isNewGroup)?@"Create Group":@"Edit Group"];
    [NavTitle sizeToFit];
    [self.navigationItem setTitleView:NavTitle];
    
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:(isNewGroup)?@"leftIcon":@"menuIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackTapped:)];
    [leftBarItem setTintColor:kWhiteColor];
    [self.navigationItem setLeftBarButtonItem:leftBarItem];
    
    UIBarButtonItem *rightBarItem=[[UIBarButtonItem alloc] initWithTitle:(isNewGroup)?@"Create":@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(btnSaveGroupTapped:)];
    [rightBarItem setTintColor:kWhiteColor];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
    
    [[btnGroupIcon layer] setCornerRadius:btnGroupIcon.frame.size.width/2];
    [btnGroupIcon setClipsToBounds:YES];
    [[btnGroupIcon layer] setBorderWidth:3.0f];
    [[btnGroupIcon layer] setBorderColor:kWhiteColor.CGColor];
    
     [[btnDeleteGroup titleLabel] setFont:KSetFont(kDefaultFontName, 20.0f)];
    
    [lblDeleteGroup setFont:KSetFont(kDefaultFontName, 18)];
    [lblTotalMembers setFont:KSetFont(kDefaultFontName, 18)];
    [txtGroupName setFont:KSetFont(kDefaultFontName, 18)];
    
    if (IS_IPHONE5) {
        [self.tableView setScrollEnabled:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UISCrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [parallexHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
}

#pragma mark-
#pragma mark- Button Action Methods

-(IBAction)btnBackTapped:(id)sender
{
    if (isNewGroup) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    ContainerViewController *objContainer = (ContainerViewController *)self.parentViewController.parentViewController;
    [objContainer moveNavigationMenu];
}
-(IBAction)btnSaveGroupTapped:(id)sender
{
    
}
- (IBAction)btnDeleteGroupTapped:(id)sender {
    
    [actView startAnimating];
}

- (IBAction)btnGroupIconTapped:(id)sender {
    
        UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:APP_NAME delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Choose Photo",@"Take Photo", nil];
        [actionSheet showInView:self.view];
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
            [self openPhotoAlbumAndChoosePhoto];
        }
            break;
            
        case 1:
        {
            [self openCameraAndTakePhoto];
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

-(void)openPhotoAlbumAndChoosePhoto
{
    
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [picker setAllowsEditing:YES];
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    picker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)openCameraAndTakePhoto
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.modalPresentationStyle = UIModalPresentationCurrentContext;
        [picker setAllowsEditing:YES];
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        [Common ShowAlertAccordingTOInstagram:@"Camera is not available."];
    }
}

#pragma mark
#pragma mark - Image/Video Picker Delegate


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^(void){
        
        NSString *mediaType = info[UIImagePickerControllerMediaType];
        
        switch (picker.sourceType) {
                
            case UIImagePickerControllerSourceTypeCamera:
            {
                if([mediaType isEqualToString:(NSString *)kUTTypeImage])
                {
                    imgProfile=[[(UIImage *)[info objectForKey:UIImagePickerControllerEditedImage] fixOrientation] compressImageForWidth:SCREENWIDTH*2 AndHeight:SCREENWIDTH*2];
                    [btnGroupIcon setImage:imgProfile forState:UIControlStateNormal];
                    
                }
            }
                break;
                
            case UIImagePickerControllerSourceTypePhotoLibrary:
            {
                imgProfile=[[(UIImage *)[info objectForKey:UIImagePickerControllerEditedImage] fixOrientation] compressImageForWidth:SCREENWIDTH*2 AndHeight:SCREENWIDTH*2];
                [btnGroupIcon setImage:imgProfile forState:UIControlStateNormal];
            }
                break;
                
            default:
                break;
        }
        
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}




@end
