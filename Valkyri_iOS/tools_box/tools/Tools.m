//
//  Tools.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "Tools.h"

/// Cette classe contient des fonction annexe utiles
@implementation Tools

/// Convertion du format HEX (0xFFFFFF) en UIColor
+ (UIColor*) UIColorFromRGB:(unsigned) hexValue{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
                           green:((float)((hexValue & 0x00FF00) >>  8))/255.0 \
                            blue:((float)((hexValue & 0x0000FF) >>  0))/255.0 \
                           alpha:1.0];
}



+ (NSString*) getTimeStringFromNSDate:(NSDate*) date {
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    [timeFormatter setDateFormat:@"HH:mm:ss"];
    NSString *timeString = [timeFormatter stringFromDate:date];
    return [NSString stringWithFormat:@"%@", timeString];
}

+ (NSDate*) getDateFromJsonTimeString:(NSString*) dateString {
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    [timeFormatter setDateFormat:@"HH:mm:ss"];
    return [timeFormatter dateFromString:dateString];
}

+ (NSString*) getDateStringFromNSDate:(NSDate*) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    return [dateFormatter stringFromDate:date];
}

+ (NSString*) getAuthorizationStatusStringForBoolean:(bool) boolean {
    if(boolean) {
        return @"Authorized";
    }
    return @"Refused";
}

+ (NSString*) getJsonDateStringFromNSDate:(NSDate*) date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZZZZZ"];
    
    return [dateFormat stringFromDate:date];
}

+ (NSDate*) getDateFromJsonDateString:(NSString*) string {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZZZZZ"];
    
    return [dateFormat dateFromString:string];
}



@end
