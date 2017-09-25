//
//  AccountDatalayer.h
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "SettingsViewController.h"
#import "ConfigDatalayer.h"
#import "DetailIssueViewController.h"

@interface AccountDatalayer : NSObject
//récupére tous les utilisateurs
+ (NSMutableArray<Account*>*) getAllUsers:(SettingsViewController *) accountView;
//récupére l'utilisateur par son identifiant
+ (void) getUserById:(SettingsViewController *) accountView identifiant:(NSInteger) identifiant;
//recupére l'id pour le détail des issues
+ (void) getUserByIdForDetailIssue:(DetailIssueViewController*) detailIssueView andId: (NSInteger) identifiant;
// recupére l'image profile de l'utilisateur
+ (void) getProfileImageWithUserId:(long) idUser andImageView:(UIImageView*) imageView;
// met à jour le mot de passe
+ (void) putUserPasswordWithUserId:(NSNumber*) identifiant andPassword:(NSString*) password andResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler;
//met à jour le digicode
+ (void) putUserDigicodeWithUserId:(NSNumber*) identifiant andDigicode:(NSString*) digicode andResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler;


@end
