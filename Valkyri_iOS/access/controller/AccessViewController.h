//
//  AccessViewController.h
//  Valkyri_iOS
//
//  Created by apple on 27/05/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Access.h"
#import "AccessCellTableViewCell.h"

@interface AccessViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate> {
    @private
    NSMutableArray<Access*> *dataArray_;
}

@property (weak, nonatomic) IBOutlet UITableView *access;
@property (nonatomic, strong) NSMutableArray<Access*> *dataArray;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
// charge dans la tableView les données
- (void) loadAccessInTableView;
//rafraichie 
- (void) reloadTableView;

@end
