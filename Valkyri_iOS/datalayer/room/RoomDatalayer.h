//
//  RoomDatalayer.h
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RoomViewController;
@class Room;
@class DetailIssueViewController;
@class DetailRoomViewController;
@class DetailAccessViewController;

@interface RoomDatalayer : NSObject
//recupére toutes les salles
+ (NSMutableArray<Room*>*) getAllRoom:(RoomViewController*) roomView;
//recupére la salle
+ (void) getRoomWithId:(NSNumber*) identifiant andRoomView:(DetailRoomViewController*) roomView;
//recupére pour la vue détail issue
+ (void)getRoomWithIdForDetailIssue:(NSNumber*)identifiant andIssueView:(DetailIssueViewController*) detailIssueView;
//recupére toute les room pour le composant ui picker
+ (NSMutableArray<Room*> *)getAllRoomWithAccessDetailView:(DetailAccessViewController *) view;
// recupére une salle
+ (void)getRoomWithIdForDetailAccess:(NSNumber*)identifiant andAccessView:(DetailAccessViewController*) detailAccessView;
// ajout d'une salle
+ (void) postRoomWithNumber:(NSNumber*)number andWithLevelNumber:(NSNumber*)levelNumber andResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler;
//modification d'une salle
+ (void) putRoomWithNumber:(NSNumber*)number WithlevelNumber:(NSNumber*)levelNumber andWithId:(NSNumber*)identifiant andResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler;
// suppression d'une salle
+ (void) deleteRoomWithId:(NSNumber*)identifiant andResultHandler:(void (^)(void)) handler andErrorHandler:(void (^)(void)) errorHandler;



@end
