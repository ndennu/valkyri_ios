//
//  History.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "History.h"
#import "Tools.h"

@implementation History

@synthesize id = id_;
@synthesize authorize = authorize_;
@synthesize user_id = user_id_;
@synthesize place_id = place_id_;
@synthesize createdAt = createdAt_;

- (instancetype)initWithNSDictionnar:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if(![dict isEqual:[NSNull null]]) {
            self.authorize = [[dict objectForKey:@"authorize"] boolValue];
            self.user_id = [[dict objectForKey:@"user_id"] intValue];
            self.place_id = [[dict objectForKey:@"place_id"] intValue];
            
            self.createdAt = [Tools getDateFromJsonDateString:[dict objectForKey:@"createdAt"]];
            self.id = [[dict objectForKey:@"id"] intValue];
        }
    }
    return self;
}

@end
