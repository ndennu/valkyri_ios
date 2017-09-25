//
//  DigicodeUpdatingViewController.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "DigicodeUpdatingViewController.h"
#import "AccountDatalayer.h"
#import "UserInformation.h"

@interface DigicodeUpdatingViewController ()

@end

@implementation DigicodeUpdatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Digicode";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeButtonClick:(UIButton *)sender {
    if([self.digicodeTextfield.text isEqualToString:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information" message:@"Digicode is empty, please try again." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            // DO NOTHING
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if([self.digicodeTextfield.text isEqualToString:self.confirmDigicodeTextField.text]) {
        [AccountDatalayer putUserDigicodeWithUserId:[NSNumber numberWithInt:[UserInformation getConnectedUserId]] andDigicode:self.digicodeTextfield.text andResultHandler:^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information" message:@"Your digicode has been changed successfully" preferredStyle:UIAlertControllerStyleAlert];
            
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
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information" message:@"Digicode are not matching, please try again." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            // DO NOTHING
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
