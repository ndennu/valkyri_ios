//
//  PasswordUpdatingViewController.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "PasswordUpdatingViewController.h"
#import "Account.h"
#import "AccountDatalayer.h"
#import "UserInformation.h"

@interface PasswordUpdatingViewController ()

@end

@implementation PasswordUpdatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Password";
    self.passwordTextField.text = @"";
    self.confirmPasswordTextField.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changePasswordButtonClick:(UIButton *)sender {
    if([self.passwordTextField.text isEqualToString:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information" message:@"Password is empty, please try again." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            // DO NOTHING
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if([self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        [AccountDatalayer putUserPasswordWithUserId:[NSNumber numberWithInt:[UserInformation getConnectedUserId]] andPassword:self.passwordTextField.text andResultHandler:^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information" message:@"Your password has been changed successfully" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [[self navigationController] popViewControllerAnimated:YES];
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        } andErrorHandler:^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information" message:@"An error as occured, please try again" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                // DO NOTHING
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information" message:@"Passwords are not matching, please try again." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            // DO NOTHING
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
