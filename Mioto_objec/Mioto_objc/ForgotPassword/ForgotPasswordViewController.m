//
//  ForgotPasswordViewController.m
//  Mioto_objc
//
//  Created by TT Nguyen on 12/1/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController () <AuthListener> {
    AuthApi *authInstance;
    IBOutlet UITextField *email;
    IBOutlet UIButton *reset;
}

- (IBAction)resetButton:(id)sender;
- (IBAction)dismiss:(id)sender;


@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    authInstance = [AuthApi sharedInstance];
    authInstance.listener = self;
}

- (void)AuthStatus:(int)status {
    if (status == 0) {
        [AlertHelper showAlertWithMessage:@"Đã xảy ra lỗi khi đặt lại mật khẩu !"];
        email.text = @"";
    }
    else {
        [AlertHelper showAlertWithMessage:@"Yêu cầu đã được gửi đến email của bạn !"];
        [UIView animateWithDuration:1 delay:0 options:(UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            double delayInSeconds = 2;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self dismissViewControllerAnimated:true completion:nil];
            });
        }completion:^(BOOL finished){
        }];
        
    }
}

- (IBAction)resetButton:(id)sender {
    if (email.text.length != 0)
        [authInstance resetPasswordWithEmail:email.text];
    else
        [AlertHelper showAlertWithMessage:@"Vui lòng nhập email để đặt lại mật khẩu"];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
