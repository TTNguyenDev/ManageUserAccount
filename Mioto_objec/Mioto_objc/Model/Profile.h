//
//  Profile.h
//  Mioto_objc
//
//  Created by TT Nguyen on 12/11/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Profile.h"

NS_ASSUME_NONNULL_BEGIN

@class Profile;

@interface Profile : NSObject

@property (strong, nonatomic) NSString* mUserDateOfBirth;
@property (strong, nonatomic) NSString* mUserEmail;
@property (strong, nonatomic) NSString* mUserGender;
@property (strong, nonatomic) NSString* mUserID;
@property (strong, nonatomic) NSString* mUserImgUrl;
@property (strong, nonatomic) NSString* mUserName;
@property (strong, nonatomic) NSString* mUserPhone;
@property (strong, nonatomic) NSString* mUserJoinedDate;
@property (strong, nonatomic) NSString* mFBLinking;
@property (strong, nonatomic) NSString* mEmailLinking;

- (instancetype) initWithName:(NSString*)username email:(NSString*)email uid:(NSString*)uid profileImage:(NSString*)image dob:(NSString*)dob gender:(NSString *)gender phone:(NSString*)phone joinedDate:(NSString*)date fb:(NSString*)fbLink email:(NSString*) emailLink;
- (instancetype) transformUser:(NSDictionary*) dict;
@end

NS_ASSUME_NONNULL_END
