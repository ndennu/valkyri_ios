//
//  Access.h
//  Valkyri_iOS
//
//  Created by Nico on 11/07/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Access : NSObject {
    @private
    int id_;
    NSDate *h1_;
    NSDate *h2_;
    int place_id_;
    int level_number_;
}

@property (nonatomic, assign) int id;
@property (nonatomic, assign) int place_id;
@property (nonatomic, assign) int level_number;
@property (nonatomic, strong) NSDate *h1;
@property (nonatomic, strong) NSDate *h2;

/// Constructeur prenant en paramètre, un dictionnaire
- (instancetype) initWithNSDictionnary:(NSDictionary*) dict;


@end
