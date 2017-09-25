//
//  DetailAccessViewController.h
//  Valkyri_iOS
//
//  Created by Nico on 16/07/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Access;
@class Room;
@class Level;

@interface DetailAccessViewController : UIViewController {
    @private
    int idRequest_;
    Access* access_;
    bool isCreationMode_;
    NSArray *data_;
    NSMutableArray<Room*> *roomArray_;
    NSMutableArray<Level*> *levelArray_;
    int selectedPlaceId_;
    int selectedLevelNumber_;
}

@property (nonatomic, strong) NSArray* data;
@property (nonatomic, strong) NSMutableArray<Room*> *roomArray;
@property (nonatomic, strong) NSMutableArray<Level*> *levelArray;
@property (nonatomic, assign) int selectedPlaceId;
@property (nonatomic, assign) int selectedLevelNumber;

@property (weak, nonatomic) IBOutlet UILabel *actualRoomNumber;
@property (weak, nonatomic) IBOutlet UILabel *actualLevelNumber;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *hourOpenedDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *hourClosedDatePicker;

- (IBAction)saveButtonClick:(UIButton *)sender;
- (IBAction)deleteButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *roomDataPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *levelDataPicker;

- (IBAction)h1OnClick:(UITextField *)sender;


@property (nonatomic, assign) int idRequest;
@property (strong, nonatomic) Access *access;
@property (assign, nonatomic) bool isCreationMode;

- (instancetype)initWithIdRequest:(int) identifiant;
- (instancetype)initForCreation;

- (void)loadData;
//rafraichissement du lvl picker
- (void) reloadLevelPickerViewWithLevelName:(NSString*) name;
//rafraichissement du numéro de la room
- (void) reloadRoomPickerViewWithRoomNumber:(int) identifiant ;
@end
