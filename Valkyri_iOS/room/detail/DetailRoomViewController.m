//
//  DetailRoomViewController.m
//  Valkyri_iOS
//
//  Created by Nico on 16/07/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "DetailRoomViewController.h"
#import "RoomDatalayer.h"
#import "Room.h"
#import "UserInformation.h"

@interface DetailRoomViewController () <UITextFieldDelegate>

@end

@implementation DetailRoomViewController
@synthesize idRequest = idRequest_;
@synthesize room = room_;
@synthesize isCreationMode = isCreationMode_;

- (instancetype)initWithIdRequest:(int)idRequest {
    self = [super init];
    if (self) {
        self.idRequest = idRequest;
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
    [self loadData];
    if([UserInformation getConnectedUserLvl] > 0) {
        [self.PlaceNumberTextfield setUserInteractionEnabled:NO];
        [self.PlaceLevelNumberTextfield setUserInteractionEnabled:NO];
        [self.deleteButton setHidden:YES];
        [self.saveButton setHidden:YES];
    } else {
        if(self.isCreationMode) {
            [self.deleteButton setHidden:YES];
        } else {
            [self.deleteButton setHidden:NO];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    [RoomDatalayer getRoomWithId:[NSNumber numberWithInt:self.idRequest] andRoomView:self];
}

//postRoomWithNumber:(NSNumber*)number andWithLevelNumber:(NSNumber*)levelNumber nameandResultHandler:(void (^)(void)) resultHandler andErrorHandler:(void (^)(void)) errorHandler;

- (IBAction)saveButtonClick:(UIButton *)sender {
    NSNumberFormatter *cast = [[NSNumberFormatter alloc] init];
    cast.numberStyle = NSNumberFormatterDecimalStyle;
    if(self.isCreationMode){
        
        NSNumber *placeNumber = [cast numberFromString:self.PlaceNumberTextfield.text ];
        NSNumber *placeLevelNumber = [cast numberFromString:self.PlaceLevelNumberTextfield.text ];
        
        [RoomDatalayer postRoomWithNumber:placeNumber andWithLevelNumber:placeLevelNumber andResultHandler:^{
            
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
        NSNumber *placeNumber = [cast numberFromString:self.PlaceNumberTextfield.text ];
        NSNumber *placeLevelNumber = [cast numberFromString:self.PlaceLevelNumberTextfield.text ];
        [RoomDatalayer putRoomWithNumber:placeNumber WithlevelNumber:placeLevelNumber andWithId:[NSNumber numberWithInt:self.room.id] andResultHandler:^{
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
    
    [RoomDatalayer deleteRoomWithId:[NSNumber numberWithInt:self.room.id] andResultHandler:^{
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
