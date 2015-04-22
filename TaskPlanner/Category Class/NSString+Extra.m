//
//  NSString+Extra.m
//  WhoSaid
//
//  Created by nayan mistry on 15/03/14.
//  Copyright (c) 2014 iVerve. All rights reserved.
//

#import "NSString+Extra.h"

@implementation NSString (Extra)


-(NSString *)getFilterdString
{
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
     return [self stringByTrimmingCharactersInSet:whitespaces];
}

-(CGSize)getStringwithDefaultHeight:(float)defaultHeight DefaultWidth:(float)defaultWidth forFont:(NSString *)strFontName ForFontSize:(float)fontSize
{
    CGRect textRect = [self boundingRectWithSize:CGSizeMake((IS_IPAD)?600:240, MAXFLOAT)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:[UIFont fontWithName:kDefaultFontName size:fontSize]}
                                           context:nil];
    
    CGSize size = textRect.size;

    CGFloat height = MAX(size.height, defaultHeight);
    
    CGFloat width=MAX(size.width, defaultWidth);
    
    CGSize stringSize=CGSizeMake(width, height);
    
    return stringSize ;
}


-(NSString *)getDateINLongFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:self];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    return [formatter stringFromDate:date];
}
-(BOOL)IsTimeFormat12or24
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

-(NSString *)getTimeInAMorPM
{
    NSString *strTime;
    
    BOOL isSystem24Hr = [self IsTimeFormat12or24];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    dateFormatter.dateFormat = @"HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:(isSystem24Hr)?self:[self substringWithRange:NSMakeRange(0, 8)]];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setTimeZone:[NSTimeZone systemTimeZone]];
    dateFormatter1.dateFormat = (isSystem24Hr)?@"HH:mm":@"hh:mm a";
    strTime = [dateFormatter1 stringFromDate:date];
    
    return strTime;
}
-(NSString *)getOnlyTimeStampFromDateStringForWeb
{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [df setDateFormat:kDefaultDateFormat];
    NSDate *date=[df dateFromString:self];
    BOOL isSystem24Hr = [self IsTimeFormat12or24];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setTimeZone:[NSTimeZone systemTimeZone]];
    formatter1.dateFormat = (isSystem24Hr)?@"HH:mm":@"hh:mm a";
    
    return [formatter1 stringFromDate:date];
}

-(NSString *)getFullDateFromDateStringForWeb
{
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [df setDateFormat:kDefaultDateFormat];
    NSDate *date=[df dateFromString:self];
    BOOL isSystem24Hr = [self IsTimeFormat12or24];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setTimeZone:[NSTimeZone systemTimeZone]];
    formatter1.dateFormat = (isSystem24Hr)?@"dd/MM/yyyy HH:mm":@"dd/MM/yyyy hh:mm a";
    
    return [formatter1 stringFromDate:date];
}

-(NSString *)getFilteredStringForExtraCharacter
{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"/:.()-*#+"];
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    NSString *FilteredString = [[self componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString:@""];
    NSArray *parts = [FilteredString componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    FilteredString = [filteredArray componentsJoinedByString:@""];
    return FilteredString;
}

-(NSString *)getLongStringDateFromString
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterLongStyle];
    NSDate *date = [df dateFromString:self];
    
    NSString *retStr = [df stringFromDate:date];
    
    return retStr;
}

- (NSString *)propertyStyleString
{
    
    NSString * result = [[self substringToIndex: 1] lowercaseString];
    
    if ( [self length] == 1 )
        return ( result );
    
    return ( [result stringByAppendingString: [self substringFromIndex: 1]] );
}


@end
