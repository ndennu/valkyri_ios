#import "UserInformation.h"

@implementation UserInformation

static int connectedUserId = 0;
static int connectedUserLvl;
static NSString* authToken = @"";

+ (int) getConnectedUserId {
    return connectedUserId;
}
+ (void) setConnectedUserIdWithId:(int) userId {
    connectedUserId = userId;
}

+ (int) getConnectedUserLvl {
    return connectedUserLvl;
}
+ (void) setConnectedUserLvlWithLvl:(int) userLvl {
    connectedUserLvl = userLvl;
}

+ (NSString*) getAuthToken{
    return authToken;
}

+ (void) setAuthTokenWithNSString:(NSString*) token {
    authToken = token;
}

@end
