//
//  ConfigDatalayer.h
//  Valkyri_iOS
//
//  Created by Jeyaksan RAJARATNAM on 22/07/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigDatalayer : NSObject

//ROUTES SERVEUR NODE
+ (NSString*) getServerName;
+ (void) setServerNameWithString:(NSString*) newServerName;
+ (NSString*) getApiUrlUser;
+ (NSString*) getApiUrlLevel;
+ (NSString*) getApiUrlHistory;
+ (NSString*) getApiUrlPlace;
+ (NSString*) getApiUrlAccess;
+ (NSString*) getApiUrlAuth;

@end
