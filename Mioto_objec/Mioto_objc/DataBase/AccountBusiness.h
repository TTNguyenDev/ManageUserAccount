//
//  FireBaseService.h
//  Mioto_objc
//
//  Created by TT Nguyen on 12/8/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirebaseAuth.h"
#import "Menu_1_ViewController.h"
#import "ProfileViewController.h"
#import "FirebaseDatabase.h"
#import "Profile.h"
#import "FirebaseStorage.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


NS_ASSUME_NONNULL_BEGIN

@class AccountBusiness;

@protocol FireBaseListener
- (void)profileDataRecieved:(int)status;
- (void)UploadProfileImageStatus:(int)status;
- (void)LoginFbWithStatus:(int)status;
- (void)LinkingFBStatus:(int)status;
- (void)LinkingGGStatus:(int)status;
- (void)successProfileWith:(Profile*)profile;
@end

@interface AccountBusiness : NSObject
+ (id) sharedInstance;
- (void) UploadProfileImage: (UIImage*)image;
- (void) saveDataWithEmail:(NSString*)email name:(NSString*)name dob:(NSString*)dob gender:(NSString*)gender imgURL:(NSString*)img phoneNumber:(NSString*)number fbLink:(NSString*)fbLink emailLink:(NSString*)emailLink;
- (void) updateDataWithName:(NSString*)name dob:(NSString*)dob gender:(NSString*)gender imgURL:(NSString*)img phoneNumber:(NSString*)number;
- (void) fetchData;
- (Profile*)getData;
- (void) loginWithFacebook;
- (void) emailLinking:(NSString*) password;
- (void) fetchAllData;
- (void) fbLinking;

@property (nonatomic, weak) id<FireBaseListener> listener;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

NS_ASSUME_NONNULL_END
