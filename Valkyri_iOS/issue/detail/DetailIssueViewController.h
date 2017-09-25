//
//  DetailIssueViewController.h
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailIssueViewController : UIViewController{
    
    @private
    int idRequest_;
}

// History Related Informations
@property (weak, nonatomic) IBOutlet UILabel *roomNumber;
@property (weak, nonatomic) IBOutlet UILabel *authorizationStatus;
@property (weak, nonatomic) IBOutlet UILabel *eventDate;
@property (weak, nonatomic) IBOutlet UILabel *eventTime;
@property (weak, nonatomic) IBOutlet UILabel *roomLevel;

// User Related Informations
@property (weak, nonatomic) IBOutlet UILabel *userFirstname;
@property (weak, nonatomic) IBOutlet UILabel *userLastname;
@property (weak, nonatomic) IBOutlet UILabel *userMatricule;
@property (weak, nonatomic) IBOutlet UILabel *userEmail;
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
@property (weak, nonatomic) IBOutlet UILabel *userLevel;


@property(nonatomic, assign) int idRequest;

- (instancetype)initWithIdRequest:(int)idRequest;
- (void)loadData;

@end
