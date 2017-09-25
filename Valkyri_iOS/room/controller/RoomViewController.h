//
//  RoomViewController.h
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"
#import "RoomTableViewCell.h"

@interface RoomViewController : UIViewController {
    @private
    NSMutableArray<Room*> *dataArray_;
}
@property (weak, nonatomic) IBOutlet UITableView *roomTableView;

@property(nonatomic, strong) NSMutableArray<Room*> *dataArray;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

- (void) loadRoomInTableView;

- (void) reloadTableView;

@end
