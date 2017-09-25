//
//  DetailIssueViewController.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "DetailIssueViewController.h"
#import "HistoryDataLayer.h"

@interface DetailIssueViewController ()

@end

@implementation DetailIssueViewController


- (instancetype)initWithIdRequest:(int)idRequest {
    self = [super init];
    if(self) {
        self.idRequest = idRequest;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"History detail";
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    [HistoryDataLayer getHistoryById:self.idRequest andDetailView:self];
}


@end
