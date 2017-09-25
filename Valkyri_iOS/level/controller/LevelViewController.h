//
//  LevelViewController.h
//  Valkyri_iOS
//
//  Created by apple on 03/06/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Level.h"
#import "LevelViewCell.h"
#import "LevelDetails.h"

@interface LevelViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate> {
    @private
    NSMutableArray<Level*> *dataArray_;
}
@property (weak, nonatomic) IBOutlet UITableView *level;

@property (nonatomic, strong) NSMutableArray<Level*> *dataArray;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

- (void) loadLevelInTableView;

- (void) reloadTableView;


@end
