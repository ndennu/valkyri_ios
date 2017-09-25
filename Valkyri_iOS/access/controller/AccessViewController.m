//
//  AccessViewController.m
//  Valkyri_iOS
//
//  Created by apple on 27/05/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "AccessCellTableViewCell.h"
#import "AccessViewController.h"
#import "AccessDatalayer.h"
#import "DetailAccessViewController.h"
#import "Tools.h"


@interface AccessViewController () <UITableViewDelegate, UITableViewDataSource>

@end


@implementation AccessViewController

static NSString* const CellId = @"Cell";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle: (NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil){
        [self.access registerNib:[UINib nibWithNibName:@"AccessCellTableViewCell.h" bundle:nil] forCellReuseIdentifier:CellId];
        return self;
    }
    return nil;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.access.delegate = self;
    self.access.dataSource = self;
    self.dataArray = [[NSMutableArray alloc] init];
    // table view data is being set here

    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated {
    [self loadAccessInTableView];
}

- (void) viewDidAppear:(BOOL)animated{
    // ADD ADD BUTTON
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewAccess)];
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
    [self.access reloadData];
}

- (void) addNewAccess{
    [self.navigationController pushViewController:[[DetailAccessViewController alloc] initForCreation] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AccessCellTableViewCell* accesCell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!accesCell){
        [tableView registerNib:[UINib nibWithNibName:@"AccessCellTableViewCell" bundle:nil] forCellReuseIdentifier:CellId];
        accesCell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    }
    
    Access *currentAccess = [self.dataArray objectAtIndex:indexPath.row];
    accesCell.cell.text = [NSString stringWithFormat:@"Room n° %d", currentAccess.place_id];
    accesCell.h1Label.text = [Tools getTimeStringFromNSDate:currentAccess.h1];
    accesCell.h2Label.text = [Tools getTimeStringFromNSDate:currentAccess.h2];
    
    return accesCell;
}

- (void)loadAccessInTableView {
    [self.dataArray removeAllObjects];
    self.dataArray = [AccessDatalayer getAllAccess:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Access* selectedAccess = [self.dataArray objectAtIndex:indexPath.row];
    DetailAccessViewController* detailAccess = [[DetailAccessViewController alloc] initWithIdRequest:selectedAccess.id];
                                                
    [self.navigationController pushViewController:detailAccess animated:YES];
}

@end
