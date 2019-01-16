//
//  AuthApi.m
//  Mioto_objc
//
//  Created by TT Nguyen on 1/9/19.
//  Copyright © 2019 TT Nguyen. All rights reserved.
//

#import "AuthApi.h"

@implementation AuthApi

+ (id)sharedInstance {
    static AuthApi *service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[self alloc] init];
    });
    return service;
}

- (id)init {
    if (self = [super init]) {
        self.ref = [[FIRDatabase database] reference];
    }
    return self;
}

- (void)signupWithEmail: (NSString*)email
               password:(NSString*)pass {
    
    [[FIRAuth auth] createUserWithEmail:email
                               password:pass
                             completion:^(FIRAuthDataResult * _Nullable authResult,
                                          NSError * _Nullable error) {
                                 if (error != nil) {
                                     if (self.listener) {
                                         [self.listener AuthStatus:0];
                                     }
                                 } else {
                                     if (self.listener) {
                                         [self.listener AuthStatus:1];
                                         
                                     }
                                 }
                             }];
}

- (void)signinWithEmail:(NSString*)email
               password:(NSString*)pass {
    FIRAuthCredential *credential =
    [FIREmailAuthProvider credentialWithEmail:email
                                     password:pass];
    
    [[FIRAuth auth] signInAndRetrieveDataWithCredential:credential
                                             completion:^(FIRAuthDataResult * _Nullable authResult,
                                                          NSError * _Nullable error) {
                                                 if (error) {
                                                     if (error != nil) {
                                                         if (self.listener) {
                                                             [self.listener AuthStatus:0];
                                                         }
                                                     }
                                                 } else {
                                                     if (self.listener) {
                                                         [self.listener AuthStatus:1];
                                                     }
                                                 }
                                             }];
}

- (void)resetPasswordWithEmail:(NSString*)email {
    [[FIRAuth auth] sendPasswordResetWithEmail:email completion:^(NSError *_Nullable error) {
        if (error != nil) {
            if (self.listener)
                [self.listener AuthStatus:0];
        } else
            if (self.listener)
                [self.listener AuthStatus:1];
    }];
}

- (bool)didLogin {
    if ([FIRAuth.auth currentUser])
        return true;
    return false;
}

- (void)logout {
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        if (self.listener) {
            [self.listener AuthStatus:0];
            return;
        }
    } else {
        if (self.listener) {
            [self.listener AuthStatus:1];
        }
    }
}

@end
