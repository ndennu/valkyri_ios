//
//  MenuViewController.m
//  Valkyri_iOS
//
//  Created by Nico on 29/05/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "MenuViewController.h"
#import "UserInformation.h"
#import "AuthDataLayer.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Valkyri";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    RoomViewController *roomView = [[RoomViewController alloc] init];
    LevelViewController *levelView = [[LevelViewController alloc] init];
    IssueViewController *issueView = [[IssueViewController alloc] init];
    AccessViewController *accessView = [[AccessViewController alloc] init];
    SettingsViewController *settingsView = [[SettingsViewController alloc] init];
    
    NSMutableArray *menuViews = [[NSMutableArray alloc] init];
    
    [menuViews addObject:roomView];
    if([UserInformation getConnectedUserLvl] < 1){
        [menuViews addObject:levelView];
        [menuViews addObject:issueView];
        [menuViews addObject:accessView];
    }
    [menuViews addObject:settingsView];
    
    // self.viewControllers = [NSArray arrayWithObjects:roomView, levelView, issueView, accessView, settingsView, nil];
    self.viewControllers = menuViews;
    
    int i = 0;
    
    UITabBarItem *item = [self.tabBar.items objectAtIndex:i];
    item.title = @"Room";
    item.image = [UIImage imageNamed:@"room1"];
    item.selectedImage = [UIImage imageNamed:@"room1_selected"];
    i++;
    
    if([UserInformation getConnectedUserLvl] < 1) {
        item = [self.tabBar.items objectAtIndex:i];
        item.title = @"Level";
        item.image = [UIImage imageNamed:@"level"];
        item.selectedImage = [UIImage imageNamed:@"level_selected"];
        i++;
        
        item = [self.tabBar.items objectAtIndex:i];
        item.title = @"Issue";
        item.image = [UIImage imageNamed:@"issue1"];
        item.selectedImage = [UIImage imageNamed:@"issue1_selected"];
        i++;
        
        item = [self.tabBar.items objectAtIndex:i];
        item.title = @"Access";
        item.image = [UIImage imageNamed:@"key"];
        item.selectedImage = [UIImage imageNamed:@"key_selected"];
        i++;
    }
     
    item = [self.tabBar.items objectAtIndex:i];
    item.title = @"Account";
    item.image = [UIImage imageNamed:@"profil"];
    item.selectedImage = [UIImage imageNamed:@"profil_selected"];
    i++;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
