//
//  Common.m
//  TwoTwit
//
//  Created by nayan mistry on 06/01/15.
//  Copyright (c) 2015 nayan mistry. All rights reserved.
//

#import "Common.h"
#import "NSData+Extra.h"

@implementation Common


+(void)makeTabBarHidden:(BOOL)hide TabBarController:(UITabBarController *)tabBarController{
    if ( [tabBarController.view.subviews count] < 2 ) {
        return;
    }
    
    UIView *contentView;
    
    if ( [[tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ) {
        contentView = [tabBarController.view.subviews objectAtIndex:1];
    } else {
        contentView = [tabBarController.view.subviews objectAtIndex:0];
    }
    
    if (hide) {
        contentView.frame = tabBarController.view.bounds;
    }
    else {
        contentView.frame = CGRectMake(tabBarController.view.bounds.origin.x,
                                       tabBarController.view.bounds.origin.y,
                                       tabBarController.view.bounds.size.width,
                                       tabBarController.view.bounds.size.height - tabBarController.tabBar.frame.size.height);
    }
    
    tabBarController.tabBar.hidden = hide;
}



+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL*)URL skip:(BOOL)skip
{
    NSError* error = nil;
    BOOL success = [URL setResourceValue:[NSNumber numberWithBool:skip] forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (!success) {
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

+(void)LoadProfileImageAndSaveToLocal
{
    NSString *strImgName=kProfilePicForThumb(ShareObj.objLoginUser.userId);
    NSURL *imageUrl= [NSURL URLWithString:kProfileImageUrl(strImgName)];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        NSData *data = [NSData dataWithContentsOfURL:imageUrl];
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (data) {
                [Common saveImage:data :strImgName Indirectory:kProfileDictionaryName];
            }
        });
    });
}

+ (NSNumber *)generateID {
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSNumber *timeStampObj = [NSNumber numberWithInteger:timeStamp];
    return timeStampObj;
}

+(float)GetRowHeightAccordingToImageSize:(CGSize)imageSize
{
    float actualHeight = imageSize.height;
    float actualWidth = imageSize.width;
    float maxHeight = ImageHeight;
    float maxWidth = ImageWidth;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    return actualHeight;
}

+(NSString *)getFullDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [formatter setDateFormat:kDefaultDateFormat];
    return [formatter stringFromDate:[NSDate date]];
}

+(BOOL)IsTimeFormat12or24
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
    NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
    BOOL is24h = (amRange.location == NSNotFound && pmRange.location == NSNotFound);
    return is24h;
}

+(BOOL)IsTimeFormat12or24OfString:(NSString *)time
{
    NSRange amRange = [time rangeOfString:@"AM"];
    NSRange pmRange = [time rangeOfString:@"PM"];
    BOOL is24h = (amRange.location == NSNotFound && pmRange.location == NSNotFound);
    return is24h;
}

+(NSString *)getBirthdayFormat:(NSString *)strBirthdate
{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:kDefaultShortDateFormat];
    NSDate *BDate = [df dateFromString:strBirthdate];
    df=[[NSDateFormatter alloc] init];
    [df setDateFormat:kReminderDateormat];
    NSString *strDate = [df stringFromDate:BDate];
    return strDate;
}

+(NSString *)getTimeInAMorPM:(NSString *)time
{
    NSString *strTime;
    
    BOOL isSystem24Hr = [self IsTimeFormat12or24];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    dateFormatter.dateFormat = @"HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:(isSystem24Hr)?time:[time substringWithRange:NSMakeRange(0, 8)]];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setTimeZone:[NSTimeZone systemTimeZone]];
    dateFormatter1.dateFormat = (isSystem24Hr)?@"HH:mm":@"hh:mm a";
    strTime = [dateFormatter1 stringFromDate:date];
    
    return strTime;
}

+(NSString *)getDateInAMorPMFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *gmt = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [formatter setTimeZone:gmt];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSString *strTime=[formatter stringFromDate:[NSDate date]];
    return strTime;
}

+(NSString *)getOnlyDateFromDateString:(NSString *)strDate
{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setDateFormat:kDefaultDateFormat];
    NSDate *date=[df dateFromString:strDate];
    [df setDateFormat:kDefaultShortDateFormat];
    return [df stringFromDate:date];
}

+(NSString *)getOnlyTimeStampFromDateString:(NSString *)strDate
{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [df setDateFormat:kDefaultDateFormat];
    [formatter1 setDateFormat:@"HH:mm:ss"];
    NSDate *date=[df dateFromString:strDate];
    
    return [formatter1 stringFromDate:date];
}

+(NSString *)getOnlyTimeStampFromDateForListIng:(NSString *)strDate
{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    [df setDateFormat:kDefaultDateFormat];
    NSDate *date=[df dateFromString:strDate];
    BOOL isSystem24Hr = [self IsTimeFormat12or24];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setTimeZone:[NSTimeZone systemTimeZone]];
    formatter1.dateFormat = (isSystem24Hr)?@"HH:mm":@"hh:mm a";
    
    return [formatter1 stringFromDate:date];
}

+(NSString *)getOnlyTimeStampFromDateStringForWeb:(NSString *)strDate
{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [df setDateFormat:kDefaultDateFormat];
    NSDate *date=[df dateFromString:strDate];
    BOOL isSystem24Hr = [self IsTimeFormat12or24];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setTimeZone:[NSTimeZone systemTimeZone]];
    formatter1.dateFormat = (isSystem24Hr)?@"HH:mm":@"hh:mm a";
    
    return [formatter1 stringFromDate:date];
}

+(NSString *)getOnlyDateFromDateStringForWeb:(NSString *)strDate
{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [df setDateFormat:kDefaultDateFormat];
    NSDate *date=[df dateFromString:strDate];
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setTimeZone:[NSTimeZone systemTimeZone]];
    formatter1.dateFormat = kDefaultShortDateFormat;
    
    return [formatter1 stringFromDate:date];
}

+(NSDate *)ConvertDateTosystemTimeZone:(NSString *)strDate
{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [df setDateFormat:kDefaultDateFormat];
    NSDate *date=[df dateFromString:strDate];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter1 setDateFormat:kDefaultDateFormat];
    NSString *sysTemDate=[formatter1 stringFromDate:date];
    return [formatter1 dateFromString:sysTemDate];
}
+(NSString *)getStringFromDate:(NSDate *)date
{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [df setDateFormat:kDefaultDateFormat];

    NSString *strDate = [df stringFromDate:date];
    return strDate;
}

+(NSString*)getUniqName{
    
    NSDateFormatter *dateStartFormatter = [[NSDateFormatter alloc] init];
    [dateStartFormatter setDateFormat:@"ddMMyyHHMMSS"];
    return [NSString stringWithFormat:@"%@",[dateStartFormatter stringFromDate:[NSDate date]]];
}

+(NSString *)saveImage:(NSData *)ImageData :(NSString *)strPath Indirectory:(NSString *)directoryName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:directoryName];
    NSError *error;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&error];
        [Common addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:dataPath] skip:YES];
    }
    
    NSString *Path =[dataPath stringByAppendingPathComponent:strPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:Path contents:ImageData attributes:nil];
    return Path;
}

+(NSString *)getImage:(NSString *)strId fromDirectory:(NSString *)directory{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:directory];
    
    NSError *error;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    [Common addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:dataPath] skip:YES];
    
    NSString *strPath;
    
    strPath =[dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strId]];
    return strPath;
}

+ (NSString *)getForProfilePicAvailibility:(NSString *)strImageName
{
    NSString*imagePath = [kProfilePicDirectoryPath stringByAppendingPathComponent:strImageName];
    if ([[NSFileManager defaultManager]fileExistsAtPath:imagePath])
    {
        return imagePath;
    }
    
    return @"";
}


+(BOOL)RenameFileWithName:(NSString *)strNewName OldImageName:(NSString *)strOldName Indirectory:(NSString *)directoryName
{
    BOOL isReNamed=FALSE;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:directoryName];
    NSString *NewPath = [dataPath stringByAppendingPathComponent:strNewName];
    NSString *oldPath = [dataPath stringByAppendingPathComponent:strOldName];
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:oldPath]){
        isReNamed =[fm moveItemAtPath:oldPath toPath:NewPath error:&error];
        NSLog(@"%@",[error description]);
    }
    
    return isReNamed;
}

+(void)ResizeImage:(UIImage *)image SaveToDirectory:(NSString *)strDirectory FileName:(NSString *)strFileName ForFrameSize:(CGRect)rect
{
    UIImageView *imgViewPhoto = [[UIImageView alloc] initWithFrame:rect];
    [imgViewPhoto setBackgroundColor:[UIColor clearColor]];
    [imgViewPhoto setImage:image];
    [imgViewPhoto setContentMode:UIViewContentModeScaleToFill];
    
    UIGraphicsBeginImageContextWithOptions(imgViewPhoto.bounds.size, NO, 1.0);
    [imgViewPhoto.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self saveImage:UIImagePNGRepresentation(croppedImage) :strFileName Indirectory:strDirectory];
}


+(void)DeleteFile:(NSString *)strFileName FromDirectory:(NSString *)directoryName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:directoryName];
    
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:dataPath]){
        NSString *fullPath = [dataPath stringByAppendingPathComponent:strFileName];
        BOOL success = [fm removeItemAtPath:fullPath error:&error];
        if (!success || error) {
        }
    }
}

+(void)DeleteImagesFromDirectory:(NSString *)directory
{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:directory];
    NSError *error;
    
    for (NSString *file in [fm contentsOfDirectoryAtPath:dataPath error:&error]) {
        NSString *fullPath = [dataPath stringByAppendingPathComponent:file];
        BOOL success = [fm removeItemAtPath:fullPath error:&error];
        if (!success || error) {
            // it failed.
        }
    }
}

+ (void)setBackGroundImageToNavigationBar:(UINavigationBar *)navBar withImageColor:(UIColor *)color
{
    UIImage *navBarImage;
    navBarImage = [[self imageWithColor:color] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    
    [navBar setBackgroundImage:navBarImage forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    
    [navBar setShadowImage:[UIImage new]];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);// Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImageView *)setBackground{
    
    UIImageView *boxBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    
    boxBackView.image = [UIImage imageNamed:(IS_IPHONE5)?@"backgroundImage_iphone5":@"backgroundImage"];
    
    return boxBackView;
}

+(void)ShowAlertAccordingTOInstagram:(NSString *)strMsg
{
    UIView *recentView=[(UIView *)[APP_DELEGATE window] viewWithTag:555];
    if (recentView) {
        return;
    }
    
    UIView *viewAlert=[[UIView alloc] initWithFrame:CGRectMake(0, -64, SCREENWIDTH, 64)];
    [viewAlert setBackgroundColor:ALERTBGCOLOR];
    [viewAlert setTag:555];
    UILabel *lblMessage=[[UILabel alloc] initWithFrame:CGRectMake(0, 20, viewAlert.frame.size.width, viewAlert.frame.size.height-20)];
    [lblMessage setBackgroundColor:CLEARCOLOUR];
    [lblMessage setText:strMsg];
    [lblMessage setTextColor:[UIColor whiteColor]];
    [lblMessage setTextAlignment:NSTextAlignmentCenter];
    [lblMessage setFont:KSetFont(kDefaultFontName, (IS_IPAD)?20:15.0f)];
    [viewAlert addSubview:lblMessage];
    
    [[APP_DELEGATE window] addSubview:viewAlert];
    
    [UIView animateWithDuration:0.5 animations:^{
        [viewAlert setFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            [viewAlert setAlpha:0.9];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [viewAlert setFrame:CGRectMake(0, -64, SCREENWIDTH, 64)];
            } completion:^(BOOL finished) {
                [viewAlert removeFromSuperview];
            }];
        }];
    }];
}

+(void)DeleteTemporaryFileContent
{
    
    @try {
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *dataPath=NSTemporaryDirectory();
        
        NSError *error = nil;
        
        for (NSString *file in [fm contentsOfDirectoryAtPath:dataPath error:&error])
        {
        [fm removeItemAtPath:[dataPath stringByAppendingPathComponent:file] error:&error];
            
            //NSLog(@"Failed to Delete : %@",[error debugDescription]);
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

+ (void)applyAppleBorderAndHighlightImageToButtons:(NSArray *)buttons withRadius:(CGFloat)radius font:(NSString *)fontName fontSize:(CGFloat)fontSize fontNormalColor:(UIColor *)nFcolor fontHighlightedColor:(UIColor *)hFcolor btnNormalColor:(UIColor *)nColor btnHighlightedColor:(UIColor *)hColor andBorderWidth:(CGFloat)borderWidth
{
    for (UIButton *button in buttons) {
        
        button.titleLabel.font = [UIFont fontWithName:fontName size:fontSize];
        [button.layer setCornerRadius:radius];
        [button.layer setMasksToBounds:YES];
        [button.layer setBorderWidth:borderWidth];
        
        [button setTitleColor:nFcolor forState:UIControlStateNormal];
        [button setTitleColor:hFcolor forState:UIControlStateHighlighted];
        [button setTitleColor:hFcolor forState:UIControlStateSelected];
        
        [button.layer setBorderColor:hColor.CGColor];
        
        [button setBackgroundImage:[self imageWithColor:nColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:hColor] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[self imageWithColor:hColor] forState:UIControlStateSelected];
    }
}

+(NSString *)CheckForFileAtPath:(NSString *)strFileName withDirName:(NSString *)strDir
{
    NSArray *docPaths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES);
    NSString *dataPath = [docPaths objectAtIndex:0];
    
    NSString *filePathAndDirectory = [dataPath stringByAppendingPathComponent:strDir];
    
    //***  Create Profile Pic Folder in Libreary if Not Exists......***//efewfewfwefew
    
    NSError *error = nil;
    BOOL isFileExists;
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:filePathAndDirectory isDirectory:&isFileExists])
    {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:filePathAndDirectory
                                       withIntermediateDirectories:NO
                                                        attributes:nil
                                                             error:&error])
        {
            //NSLog(@"Create directory error: %@", error);
        }
        [Common addSkipBackupAttributeToItemAtURL:[NSURL URLWithString:dataPath] skip:YES];
    }
    
    //***  Store Image to Local Path and Set Image to Button......***//
    
    NSString*videoPath = [filePathAndDirectory stringByAppendingPathComponent:strFileName];
    
    return videoPath;
}
///qw qewe we wef fwe w+adwdmdw

+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark- Fetch Contacts

+ (NSMutableDictionary *)getValueFromPlist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"PInfo.plist"]; //3
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path])
    {
        return [[NSMutableDictionary alloc] init];
    }
    
    return [[NSMutableDictionary alloc] initWithContentsOfFile:path];
}

+ (void)setValueToPlist:(NSMutableDictionary *)Info
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"PInfo.plist"]; //3
    
    [Info writeToFile: path atomically:YES];
}

+ (NSMutableArray *)FetchContactsArray:(ABAddressBookRef)addressBook
{
    NSMutableArray *arrContacts = [[NSMutableArray alloc] init];
    NSMutableArray *arrUsers = [[NSMutableArray alloc] init];
    
    NSMutableArray *thePeople = (__bridge  NSMutableArray*)ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"/:.()-*#+"];
    
    NSDate *lastSyncDate = [[self getValueFromPlist] objectForKey:kLASTSYNCDATE];
    
    [thePeople enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ABRecordRef person = (__bridge ABRecordRef)obj;
        ABMultiValueRef phones =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(person, kABPersonPhoneProperty));
        
        NSString *strPhone=@"";
        NSString *strFirstName=@"";
        NSString *strLastName=@"";
        
        NSString *myNumber=ShareObj.objLoginUser.mobileNmber;
        
        if (ABMultiValueGetCount(phones)>0)
        {
            for (int k=0; k<ABMultiValueGetCount(phones); k++) {
                
                strPhone =(__bridge NSString *)ABMultiValueCopyValueAtIndex(phones,k);
                strFirstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
                strLastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
                
                NSString *ContactName=[NSString stringWithFormat:@"%@ %@",(strFirstName==nil)?@"":strFirstName,(strLastName==nil)?@"":strLastName];
                
                strPhone = [[strPhone componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString:@""];
                NSArray *parts = [strPhone componentsSeparatedByCharactersInSet:whitespaces];
                NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
                strPhone = [filteredArray componentsJoinedByString:@""];
                
                if ([strPhone length]>0) {
                   // ContactDetails *object=[ContactDetails fetchAndCheckUserByMobileNumber:strPhone];
                    
                    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
                    NSString *strname=[ContactName stringByTrimmingCharactersInSet:whitespaces];
                    
                    if (![strPhone isEqualToString:myNumber]) {
                        NSDate *modifyDate = (__bridge NSDate *)ABRecordCopyValue(person, kABPersonModificationDateProperty);
                        if (modifyDate)
                        {
                            if(lastSyncDate != nil)
                            {
                                if([lastSyncDate earlierDate:modifyDate])
                                {
                                    NSMutableDictionary *diccOFRecoed=[[NSMutableDictionary alloc] init];
                                    [diccOFRecoed setObject:(strPhone==nil)?@"":strPhone forKey:kcontactNumber];
                                    
                                    [diccOFRecoed setObject:([strname length]>0)?ContactName:(strPhone==nil)?@"":strPhone forKey:kfirstName];
                                    [arrContacts addObject:strPhone];
                                    [arrUsers addObject:diccOFRecoed];
                                }
                            }
                            else
                            {
                                NSMutableDictionary *diccOFRecoed=[[NSMutableDictionary alloc] init];
                                [diccOFRecoed setObject:(strPhone==nil)?@"":strPhone forKey:kcontactNumber];
                                
                                [diccOFRecoed setObject:([strname length]>0)?ContactName:(strPhone==nil)?@"":strPhone forKey:kfirstName];
                                [arrContacts addObject:strPhone];
                                [arrUsers addObject:diccOFRecoed];
                            }

                            }
                        }
                    }
                }
            }
        
    }];
    
    lastSyncDate = [NSDate date];
    NSMutableDictionary *dic = [self getValueFromPlist];
    [dic setObject:lastSyncDate forKey:kLASTSYNCDATE];
    [self setValueToPlist:dic];
    NSLog(@"--%@", arrUsers);
    //[ContactDetails InsertUserDuringSyncContacts:arrUsers];
    return arrContacts;
}

+(NSMutableArray *)getAllNewContactsFromContactList
{
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    __block NSMutableArray *arrContacts = [[NSMutableArray alloc] init];
    
    __block BOOL accessGranted = NO;
    
    switch (ABAddressBookGetAuthorizationStatus())
    {
        case  kABAuthorizationStatusAuthorized:
        {
            arrContacts=[self FetchContactsArray:addressBook];
        }
            break;
            
        case  kABAuthorizationStatusNotDetermined :
            
            if (ABAddressBookRequestAccessWithCompletion != NULL) {
                dispatch_semaphore_t sema = dispatch_semaphore_create(0);
                
                ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                    accessGranted = granted;
                    dispatch_semaphore_signal(sema);
                });
                
                dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            }
            else {
                accessGranted = YES;
            }
            
            if (accessGranted) {
                arrContacts=[self FetchContactsArray:addressBook];
            }
            break;
            
        case  kABAuthorizationStatusDenied:
        case  kABAuthorizationStatusRestricted:
        {
            MY_ALERT(APP_NAME, @"Permission was not granted for contacts.\nPlease go to setting screen and in the privacy section select contact and enable W3post app.", nil);
        }
            break;
            
        default:
            break;
    }
    
    return arrContacts;
}


@end
