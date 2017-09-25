//
//  LevelDetails.m
//  Valkyri_iOS
//
//  Created by apple on 16/06/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "LevelDetails.h"
#import "LevelDatalayer.h"
#import "Level.h"

@interface LevelDetails () <UITextFieldDelegate>

@end

@implementation LevelDetails
@synthesize idRequest = idRequest_;
@synthesize level = level_;
@synthesize isCreationMode = isCreationMode_;


- (instancetype)initWithIdRequest:(int)idRequest {
    self = [super init];
    if(self) {
        self.idRequest = idRequest;
        self.isCreationMode = NO;
    }
    return self;
}

- (instancetype)initForCreation {
    self = [super init];
    if(self) {
        self.isCreationMode = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Level";
    if(!self.isCreationMode){
        [self loadData];
    } else {
        [self.deleteButton setHidden:YES];
    }
    self.levelNumberTextField.delegate = self;
    self.levelNameTxtField.delegate = self;
}

- (bool)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (bool)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    [LevelDataLayer getLevelById:self identifiant:self.idRequest];
}


- (IBAction)saveButtonClick:(UIButton *)sender {
    if(self.isCreationMode){
        [LevelDataLayer postLevelWithNumber:self.levelNumberTextField.text andWithName:self.levelNameTxtField.text andResultHandler:^{
            [[self navigationController] popViewControllerAnimated:YES];
        } andErrorHandler:^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information" message:@"An error as occured, please try again" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                // DO NOTHING
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];

        }];
    } else {
        [LevelDataLayer putLevelWithNumber:self.levelNumberTextField.text WithName:self.levelNameTxtField.text andWithId:[NSString stringWithFormat:@"%d", self.level.id] andResultHandler:^{
            [[self navigationController] popViewControllerAnimated:YES];
        } andErrorHandler:^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information" message:@"An error as occured, please try again" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                // DO NOTHING
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }];
    }
}

- (IBAction)deleteButtonClick:(UIButton *)sender {
    [LevelDataLayer deleteLevelWithId:self.level.id andResultHandler:^{
        [[self navigationController] popViewControllerAnimated:YES];
    } andErrorHandler:^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Information" message:@"An error as occured, please try again" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            // DO NOTHING
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }];
}
@end
