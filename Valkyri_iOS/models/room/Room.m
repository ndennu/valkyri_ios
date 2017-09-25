//
//  Room.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "Room.h"

@implementation Room

@synthesize id = id_;
@synthesize number = number_;
@synthesize level_id = level_id_;

- (instancetype)initWithNSDictionnary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if (![dict isEqual:[NSNull null]]) {
            self.id = [[dict objectForKey:@"id"] intValue];
            self.level_id = [[dict objectForKey:@"level_number"] intValue];
            self.number = [[dict objectForKey:@"number"] intValue];
        }
    }
    return self;
}

@end
