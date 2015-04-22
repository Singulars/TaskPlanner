//
//  NSData+Extra.m
//  PictureSharing
//
//  Created by Rajan on 13/03/14.
//  Copyright (c) 2014 iverve. All rights reserved.
//

#import "NSData+Extra.h"

@implementation NSData (Extra)

- (NSString*)base64forData
{
    const uint8_t* input = (const uint8_t*)[self bytes];
    NSInteger Datalength = [self length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((Datalength + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < Datalength; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < Datalength) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < Datalength ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < Datalength ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

@end
