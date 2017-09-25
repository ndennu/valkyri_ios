//
//  AccessDatalayer.h
//  Valkyri_iOS
//
//  Created by Nico on 11/07/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Access.h"
#import "AccessViewController.h"
#import "Tools.h"
#import "ConfigDatalayer.h"
#import "DetailAccessViewController.h"

@interface AccessDatalayer : NSObject
// get tous les access
+ (NSMutableArray<Access*>*) getAllAccess:(AccessViewController*) accessView;
// get avec l'id
+ (void) getAccessWithId:(NSInteger) accessId andAccessView:(DetailAccessViewController*) accessView;
// post avec l'id
+ (void) postAccessWithH1:(NSString*) h1 andWithH2:(NSString*) h2 andWithRoom:(NSString*)roomId andWithLevel:(NSString*) levelNumber andResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler;
// update avec l'id
+ (void) putAccessWithH1:(NSString*)h1 WithH2:(NSString*)h2 andWithRoom:(NSString*)roomId andWithLevel:(NSString*) levelNumber andWithId:(NSString*)identifiant andResultHandler:(void (^)(void)) handler andErrorHandler:(void (^)(void)) errorHandler;
//delete avec l'id
+ (void) deleteAccessWithId:(NSInteger)identifiant andResultHandler:(void (^)(void)) handler andErrorHandler:(void (^)(void)) errorHandler;

@end
