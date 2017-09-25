//
//  Account.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "Account.h"

@implementation Account

@synthesize id = id_;
@synthesize matricule = matricule_;
@synthesize lastname = lastname_;
@synthesize firstname = firstname_;
@synthesize email = email_;
@synthesize password = password_;
@synthesize digicode = digicode_;
@synthesize phone = phone_;
@synthesize level_id = level_id_;
@synthesize createdAt = createdAt_;
@synthesize updatedAt = updatedAt_;

- (instancetype)initWithNSDictionnary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        if(![dict isEqual:[NSNull null]]) {
            self.matricule = [dict objectForKey:@"matricule"];
            self.lastname = [dict objectForKey:@"lastname"];
            self.firstname = [dict objectForKey:@"firstname"];
            self.email = [dict objectForKey:@"email"];
            self.password = [dict objectForKey:@"password"];
            self.digicode = [dict objectForKey:@"digicode"];
            self.phone = [dict objectForKey:@"phone"];
            self.level_id = [[dict objectForKey:@"level_number"] intValue];
            self.createdAt = (NSDate*)[dict objectForKey:@"createdAt"];
            self.updatedAt = (NSDate*) [dict objectForKey:@"updatedAt"];
        }
    }
    return self;
}

@end
