//
//  Tools.h
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Cette classe contient des fonction annexe utiles
@interface Tools : NSObject

/// Convertion du format HEX (0xFFFFFF) en UIColor
+ (UIColor*) UIColorFromRGB:(unsigned) hexValue;

+ (NSString*) getTimeStringFromNSDate:(NSDate*) date;

+ (NSDate*) getDateFromJsonTimeString:(NSString*) dateString;

+ (NSString*) getDateStringFromNSDate:(NSDate*) date;

+ (NSString*) getAuthorizationStatusStringForBoolean:(bool) boolean;

+ (NSString*) getJsonDateStringFromNSDate:(NSDate*) date;

+ (NSDate*) getDateFromJsonDateString:(NSString*) string;

@end
