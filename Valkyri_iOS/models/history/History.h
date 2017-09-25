//
//  History.h
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface History : NSObject {
    @private
    int id_;
    BOOL authorize_;
    int user_id_;
    int place_id_;
    NSDate *createdAt_;
}

@property(nonatomic, assign) int id;
@property(nonatomic, assign) BOOL authorize;
@property(nonatomic, assign) int user_id;
@property(nonatomic, assign) int place_id;
@property(nonatomic, strong) NSDate *createdAt;

/// Constructeur prenant en paramètre, un dictionnaire (json nodeJS)
- (instancetype)initWithNSDictionnar: (NSDictionary*) dict;

@end
