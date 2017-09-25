//
//  Room.h
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Room : NSObject {
    @private
    int id_;
    int level_id_;
    int number_;
    NSDate *createdAt_;
    NSDate *updatedAt_;
}

@property(nonatomic, assign) int id;
@property(nonatomic, assign) int level_id;
@property(nonatomic, assign) int number;
@property(nonatomic, strong) NSDate *createdAt;
@property(nonatomic, strong) NSDate *updatedAt;

/// Constructeur prenant en paramètre, un dictionnaire
- (instancetype) initWithNSDictionnary:(NSDictionary*) dict;

@end
