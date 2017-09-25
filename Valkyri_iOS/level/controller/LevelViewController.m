//
//  LevelViewController.m
//  Valkyri_iOS
//
//  Created by apple on 03/06/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "LevelViewController.h"
#import "LevelDatalayer.h"

@interface LevelViewController ()

@end

@implementation LevelViewController

static NSString* const CellId = @"Cell";

@synthesize dataArray = dataArray_;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle: (NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil){
        [self.level registerNib:[UINib nibWithNibName:@"LevelViewCell.h" bundle:nil] forCellReuseIdentifier:CellId];
        return self;
    }
    return nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.level.delegate = self;
    self.level.dataSource = self;
    
    self.dataArray = [[NSMutableArray alloc] init];
}

- (void) viewWillAppear:(BOOL)animated {
    [self loadLevelInTableView];
}

- (void) viewDidAppear:(BOOL)animated{
    // ADD ADD BUTTON
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewLevel)];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = addButton;
}

- (void) viewWillDisappear:(BOOL)animated {
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadTableView {
    [self.level reloadData];
}

- (void) addNewLevel{
    [self.navigationController pushViewController:[[LevelDetails alloc] initForCreation] animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LevelViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!cell){
        [tableView registerNib:[UINib nibWithNibName:@"LevelViewCell" bundle:nil] forCellReuseIdentifier:CellId];
        cell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    }
    
    Level *currentLevel = [self.dataArray objectAtIndex:indexPath.row];
    cell.cell.text = [NSString stringWithFormat:@"%d", currentLevel.number];
    cell.nameLevel.text = currentLevel.name;
    
    return cell;
}

- (void)loadLevelInTableView {
    [self.dataArray removeAllObjects];
    self.dataArray = [LevelDataLayer getAllLevelsWithLevelView:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Level* selectedLevel = [self.dataArray objectAtIndex:indexPath.row];
    LevelDetails *levelDetail = [[LevelDetails alloc] initWithIdRequest: selectedLevel.id];
    [self.navigationController pushViewController:levelDetail animated:YES];
}


@end
