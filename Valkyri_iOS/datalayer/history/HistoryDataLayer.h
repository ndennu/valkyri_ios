//
//  HistoryDataLayer.h
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "History.h"
#import "IssueViewController.h"
#import "Tools.h"
#import "ConfigDatalayer.h"

@interface HistoryDataLayer : NSObject

//recupére l'historique
+ (NSMutableArray<History*>*) getAllHistory: (IssueViewController*) issueView;
// recupére une partie de l'historique
+ (void) getHistoryById: (NSInteger) identifiant andDetailView:(DetailIssueViewController*) detailIssueView;

@end
