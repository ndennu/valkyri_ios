//
//  Account.h
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject {
    @private
        int id_;
        NSString *matricule_;
        NSString *lastname_;
        NSString *firstname_;
        NSString *email_;
        NSString *password_;
        NSString *digicode_;
        NSString *phone_;
        int level_id_;
        NSDate *createdAt_;
        NSDate *updatedAt_;
}

@property(nonatomic, assign) int id;
@property(nonatomic, strong) NSString* matricule;
@property(nonatomic, strong) NSString* lastname;
@property(nonatomic, strong) NSString* firstname;
@property(nonatomic, strong) NSString* email;
@property(nonatomic, strong) NSString* password;
@property(nonatomic, strong) NSString* digicode;
@property(nonatomic, strong) NSString* phone;
@property(nonatomic, assign) int level_id;
@property(nonatomic, strong) NSDate *createdAt;
@property(nonatomic, strong) NSDate *updatedAt;

/// Constructeur prenant en paramètre, un dictionnaire
- (instancetype) initWithNSDictionnary:(NSDictionary*) dict;

@end
