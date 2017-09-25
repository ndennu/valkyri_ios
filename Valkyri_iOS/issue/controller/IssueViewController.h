//
//  IssueViewController.h
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "History.h"
#import "IssueTableViewCell.h"
#import "DetailIssueViewController.h"

@interface IssueViewController : UIViewController{
    @private
    NSMutableArray<History*> *dataArray_;
}

@property (weak, nonatomic) IBOutlet UITableView *issueTableView;
@property (nonatomic, strong) NSMutableArray<History*> *dataArray;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

- (void) loadIssueInTableView;

- (void) reloadTableView;

@end
