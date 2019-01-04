//
//  FireBaseService.m
//  Mioto_objc
//
//  Created by TT Nguyen on 12/8/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import "AccountBusiness.h"
#import "Menu_1_ViewController.h"
#import "ProfileViewController.h"

@interface AccountBusiness() {
    Profile* newUser;
    NSURL *mDownloadedURL;
}
@end

@implementation AccountBusiness

+ (id)sharedInstance {
    static AccountBusiness *service = nil;
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

- (void)saveDataWithEmail:(NSString*)email name:(NSString*)name dob:(NSString*)dob gender:(NSString*)gender imgURL:(NSString*)img phoneNumber:(NSString*)number  {
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    NSString *stringTime = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString* uid = [FIRAuth.auth currentUser].uid;
    [[[self.ref child:@"Users"] child:uid]
     setValue:@{@"mUserDateOfBirth": dob, @"mUserEmail": email, @"mUserGender": gender, @"mUserID": uid, @"mUserImgUrl": img, @"mUserName": name, @"mUserPhone": number, @"mUserJoinedDate": stringTime}];
}

- (void)saveImg {
    NSString* uid = [FIRAuth.auth currentUser].uid;
    [[[[self.ref child:@"Users"] child:uid] child:@"mUserImgUrl"] setValue: mDownloadedURL.absoluteString];
}

- (void)updateDataWithName:(NSString*)name dob:(NSString*)dob gender:(NSString*)gender imgURL:(NSString*)img phoneNumber:(NSString*)number  {
    NSString* uid = [FIRAuth.auth currentUser].uid;
    [[[self.ref child:@"Users"] child:uid]
     setValue:@{@"mUserDateOfBirth": dob, @"mUserGender": gender, @"mUserID": uid, @"mUserImgUrl": newUser.mUserImgUrl, @"mUserName": name, @"mUserPhone": number,  @"mUserEmail": newUser.mUserEmail, @"mUserJoinedDate": newUser.mUserJoinedDate}];
}

- (void)fetchData {
    NSString *userID = [FIRAuth auth].currentUser.uid;
    [[[_ref child:@"Users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        self->newUser = [[Profile alloc] initWithName:snapshot.value[@"mUserName"] email:snapshot.value[@"mUserEmail"] uid:snapshot.value[@"mUserID"] profileImage: snapshot.value[@"mUserImgUrl"] dob: snapshot.value[@"mUserDateOfBirth"] gender: snapshot.value[@"mUserGender"] phone: snapshot.value[@"mUserPhone"] joinedDate: snapshot.value[@"mUserJoinedDate"]];
        if (self.listener) {
            [self.listener profileDataRecieved:1];
        }
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        if (self.listener) {
            [self. listener profileDataRecieved:0];
        }
    }];
}

- (Profile*)getData {
    return newUser;
}

- (void)UploadProfileImage: (UIImage*)image {
    NSString *userID = [FIRAuth auth].currentUser.uid;
    
    FIRStorageReference *storageRef = [[[FIRStorage storage] reference] child:@"UsersImg"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    
    FIRStorageMetadata *meta = [FIRStorageMetadata new];
    meta.contentType = @"image/jpeg";
    
    FIRStorageReference *riversRef = [storageRef child:userID];
    FIRStorageUploadTask *uploadTask = [riversRef putData: imageData
                                                 metadata: meta
                                               completion:^(FIRStorageMetadata *metadata,
                                                            NSError *error) {
                                                   if (error != nil) {
                                                       if (self.listener) {
                                                           [self.listener UploadProfileImageStatus:0];
                                                       }
                                                   } else {
                                                       
                                                       [riversRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                                                           if (error != nil) {
                                                               NSLog(@"%@", error);
                                                           } else {
                                                               self->mDownloadedURL = URL;
                                                               [self saveImg];
                                                               if (self.listener) {
                                                                   [self.listener UploadProfileImageStatus:1];
                                                               }
                                                           }
                                                       }];
                                                   }
                                               }];
}

- (void)logoutFacebook {
    FBSDKLoginManager *loginManager = [FBSDKLoginManager new];
    [loginManager logOut];
}

//Define listener:  0: Login Error -1: Recieved data error
- (void)loginWithFacebook {
    Menu_1_ViewController *menu = [Menu_1_ViewController new];
    FBSDKLoginManager *loginManager = [FBSDKLoginManager new];
    [loginManager logInWithReadPermissions: @[@"public_profile", @"email"] fromViewController: menu handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            if (self.listener) {
                [self.listener LoginFbWithStatus:0];
            }
            return;
        } else {
            if ([FBSDKAccessToken currentAccessToken])
            {
                NSDictionary *param = @{@"fields" : @"email"};
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:param] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        NSLog(@"%@",result);
                        [self signinWithFirebase:result[@"email"]];
                    }
                }];
            }
        }
    }
     ];
}

- (void)signinWithFirebase: (NSString*)email {
    FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                     credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
    [FBSDKAccessToken currentAccessToken];
    
    [[FIRAuth auth] fetchProvidersForEmail:email completion:^(NSArray<NSString *> * _Nullable providers, NSError * _Nullable error) {
        if (providers) {
            [FBSDKAccessToken currentAccessToken];
            [[FIRAuth auth] signInAndRetrieveDataWithCredential:credential
                                                     completion:^(FIRAuthDataResult * _Nullable authResult,
                                                                  NSError * _Nullable error) {
                                                         if (self.listener) {
                                                             [self.listener LoginFbWithStatus:1];
                                                         }
                                                     }];
            
            NSLog(@"tai khoan da ton tai");
        } else {
            NSLog(@"tai khoan 0 ton tai");
            [[FIRAuth auth] signInAndRetrieveDataWithCredential:credential
                                                     completion:^(FIRAuthDataResult * _Nullable authResult,
                                                                  NSError * _Nullable error) {
                                                         if (error) {
                                                             if (self.listener) {
                                                                 [self.listener LoginFbWithStatus:-1];
                                                             }
                                                             NSLog(@"%@", error.localizedDescription);
                                                             return;
                                                         }
                                                         FIRUser *user = authResult.user;
                                                         
                                                         NSLog(@"Don't have email");
                                                         [self saveDataWithEmail:user.email name:user.displayName dob:@"Chưa chọn" gender:@"Chưa chọn" imgURL: [user.photoURL.absoluteString stringByAppendingString:@"?type=large"] phoneNumber:@"Chưa chọn"];
                                                         
                                                         if (self.listener) {
                                                             [self.listener LoginFbWithStatus:1];
                                                         }
                
        }];
    }
     }];
    
    
}


- (void) fbLinking {
    ProfileViewController *menu = [ProfileViewController new];
    FBSDKLoginManager *loginManager = [FBSDKLoginManager new];
    [loginManager logInWithReadPermissions: @[@"public_profile", @"email"] fromViewController: menu handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            if (self.listener) {
                [self.listener LoginFbWithStatus:0];
            }
            return;
        } else {
            FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                             credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
            NSLog(@"%@", [[FIRAuth auth].currentUser uid]);
            [[FIRAuth auth].currentUser linkAndRetrieveDataWithCredential:credential
                                                               completion:^(FIRAuthDataResult *result, NSError *_Nullable error) {
                                                                   if (error)
                                                                       NSLog(@"FAIL");
                                                                   else {
                                                                       NSLog(@"SUCCESS");
                                                                   }
                                                               }];
        }
    }
     ];
}



- (void)resetPasswordWithEmail:(NSString*)email {
    [[FIRAuth auth] sendPasswordResetWithEmail:email completion:^(NSError *_Nullable error) {
        if (error != nil) {
            if (self.listener)
                [self.listener didSendRequestToResetPassword:0];
        } else
            if (self.listener)
                [self.listener didSendRequestToResetPassword:1];
    }];
}
@end
