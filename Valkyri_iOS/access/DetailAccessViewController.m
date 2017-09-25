//
//  DetailAccessViewController.m
//  Valkyri_iOS
//
//  Created by Nico on 16/07/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "DetailAccessViewController.h"
#import "AccessDatalayer.h"
#import "LevelDatalayer.h"
#import "RoomDatalayer.h"
#import "Tools.h"
#import "Level.h"
#import "Room.h"

@interface DetailAccessViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation DetailAccessViewController
@synthesize idRequest = idRequest_;
@synthesize access = access_;
@synthesize isCreationMode = isCreationMode_;
@synthesize data = data_;
@synthesize roomArray = roomArray_;
@synthesize levelArray = levelArray_;
@synthesize selectedPlaceId = selectedPlaceId_;
@synthesize selectedLevelNumber = selectedLevelNumber_;

- (instancetype)initWithIdRequest:(int)identifiant {
    self = [super init];
    if (self) {
        self.idRequest = identifiant;
        self.access.id = identifiant;
        self.isCreationMode = NO;
    }
    return  self;
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
    
    self.title = @"Room access settings";
    
    self.hourOpenedDatePicker.datePickerMode = UIDatePickerModeTime;
    self.hourClosedDatePicker.datePickerMode = UIDatePickerModeTime;

    self.levelDataPicker.delegate = self;
    self.levelDataPicker.dataSource = self;
    
    self.roomDataPicker.delegate = self;
    self.roomDataPicker.dataSource = self;
    
    self.levelArray = [LevelDataLayer getAllLevelsWithDetailAccessView:self];
    self.roomArray = [RoomDatalayer getAllRoomWithAccessDetailView:self];
    
    if(!self.isCreationMode){
        [self loadData];
    } else {
        self.selectedLevelNumber = 1;
        self.selectedPlaceId = 1;
        [self.deleteButton setHidden:YES];
    }
    //self.levelNumberTextField.delegate = self;
    //self.levelNameTxtField.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void) reloadLevelPickerViewWithLevelName:(NSString*) name {
    self.actualLevelNumber.text = [NSString stringWithFormat:@"Actual level %@", name];
    [self.levelDataPicker reloadAllComponents];
}

- (void) reloadRoomPickerViewWithRoomNumber:(int) identifiant {
    self.actualRoomNumber.text = [NSString stringWithFormat:@"Actual room %d", identifiant];
    [self.roomDataPicker reloadAllComponents];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
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
    [AccessDatalayer getAccessWithId:self.idRequest andAccessView:self];
}

- (IBAction)saveButtonClick:(UIButton *)sender {
    if(self.isCreationMode){
        
        [AccessDatalayer postAccessWithH1:[Tools getJsonDateStringFromNSDate:self.hourOpenedDatePicker.date] andWithH2:[Tools getJsonDateStringFromNSDate:self.hourClosedDatePicker.date] andWithRoom:[NSString stringWithFormat:@"%d", selectedPlaceId_] andWithLevel:[NSString stringWithFormat:@"%d", selectedLevelNumber_] andResultHandler:^{
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
        
        [AccessDatalayer putAccessWithH1:[Tools getTimeStringFromNSDate:self.hourOpenedDatePicker.date] WithH2:[Tools getTimeStringFromNSDate:self.hourClosedDatePicker.date] andWithRoom:[NSString stringWithFormat:@"%d", selectedPlaceId_] andWithLevel:[NSString stringWithFormat:@"%d", selectedLevelNumber_] andWithId:[NSString stringWithFormat:@"%d", self.idRequest] andResultHandler:^{
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
    [AccessDatalayer deleteAccessWithId:self.idRequest andResultHandler:^{
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

- (void) h1OnClick:(UITextField *)sender{
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView.tag == 3) {
        return self.roomArray.count;
    } else if(pickerView.tag == 4) {
        return self.levelArray.count;
    } else {
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(pickerView.tag == 3) {
        return [NSString stringWithFormat:@"Room n° %d", [self.roomArray objectAtIndex:row].number];
    } else if(pickerView.tag == 4) {
        return [self.levelArray objectAtIndex:row].name;
    } else {
        return 0;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(pickerView.tag == 3) {
        selectedPlaceId_ = [self.roomArray objectAtIndex:row].id;
    } else if(pickerView.tag == 4) {
        selectedLevelNumber_ = [self.levelArray objectAtIndex:row].number;
    }
}


@end
