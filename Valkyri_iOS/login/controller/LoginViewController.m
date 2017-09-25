//
//  LoginViewController.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "LoginViewController.h"
#import "UserInformation.h"
#import "AuthDataLayer.h"
#import "MenuViewController.h"
#import "ConfigDatalayer.h"
#import "Tools.h"

@interface LoginViewController () <UITextFieldDelegate>

@end

@implementation LoginViewController

@synthesize settings = settings_;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settings = [NSUserDefaults standardUserDefaults];
    
    [self.userEmailTextField setTag:0];
    [self.userPasswordTextField setTag:1];
    [self.userEmailTextField setDelegate:self];
    [self.userPasswordTextField setDelegate:self];

    
    NSString* userEmail = [self.settings valueForKey:@"userEmail"];
    NSString* userPassword = [self.settings valueForKey:@"userPassword"];
    
    if(userEmail != nil && userPassword != nil) {
        [self authUserWithEmail:userEmail andPassword:userPassword andIsAutoLogin:YES];
    }
    
    NSString *serverName = [self.settings valueForKey:@"serverName"];
    
    if(serverName != nil) {
        [ConfigDatalayer setServerNameWithString:serverName];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    self.userEmailTextField.text = @"";
    self.userPasswordTextField.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (bool)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (bool)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)loginBtn_click:(UIButton *)sender {
    [self validateLoginForm];
}

- (void) validateLoginForm {
    [self authUserWithEmail:self.userEmailTextField.text andPassword:self.userPasswordTextField.text andIsAutoLogin:NO];
}

- (void)authUserWithEmail:(NSString*) email andPassword:(NSString*) password andIsAutoLogin:(bool) isAutoLogin {
    [AuthDataLayer postCredentialsAndGetTokenWithEmail:email andPassword:password andResultHandler:^{
        MenuViewController *menu = [[MenuViewController alloc] init];
        UINavigationController* navigationController = [[UINavigationController alloc]initWithRootViewController:menu];
        navigationController.navigationBar.barTintColor = [Tools UIColorFromRGB:0x5D5965];
        navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        // Save user credentials
        if(self.rememberMeSwitch.isOn && isAutoLogin != YES){
            [self.settings setValue:self.userEmailTextField.text forKey:@"userEmail"];
            [self.settings setValue:self.userPasswordTextField.text forKey:@"userPassword"];
        }
        
        [self presentViewController:navigationController animated:YES completion:nil];
    }andUnauthorizedHandler:^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information" message:@"Your email or password is invalid, please try again" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            // DO NOTHING
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }andErrorHandler:^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information" message:@"An error as occured, please try again" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            // DO NOTHING
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}

@end
