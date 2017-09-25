//
//  LevelDetails.h
//  Valkyri_iOS
//
//  Created by apple on 16/06/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Level;

@interface LevelDetails : UIViewController {
    @private
    int idRequest_;
    Level* level_;
    bool isCreationMode_;
}

@property (weak, nonatomic) IBOutlet UITextField *levelNameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *levelNumberTextField;
@property (strong, nonatomic) Level *level;
@property (assign, nonatomic) bool isCreationMode;

- (IBAction)saveButtonClick:(UIButton *)sender;
- (IBAction)deleteButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property(nonatomic, assign) int idRequest;

- (instancetype)initWithIdRequest:(int) idRequest;
- (instancetype)initForCreation;

- (void)loadData;

@end
