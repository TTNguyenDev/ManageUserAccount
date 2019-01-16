//
//  Menu_1_ViewController.m
//  Mioto_objc
//
//  Created by TT Nguyen on 12/7/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import "Menu_1_ViewController.h"

@interface Menu_1_ViewController () <AuthListener, FireBaseListener> {
    IBOutlet UIButton *createAccount;
    AccountBusiness *shareInstance;
    
    
    IBOutlet UIActivityIndicatorView *activityIndicator;
    AuthApi *authInstance;
}

- (IBAction)SigninButton:(id)sender;
- (IBAction)SignupButton:(id)sender;
- (IBAction)LoginWithFB:(id)sender;
@end

@implementation Menu_1_ViewController

- (void)setupBorder {
    [self->createAccount.layer setBorderWidth:1.0];
    [self->createAccount.layer setBorderColor:[[UIColor whiteColor] CGColor]];
}

- (void)autoLogin {
    if ([authInstance didLogin]) {
        ProfileViewController *vc2 = [[ProfileViewController alloc] init];
        [self.navigationController pushViewController:vc2 animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    shareInstance = [AccountBusiness sharedInstance];
    shareInstance.listener = self;
    authInstance = [AuthApi sharedInstance];
    authInstance.listener = self;
    [self autoLogin];
    [self setupBorder];
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false;
    [activityIndicator stopAnimating];
}

- (void)disableUserInteraction {
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}

- (void)enableUserInteraction {
    [activityIndicator stopAnimating];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (IBAction)SigninButton:(id)sender {
    SigninViewController *vc2 = [[SigninViewController alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
}

- (IBAction)SignupButton:(id)sender {
    SignupViewController *vc2 = [[SignupViewController alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
}

- (IBAction)LoginWithFB:(id)sender {
    [shareInstance loginWithFacebook];
    [self disableUserInteraction];
}

- (void)LoginFbWithStatus:(int)status {
    [self enableUserInteraction];
    
    ProfileViewController *vc2 = [[ProfileViewController alloc] init];

    switch (status) {
        case -1:
            [AlertHelper showAlertWithMessage:@"Không thể lấy dữ liệu từ Facebook của bạn"];
            break;

        case 0:
            [AlertHelper showAlertWithMessage:@"Đã có lỗi xảy ra khi đăng nhập, vui lòng thử lại sau"];
            break;

        case 1:
            [self.navigationController pushViewController: vc2 animated:YES];
            break;

        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    self .navigationController.navigationBarHidden = true;
    [super viewWillAppear:true];
}

@end
