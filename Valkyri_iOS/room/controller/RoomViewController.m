//
//  RoomViewController.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "RoomViewController.h"
#import "RoomDatalayer.h"
#import "DetailRoomViewController.h"
#import "UserInformation.h"

@interface RoomViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation RoomViewController

@synthesize dataArray = dataArray_;

static NSString* const CellId = @"Cell";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil){
        [self.roomTableView registerNib:[UINib nibWithNibName:@"RoomTableViewCell" bundle:nil] forCellReuseIdentifier:CellId];
        return self;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.roomTableView.delegate = self;
    self.roomTableView.dataSource = self;
    self.dataArray = [[NSMutableArray alloc] init];
    [self loadRoomInTableView];
}

- (void) viewWillAppear:(BOOL)animated {
    [self loadRoomInTableView];
}

- (void) viewDidAppear:(BOOL)animated{
    if([UserInformation getConnectedUserLvl] < 1) {
        // ADD ADD BUTTON
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewRoom)];
        self.navigationController.topViewController.navigationItem.rightBarButtonItem = addButton;
    }
}

- (void) viewWillDisappear:(BOOL)animated {
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = nil;
}

- (void) addNewRoom{
    [self.navigationController pushViewController:[[DetailRoomViewController alloc] initForCreation] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadTableView {
    [self.roomTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RoomTableViewCell *roomCell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!roomCell) {
        [tableView registerNib:[UINib nibWithNibName:@"RoomTableViewCell" bundle:nil] forCellReuseIdentifier:CellId];
        roomCell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    }
    
    Room *currentRoom = [self.dataArray objectAtIndex:indexPath.row];
    roomCell.roomLabel.text = [NSString stringWithFormat:@"%d", currentRoom.level_id];

    roomCell.levelLabel.text = [NSString stringWithFormat:@"Room n° %d", currentRoom.number];
    
    return roomCell;
}

- (void)loadRoomInTableView {
    [self.dataArray removeAllObjects];
    self.dataArray = [RoomDatalayer getAllRoom:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Room* selectedRoom = [self.dataArray objectAtIndex:indexPath.row];
    DetailRoomViewController *detailRoomView = [[DetailRoomViewController alloc] initWithIdRequest:selectedRoom.id];
    [self.navigationController pushViewController:detailRoomView animated:YES];
}

@end
