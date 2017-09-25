//
//  IssueViewController.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "IssueViewController.h"
#import "HistoryDataLayer.h"
#import "Tools.h"

@interface IssueViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation IssueViewController

@synthesize dataArray = dataArray_;

static NSString* const CellId = @"Cell";



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle: (NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil){
        [self.issueTableView registerNib:[UINib nibWithNibName:@"IssueTableViewCell" bundle:nil] forCellReuseIdentifier:CellId];
            return self;
    }
    return nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.issueTableView.delegate = self;
    self.issueTableView.dataSource = self;
    self.dataArray = [[NSMutableArray alloc] init];
    [self loadIssueInTableView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reloadTableView {
    [self.issueTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IssueTableViewCell* issueCell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(!issueCell){
        [tableView registerNib:[UINib nibWithNibName:@"IssueTableViewCell" bundle:nil] forCellReuseIdentifier:CellId];
        issueCell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    }
    
    History *currentHistory = [self.dataArray objectAtIndex:indexPath.row];
    
    issueCell.issueDate.text = [NSString stringWithFormat:@"%@", [Tools getDateStringFromNSDate:currentHistory.createdAt]];
    issueCell.issueTime.text = [NSString stringWithFormat:@"%@", [Tools getTimeStringFromNSDate:currentHistory.createdAt]];
    
    if (currentHistory.authorize == true) {
        issueCell.roundSticker.backgroundColor = [UIColor greenColor];
    }
    else {
        issueCell.roundSticker.backgroundColor = [UIColor redColor];
    }
    
    return issueCell;
}

- (void)loadIssueInTableView {
    [self.dataArray removeAllObjects];
    self.dataArray = [HistoryDataLayer getAllHistory:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger temp = indexPath.row;
    DetailIssueViewController* detailIssue = [[DetailIssueViewController alloc] initWithIdRequest:(int) temp + 1];
     [self.navigationController pushViewController:detailIssue animated:YES];
}

@end
