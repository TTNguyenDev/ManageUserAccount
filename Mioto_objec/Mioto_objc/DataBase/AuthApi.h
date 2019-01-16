//
//  AuthApi.h
//  Mioto_objc
//
//  Created by TT Nguyen on 1/9/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirebaseAuth.h"
#import "FirebaseDatabase.h"
#import "Profile.h"


NS_ASSUME_NONNULL_BEGIN
@class AuthApi;

@protocol AuthListener <NSObject>
- (void) AuthStatus:(int) status;
@end

@interface AuthApi : NSObject
+ (id)sharedInstance;
- (void)signupWithEmail: (NSString*)email
               password:(NSString*)pass;
- (void)signinWithEmail:(NSString*)email
               password:(NSString*)pass;
- (void)resetPasswordWithEmail:(NSString*)email;
- (bool)didLogin;
- (void)logout;

@property (nonatomic, weak) id<AuthListener> listener;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

NS_ASSUME_NONNULL_END
