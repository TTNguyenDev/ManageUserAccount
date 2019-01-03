//
//  SigninViewController.m
//  Mioto_objc
//
//  Created by TT Nguyen on 12/1/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import "SigninViewController.h"

@interface SigninViewController () <FireBaseListener> {
    AccountBusiness *shareInstance;
    
    IBOutlet UIActivityIndicatorView *activeBar;
    IBOutlet UITextField *email;
    IBOutlet UITextField *password;
    IBOutlet UIButton *signin;
}

- (IBAction)signinButton:(id)sender;
- (IBAction)dismiss:(id)sender;
- (IBAction)forgetPassword:(id)sender;

@end

@implementation SigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    shareInstance = [AccountBusiness sharedInstance];
    shareInstance.listener = self;
}


-(void)clear {
    email.text = @"";
    password.text = @"";
}

-(void)check {
    if (email.text.length == 0 && password.text.length == 0) {
        [AlertHelper showAlertWithMessage:@"Bạn chưa nhập thông tin đăng nhập"];
    }
    
    else if (email.text.length == 0) {
        [AlertHelper showAlertWithMessage:@"Vui lòng nhập Email"];
        [self clear];
    }
    
    else if (password.text.length < 6) {
        [AlertHelper showAlertWithMessage:@"Vui lòng nhập lại mật khẩu"];
        [self clear];
    }
}

- (void)AuthStatus:(int)status {
    if (!status && email.text.length != 0) {
        [AlertHelper showAlertWithMessage:@"Email hoặc mật khẩu sai"];
    } else if (status) {
        [self->activeBar startAnimating];
        self->signin.hidden = true;
        
        ProfileViewController *vc2 = [[ProfileViewController alloc] init];
        [self.navigationController pushViewController:vc2 animated:YES];
    }
    [self clear];
}

- (IBAction)signinButton:(id)sender {
    [self check];
    
    [shareInstance signinWithEmail:email.text password:password.text];
}

- (IBAction)dismiss:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)forgetPassword:(id)sender {
    ForgotPasswordViewController *resetPass = [ForgotPasswordViewController new];
    [self presentViewController:resetPass animated:true completion:nil];
}
@end
