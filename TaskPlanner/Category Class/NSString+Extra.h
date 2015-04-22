//
//  NSString+Extra.h
//  WhoSaid
//
//  Created by nayan mistry on 15/03/14.
//  Copyright (c) 2014 iVerve. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extra)

-(NSString *)getFilterdString;
-(CGSize)getStringwithDefaultHeight:(float)defaultHeight DefaultWidth:(float)defaultWidth forFont:(NSString *)strFontName ForFontSize:(float)fontSize;
-(NSString *)getDateINLongFormat;
-(BOOL)IsTimeFormat12or24;
-(NSString *)getTimeInAMorPM;
-(NSString *)getOnlyTimeStampFromDateStringForWeb;
-(NSString *)getFullDateFromDateStringForWeb;
-(NSString *)getFilteredStringForExtraCharacter;
-(NSString *)getLongStringDateFromString;

- (NSString *)propertyStyleString;
@end
