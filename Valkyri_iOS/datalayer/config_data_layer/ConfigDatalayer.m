//
//  ConfigDatalayer.m
//  Valkyri_iOS
//
//  Created by Jeyaksan RAJARATNAM on 22/07/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "ConfigDatalayer.h"

@implementation ConfigDatalayer

static NSString *serverName = @"192.168.137.60:3000";
static NSString *baseApiUrlUser = @"/users";
static NSString *baseApiUrlLevel = @"/levels";
static NSString *baseApiUrlHistory = @"/histories";
static NSString *baseApiUrlPlaces = @"/places";
static NSString *baseApiUrlAccess = @"/access";
static NSString *baseApiUrlAuth = @"/auth";

+ (NSString*) getServerName {
    return serverName;
}

+ (void) setServerNameWithString:(NSString*) newServerName {
    serverName = newServerName;
}

+ (NSString*) getApiUrlUser {
    return [NSString stringWithFormat:@"http://%@%@", serverName, baseApiUrlUser];
}

+ (NSString*) getApiUrlLevel {
    return [NSString stringWithFormat:@"http://%@%@", serverName, baseApiUrlLevel];
}

+ (NSString*) getApiUrlHistory {
    return [NSString stringWithFormat:@"http://%@%@", serverName, baseApiUrlHistory];
}

+ (NSString*) getApiUrlPlace {
    return [NSString stringWithFormat:@"http://%@%@", serverName, baseApiUrlPlaces];
}
+ (NSString*) getApiUrlAccess {
    return [NSString stringWithFormat:@"http://%@%@", serverName, baseApiUrlAccess];
}
+ (NSString*) getApiUrlAuth {
    return [NSString stringWithFormat:@"http://%@%@", serverName, baseApiUrlAuth];
}

@end
