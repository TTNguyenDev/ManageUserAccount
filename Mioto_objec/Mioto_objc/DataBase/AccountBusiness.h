//
//  FireBaseService.h
//  Mioto_objc
//
//  Created by TT Nguyen on 12/8/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirebaseAuth.h"
#import "FirebaseDatabase.h"
#import "Profile.h"
#import "FirebaseStorage.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AccountBusiness;

@protocol FireBaseListener
- (void)AuthStatus:(int)status;
- (void)profileDataRecieved:(int)status;
- (void)didSendRequestToResetPassword:(int)status;
- (void)UploadProfileImageStatus:(int)status;
- (void)LoginFbWithStatus:(int)status;
@end

@interface AccountBusiness : NSObject
+ (id)sharedInstance;
- (void)UploadProfileImage: (UIImage*)image;
- (void)signupWithEmail:(NSString*)email
               password:(NSString*)pass;
- (void)signinWithEmail:(NSString*)email
               password:(NSString*)pass;
- (void)saveDataWithEmail:(NSString*)email name:(NSString*)name dob:(NSString*)dob gender:(NSString*)gender imgURL:(NSString*)img phoneNumber:(NSString*)number;
- (void)updateDataWithName:(NSString*)name dob:(NSString*)dob gender:(NSString*)gender imgURL:(NSString*)img phoneNumber:(NSString*)number;
- (void)fetchData;
- (Profile*)getData;
- (bool)didLogin;
- (void)logout;
- (void)resetPasswordWithEmail:(NSString*)email;
- (void)loginWithFacebook;

@property (nonatomic, weak) id<FireBaseListener> listener;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

NS_ASSUME_NONNULL_END
