//
//  SettingsViewController.h
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Account;

@interface SettingsViewController : UIViewController {
    @private
    NSUserDefaults* settings_;
    Account* account_;
}
@property (weak, nonatomic) IBOutlet UILabel *nameUser;
@property (weak, nonatomic) IBOutlet UILabel *firstnameUser;
@property (weak, nonatomic) IBOutlet UILabel *levelUser;
@property (weak, nonatomic) IBOutlet UILabel *emailUser;
@property (weak, nonatomic) IBOutlet UILabel *matriculeUser;
@property (weak, nonatomic) IBOutlet UILabel *phoneUser;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@property (weak, nonatomic) IBOutlet UITextField *serverNameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;

@property (strong, nonatomic) NSUserDefaults* settings;
@property (nonatomic, strong) Account* account;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (IBAction)serverNameSaveButton:(UIButton *)sender;

- (void) loadAccount;



@end
