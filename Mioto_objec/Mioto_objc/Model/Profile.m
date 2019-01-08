//
//  Profile.m
//  Mioto_objc
//
//  Created by TT Nguyen on 12/11/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import "Profile.h"

@implementation Profile
//NSString* mUsername;
//NSString* mUserEmail;
//NSString* mUserId;
//NSString* mUserImage;
//NSString* mDob;
//bool gender; //Define 1 is male 0 is female

- (instancetype) initWithName:(NSString *)username email:(NSString *)email uid:(NSString *)uid profileImage:(NSString *)image dob:(NSString *)dob gender:(NSString *)gender phone:(NSString*)phone joinedDate:(NSString*)date fb:(NSString*)fbLink email:(NSString*) emailLink {
    self = [super init];
    if (self) {
        _mUserName = username;
        _mUserEmail = email;
        _mUserID = uid;
        _mUserImgUrl = image;
        _mUserDateOfBirth = dob;
        _mUserGender = gender;
        _mUserPhone = phone;
        _mUserJoinedDate = date;
        _mFBLinking = fbLink;
        _mEmailLinking = emailLink;
    }
    return self;
}

- (instancetype) transformUser:(NSDictionary*) dict {
    if (self) {
        _mUserName = dict[@"mUserName"];
        _mUserEmail = dict[@"mUserEmail"];
        _mUserID = dict[@"mUserID"];
        _mUserImgUrl = dict[@"mUserImgUrl"];
        _mUserDateOfBirth = dict[@"mUserDateOfBirth"];
        _mUserGender = dict[@"mUserGender"];
        _mUserPhone = dict[@"mUserPhone"];
        _mUserJoinedDate = dict[@"mUserJoinedDate"];
        _mFBLinking = dict[@"mFBLinking"];
        _mEmailLinking = dict[@"mEmailLinking"];
    }
    return self;
}



@end
