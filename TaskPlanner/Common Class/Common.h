//
//  Common.h
//  TwoTwit
//
//  Created by nayan mistry on 06/01/15.
//  Copyright (c) 2015 nayan mistry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AddressBook/AddressBook.h>


@interface Common : NSObject
{

}
+ (NSMutableArray *)FetchContactsArray:(ABAddressBookRef)addressBook;
+(NSMutableArray *)getAllNewContactsFromContactList;
+(NSString *)saveImage:(NSData *)ImageData :(NSString *)strPath Indirectory:(NSString *)directoryName;
+ (NSString *)getForProfilePicAvailibility:(NSString *)strImageName;
+(NSString *)getImage:(NSString *)strId fromDirectory:(NSString *)directory;
+(void)ResizeImage:(UIImage *)image SaveToDirectory:(NSString *)strDirectory FileName:(NSString *)strFileName ForFrameSize:(CGRect)rect;
+(void)DeleteFile:(NSString *)strFileName FromDirectory:(NSString *)directoryName;
+(void)DeleteImagesFromDirectory:(NSString *)directory;
+(BOOL)RenameFileWithName:(NSString *)strNewName OldImageName:(NSString *)strOldName Indirectory:(NSString *)directoryName;
+(void)LoadProfileImageAndSaveToLocal;
+(float)GetRowHeightAccordingToImageSize:(CGSize)imageSize;
+(NSString*)getUniqName;
+(NSString *)getFullDate;
+ (NSNumber *)generateID;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (void)setBackGroundImageToNavigationBar:(UINavigationBar *)navBar withImageColor:(UIColor *)color;
+(UIImageView *)setBackground;
+(void)ShowAlertAccordingTOInstagram:(NSString *)strMsg;
+(void)makeTabBarHidden:(BOOL)hide TabBarController:(UITabBarController *)tabBarController;
+ (void)applyAppleBorderAndHighlightImageToButtons:(NSArray *)buttons withRadius:(CGFloat)radius font:(NSString *)fontName fontSize:(CGFloat)fontSize fontNormalColor:(UIColor *)nFcolor fontHighlightedColor:(UIColor *)hFcolor btnNormalColor:(UIColor *)nColor btnHighlightedColor:(UIColor *)hColor andBorderWidth:(CGFloat)borderWidth;
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL*)URL skip:(BOOL)skip;
+(BOOL)IsTimeFormat12or24;
+(BOOL)IsTimeFormat12or24OfString:(NSString *)time;
+(NSString *)getTimeInAMorPM:(NSString *)time;
+(NSString *)getDateInAMorPMFormat;
+(NSString *)getOnlyDateFromDateString:(NSString *)strDate;
+(NSString *)getOnlyTimeStampFromDateString:(NSString *)strDate;
+(NSString *)getOnlyTimeStampFromDateForListIng:(NSString *)strDate;
+(NSString *)getOnlyTimeStampFromDateStringForWeb:(NSString *)strDate;
+(NSString *)getOnlyDateFromDateStringForWeb:(NSString *)strDate;
+(NSDate *)ConvertDateTosystemTimeZone:(NSString *)strDate;
+(void)DeleteTemporaryFileContent;
+(NSString *)CheckForFileAtPath:(NSString *)strFileName withDirName:(NSString *)strDir;
+(NSString *)getStringFromDate:(NSDate *)date;

@end
