//
//  DisplayAllUsersCell.h
//  Mioto_objc
//
//  Created by TT Nguyen on 1/7/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profile.h"
#import "SDWebImage/UIImageView+WebCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface DisplayAllUsersCell : UITableViewCell {
    @public
    IBOutlet UIImageView *profileImage;
    IBOutlet UILabel *name;
   
}

 - (void) didSetFromUser:(Profile*)profile;
@end

NS_ASSUME_NONNULL_END
