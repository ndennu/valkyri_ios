//
//  LevelDataLayer.h
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConfigDatalayer.h"
@class LevelViewController;
@class Level;
@class LevelDetails;
@class DetailRoomViewController;
@class DetailAccessViewController;
@class DetailIssueViewController;

@interface LevelDataLayer : NSObject

//récupére tout les niveaux
+ (NSMutableArray<Level*>*) getAllLevelsWithLevelView:(LevelViewController*) view;
//recupére les niveau pour le composant uipicker view
+ (NSMutableArray<Level*> *) getAllLevelsWithDetailAccessView:(DetailAccessViewController *) view;
//recupére un niveau
+ (void) getLevelById:(LevelDetails*) view identifiant:(NSInteger) identifiant;
//recupére un niveau
+ (void) getLevelForRoomWithId:(NSInteger) identifiant andIssueDetailView:(DetailIssueViewController*) view;
// recupére un niveau
+ (void) getLevelForAccountWithId:(NSInteger) identifiant andIssueDetailView:(DetailIssueViewController*) view;
// ajout d'un niveau
+ (void) postLevelWithNumber:(NSString*)number andWithName:(NSString*)name andResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler;
// modifie un niveau
+ (void) putLevelWithNumber:(NSString*)number WithName:(NSString*)name andWithId:(NSString*)identifiant andResultHandler:(void (^)(void)) handler andErrorHandler:(void (^)(void)) errorHandler;
// recupére le détail d'une salle
+ (void) getLevelForDetailRoomWithId:(NSNumber*) identifiant andWithDetailView: (DetailRoomViewController*) detailRoomView;
// recupere le niveau pour le composant ui picker
+ (void) getLevelForDetailAccessWithId:(NSInteger) identifiant andWithDetailView: (DetailAccessViewController*) detailAccessView;
// supprime via l'id
+ (void) deleteLevelWithId:(NSInteger)identifiant andResultHandler:(void (^)(void)) handler andErrorHandler:(void (^)(void)) errorHandler;

@end
