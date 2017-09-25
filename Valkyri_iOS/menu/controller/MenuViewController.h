//
//  MenuViewController.h
//  Valkyri_iOS
//
//  Created by Nico on 29/05/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginViewController.h"
#import "RoomViewController.h"
#import "LevelViewController.h"
#import "IssueViewController.h"
#import "AccessViewController.h"
#import "SettingsViewController.h"

@interface MenuViewController : UITabBarController

@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@end
