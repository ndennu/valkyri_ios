//
//  UserInformation.h
//  Valkyri_iOS
//
//  Created by Jeyaksan RAJARATNAM on 21/07/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInformation : NSObject
//return user id
+ (int) getConnectedUserId;
//stock l'id sur le téléphone (en mémoire)
+ (void) setConnectedUserIdWithId:(int) userId;
//return lvl id
+ (int) getConnectedUserLvl;
//stock le lvl sur le téléphone
+ (void) setConnectedUserLvlWithLvl:(int) userLvl;
//connection auto
+ (NSString*) getAuthToken;
//connection auto
+ (void) setAuthTokenWithNSString:(NSString*) token;
@end
