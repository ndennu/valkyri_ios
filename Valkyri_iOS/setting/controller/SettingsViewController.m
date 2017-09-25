//
//  SettingsViewController.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "SettingsViewController.h"
#import "AccountDatalayer.h"
#import "Access.h"
#import "UserInformation.h"
#import "PasswordUpdatingViewController.h"
#import "DigicodeUpdatingViewController.h"
#import "UserImageSelectionViewController.h"
#import "AuthDataLayer.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize settings = settings_;
@synthesize account = account_;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil){
        return self;
    }
    return nil;
}

- (IBAction)serverNameSaveButton:(UIButton *)sender {
    [self.settings setValue:self.serverNameTextField.text forKey:@"serverName"];
    [ConfigDatalayer setServerNameWithString:self.serverNameTextField.text];
}
- (IBAction)changePasswordButtonClick:(UIButton *)sender {
    [self.navigationController pushViewController:[[PasswordUpdatingViewController alloc] init] animated:YES];
}
- (IBAction)changeDigicodeButtonClick:(UIButton *)sender {
    [self.navigationController pushViewController:[[DigicodeUpdatingViewController alloc] init] animated:YES];
}
- (IBAction)chengePhotoButtonClick:(id)sender {
    [self.navigationController pushViewController:[[UserImageSelectionViewController alloc] init] animated:YES];
}

- (IBAction)logoutButtonClick:(UIButton *)sender {
    [self logout];
}


- (void) logout {
    [AuthDataLayer postTokenAndLogoutWithResultHandler:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }andErrorHandler:^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information" message:@"An error as occured, Please try again" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            // DO NOTHING
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settings = [NSUserDefaults standardUserDefaults];
    
    self.serverNameTextField.text = [ConfigDatalayer getServerName];
    
    [self loadAccount];
}

- (void)viewWillAppear:(BOOL)animated {
    NSString* userEmail = [self.settings valueForKey:@"userEmail"];
    NSString* userPassword = [self.settings valueForKey:@"userPassword"];
    
    if(userEmail == nil || userPassword == nil) {
        [self.autoLoginSwitch setEnabled:NO];
    } else {
        [self.autoLoginSwitch setEnabled:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)autoLoginSwitchChanged:(UISwitch*)sender {
    if(!self.autoLoginSwitch.isOn) {
        [self.settings setValue:nil forKey:@"userEmail"];
        [self.settings setValue:nil forKey:@"userPassword"];
        [self.autoLoginSwitch setEnabled:NO];
    }
}

- (void)loadAccount {
    [AccountDatalayer getUserById:self identifiant:[UserInformation getConnectedUserId]];
    [AccountDatalayer getProfileImageWithUserId:[UserInformation getConnectedUserId] andImageView:self.userProfileImage];
}

@end
