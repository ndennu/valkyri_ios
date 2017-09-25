//
//  Access.m
//  Valkyri_iOS
//
//  Created by Nico on 11/07/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "Access.h"
#import "Tools.h"

@implementation Access

@synthesize id = id_;
@synthesize h1 = h1_;
@synthesize h2 = h2_;
@synthesize level_number = level_number_;
@synthesize place_id = place_id_;

- (instancetype)initWithNSDictionnary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if (![dict isEqual:[NSNull null]]) {
            self.id = [[dict objectForKey:@"id"] intValue];
            self.h1 = [Tools getDateFromJsonTimeString:[dict objectForKey:@"h1"]];
            self.h2 = [Tools getDateFromJsonTimeString:[dict objectForKey:@"h2"]];
            self.level_number = [[dict objectForKey:@"level_number"] intValue];
            self.place_id = [[dict objectForKey:@"place_id"] intValue];
        }
    }
    return self;
}



@end
