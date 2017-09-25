//
//  Level.h
//  Valkyri_iOS
//
//  Created by Jeyaksan RAJARATNAM on 24/06/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject {
@private
    int id_;
    NSString *name_;
    int number_;
}

@property(nonatomic, assign) int id;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) int number;

/// Constructeur prenant en paramètre, un dictionnaire
- (instancetype) initWithNSDictionnary:(NSDictionary*) dict;

@end
