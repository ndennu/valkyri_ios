//
//  IssueTableViewCell.m
//  Valkyri_iOS
//
//  Copyright © 2017 valkyri.com. All rights reserved.
//

#import "IssueTableViewCell.h"

@implementation IssueTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.roundSticker.layer.cornerRadius = 15.0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
