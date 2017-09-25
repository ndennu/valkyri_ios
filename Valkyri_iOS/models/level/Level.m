#import "Level.h"

@implementation Level

@synthesize id = id_;
@synthesize name = name_;
@synthesize number = number_;

/// Constructeur prenant en paramètre, un dictionnaire
- (instancetype) initWithNSDictionnary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        if(![dict isEqual:[NSNull null]]){
            self.id = [[dict objectForKey:@"id"] intValue];
            self.name = [dict objectForKey:@"name"];
            self.number = [[dict objectForKey:@"number"] intValue];
        }
    }
    return self;
}

@end
