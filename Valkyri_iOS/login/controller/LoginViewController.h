//
//  LoginViewController.h
//  Valkyri_iOS
//
//  Created by Jeyaksan RAJARATNAM on 27/05/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController {
    @private
    NSUserDefaults* settings_;
}
@property (weak, nonatomic) IBOutlet UITextField *userEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;
@property (weak, nonatomic) IBOutlet UISwitch *rememberMeSwitch;

@property (strong, nonatomic) NSUserDefaults* settings;

- (IBAction)loginBtn_click:(UIButton *)sender;

@end
