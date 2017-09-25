//
//  UserImageSelectionViewController.h
//  Valkyri_iOS
//
//  Created by Jeyaksan RAJARATNAM on 23/07/2017.
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserImageSelectionViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    @private
    bool _newMedia;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
