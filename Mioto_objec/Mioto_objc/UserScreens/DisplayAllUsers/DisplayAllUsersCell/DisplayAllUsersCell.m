//
//  DisplayAllUsersCell.m
//  Mioto_objc
//
//  Created by TT Nguyen on 1/7/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

#import "DisplayAllUsersCell.h"

@implementation DisplayAllUsersCell {
    
}


- (void)didSetFromUser: (Profile*)profile {
    name.text = profile.mUserName;
    [self->profileImage sd_setImageWithURL: [NSURL URLWithString: profile.mUserImgUrl]];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
