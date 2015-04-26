//
//  Constant.h
//  TwoTwit
//
//  Created by nayan mistry on 06/01/15.
//  Copyright (c) 2015 nayan mistry. All rights reserved.
//

#ifndef TwoTwit_Constant_h
#define TwoTwit_Constant_h


#pragma mark-
#pragma mark- Framework

#import <UIKit/UIKit.h>


//*//*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//

#pragma mark-
#pragma mark- Class


#import "ContainerViewController.h"
#import "AppDelegate.h"
#import "SharedManager.h"
#import "Common.h"
#import "APIConnection.h"
#import "NSString+Extra.h"
#import "UITextField+Extra.h"
#import "UINavigationBar+Extra.h"
#import "UIButton+Extra.h"
#import "NSData+Extra.h"
#import "UIImage+Extra.h"

#import "Reachability.h"
#import "ProfileImageDownloader.h"



//*//*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//

#pragma mark-
#pragma mark- Model Classes

//*//*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//

#pragma mark-
#pragma mark - Enums

typedef enum : NSUInteger {
    MALE,
    FEMALE,
} Gender;


//*//*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//

#pragma mark -
#pragma mark - Check System Version


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//*//*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//

#pragma mark -
#pragma mark - Check Device Type


#define IS_IPHONE5                  CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size,CGSizeMake(640, 1136))
#define IS_IPHONE4                  CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size,CGSizeMake(640, 960))
#define IS_IPHONE                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)?YES:NO
#define IS_IPAD                     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?YES:NO

#define PICTUREWIDTH SCREENWIDTH
#define PICTUREHEIGHT SCREENWIDTH

#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define NAVHIEGHT 44.0
#define KEYBOARDHEIGHT 216.0
#define NAVBARHEIGHT 64.0f
#define ZEROINSET UIEdgeInsetsMake(0, 0, 0, 0)
#define SCREENBOUNDS CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)

#define CELL_CONTENT_WIDTH SCREENWIDTH-84.0f
#define CELL_CONTENT_MARGIN 10.0f
#define EXTRACELLHeight ((IS_IPAD)?70:50)
#define cellHeight 20
#define cellwidth 30

//*//*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//

#pragma mark -
#pragma mark - Common/Misc Constant

#define UIViewParentController(__view) ({ \
UIResponder *__responder = __view; \
while ([__responder isKindOfClass:[UIView class]]) \
__responder = [__responder nextResponder]; \
(UIViewController *)__responder; \
})

#define userIntrectionEnable(value)   [APP_DELEGATE window].userInteractionEnabled = value
#define ShowNetworkIndicatorVisible(value)  [UIApplication sharedApplication].NetworkActivityIndicatorVisible=value
#define ShowHideStatusBarVisible(value) [[UIApplication sharedApplication] setStatusBarHidden:value]

#define APPORANGECOLOR COLOR_WITH_RGBA(238.0f,126.0f,26.0f,1.0)
#define APPBLACKCOLOR COLOR_WITH_RGBA(17.0f,17.0f,17.0f,1.0)
#define ALERTBGCOLOR APPORANGECOLOR
#define NAVBARCOLOR APPORANGECOLOR
#define TABLEBACKCOLOR COLOR_WITH_RGBA(246.0f, 245.0f, 245.0f, 1.0f)

#define COLOR_WITH_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define CLEARCOLOUR   [UIColor clearColor]

#define GET_IMAGE_WITH_NAME(name) [UIImage imageNamed:(IS_IPAD)?[NSString stringWithFormat:@"%@~iPad",name]:name]

#define kDefaultFontName @"UnDotum"
#define kDefaultBoldFontName @"UnDotum-Bold"


#define ScreenTitleFont KSetFont(kDefaultBoldFontName, 20.0f)
#define ScreenTitleFontWithOutBold KSetFont(kDefaultFontName, (IS_IPAD)?22:20.0f)


#define KSetFont(FontName,FontSize) [UIFont fontWithName:FontName size:FontSize]

#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]

#define kDefaultDateFormat @"dd/MM/yyyy HH:mm:ss"
#define kReminderDateormat @"MMM dd, yyyy HH:mm a"
#define kDefaultShortDateFormat @"yyyy-MM-dd"

#define MY_ALERT(Title,Msg,Delegate) [[[UIAlertView alloc] initWithTitle:Title \
message:Msg \
delegate:Delegate \
cancelButtonTitle:nil \
otherButtonTitles:@"OK", nil] show];


#define APP_NAME                    @"Task Planner"

#define APP_DELEGATE                (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define ShareObj                    [SharedManager sharedInstance]


#define LIB_PATH                    [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define DOC_DIR_PATH                [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define kProfileImageUrl(strName) [NSString stringWithFormat:@"http://singulars.co.in/lawyer/profilePicPlanner/%@",strName]
#define kProfileDictionaryName      @"ProfilePics"
#define kProfilePicForThumb(userId_Mobilenumber) [NSString stringWithFormat:@"%@.png",userId_Mobilenumber]
#define kProfilePicForFull(userId_Mobilenumber)  [NSString stringWithFormat:@"%@.png",userId_Mobilenumber]
#define kProfilePicDirectoryPath    [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:kProfileDictionaryName]


#define ImageWidth 400
#define ImageHeight 400

#define kDataModel                  @"TaskPlanner"
#define kLASTSYNCDATE @"LastDateOfContactSync"

#define kPrivacyString @"By tapping to continue you are indicating that you have read the Privacy Policy and agree to the Terms of Service."
#define kInternetNotAvailableAlert @"Please check your internet connection."

//*//*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//

#pragma mark -
#pragma mark - API Management


#define WEBSERVICE_CALL_URL        @"http://www.singulars.co.in/lawyer/plannerwebservice.php"

#define kRequestTimeOut             60.0f


//*//*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//



#pragma mark-
#pragma mark- Database Entity & Fields Name


//*//*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//



//*//*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//*/*//


#pragma mark-
#pragma mark- API Request/Response parameter and Database fields Name

#define kLoginUserDetails       @"LoginUserDetails"
#define kReminders       @"Reminders"
#define kFriends            @"Friends"

#define kprofilePic                    @"profilePic"
#define kloginType   @"loginType"
#define kdeviceType  @"deviceType"
#define kdeviceToken @"deviceToken"
#define kverificationCode   @"verificationCode"
#define kstatus         @"status"
#define kmessage        @"message"
#define kmode           @"mode"
#define kuserDetails        @"user"
#define kcountryCode                @"countryCode"
#define kcountryId                  @"countryId"
#define kcountryName                @"countryName"
#define knumber                     @"number"
#define kisRegistered               @"isRegistered"
#define ksignUp                     @"signUp"
#define kgetCountry                 @"getCountry"
#define kcountryData                @"countryData"
#define kfirstName                  @"firstName"
#define klastName                   @"lastName"
#define kbirthdate                  @"birthdate"
#define kdeviceInfo                 @"deviceInfo"
#define kmobile                     @"mobile"
#define kuserId                     @"userId"
#define kcontactNumber              @"contactNumber"

#define kcreateReminder             @"createReminder"
#define kreminderTitle              @"reminderTitle"
#define kreminderDescription        @"reminderDescription"
#define kallFriendIds              @"allFriendIds"
#define kisRemindMeOn              @"isRemindMeOn"
#define kreminderDate              @"reminderDate"
#define kreminderId                 @"reminderId"
#define kremindOnDate               @"remindOnDate"
#define kupdateProfile              @"updateProfile"


#endif
