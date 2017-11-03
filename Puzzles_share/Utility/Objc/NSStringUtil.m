//
//  NSStringUtil.m
//  SwiftPuzzles
//
//  Created by venus.janne on 2017/09/30.
//  Copyright © 2017 venus.janne. All rights reserved.
//

#import "NSStringUtil.h"

@implementation NSString(Util)
-(NSString*)reverse {
    if (!self || self.length < 1) {
        return self;
    }
    NSString* retStr = @"";
    for (NSInteger i = self.length - 1; i >= 0; i --) {
        retStr = [NSString stringWithFormat:@"%@%c", retStr, [self characterAtIndex:i]];
    }
    return retStr;
}

//base conversion
//-(NSString*) reverseString:(NSString*)original {
//    const char* chars = [original cStringUsingEncoding:NSASCIIStringEncoding];
//    long length = strlen(chars);
//    char* new = (char*)malloc(length+1);
//    for (int i = 0; i < length; i++)
//        new[i] = chars[length - i - 1];
//    new[length] = '\0';
//    NSString* reverseString = [NSString stringWithCString:new encoding:NSASCIIStringEncoding];
//    free(new);
//    return reverseString;
//}

-(NSInteger)convOtherbaseToDec:(int)base {
    const char* str = [self.uppercaseString cStringUsingEncoding:NSASCIIStringEncoding];
    NSInteger len = strlen(str);
    NSInteger power = len - 1;
    NSInteger number, i, j;
    
    number = 0;
    for (i = 0; i < len; ++i) {
        if (str[i] >= 'A' && str[i] <= 'Z')
            j = str[i] - 'A' + 10;
        else
            j = str[i] - '0';
        number += j * pow(base, power);
        power--;
    }
    return number;
}

-(NSString*)convDecToOtherbase:(int)base {
    NSString* retStr = @"";
    int temp = 0;
    NSInteger number = [self integerValue];

    do {
        temp = number % base;
        if (temp < 10)
            retStr = [NSString stringWithFormat:@"%c%@", '0' + temp, retStr];
        else
            retStr = [NSString stringWithFormat:@"%c%@", 'A' + temp - 10, retStr];
        number = number / base;
    } while (number != 0);
    
    return retStr;
}

@end
