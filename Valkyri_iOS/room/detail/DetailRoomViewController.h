//
//  DetailRoomViewController.h
//  Valkyri_iOS
//
//  Created by Nico on 16/07/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Room;
@interface DetailRoomViewController : UIViewController {
    @private
    int idRequest_;
    Room* room_;
    bool isCreationMode_;
}

- (IBAction)saveButtonClick:(id)sender;

- (IBAction)deleteButtonClick:(id)sender;

@property (nonatomic, assign) int idRequest;

@property (strong, nonatomic) Room *room;

@property (weak, nonatomic) IBOutlet UITextField *PlaceNumberTextfield;

@property (weak, nonatomic) IBOutlet UITextField *PlaceLevelNumberTextfield;

@property (assign, nonatomic) bool isCreationMode;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

- (instancetype)initWithIdRequest:(int) idRequest;

- (void)loadData;



- (instancetype)initForCreation;


@end
