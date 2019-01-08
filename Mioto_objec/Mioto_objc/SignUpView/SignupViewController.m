//
//  SignupViewController.m
//  Mioto_objc
//
//  Created by TT Nguyen on 12/4/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController() <CheckBoxListener, FireBaseListener>  {
    IBOutlet CheckBox *termPrivacy_checkbox_00;
    IBOutlet CheckBox *termPrivacy_checkbox_01;
    AccountBusiness *shareInstance;
    
    IBOutlet UIActivityIndicatorView *activeBar;
    IBOutlet UITextField *username;
    IBOutlet UITextField *email;
    IBOutlet UITextField *password;
    IBOutlet UITextField *rePassword;
    IBOutlet UIButton *signup;
}

- (IBAction)dismiss:(id)sender;
- (IBAction)signupButton:(id)sender;

@end

@implementation SignupViewController

- (void)setupTerm_Privacy {
    termPrivacy_checkbox_00.listener = self;
    termPrivacy_checkbox_01.listener = self;
    termPrivacy_checkbox_01.titleLabel.numberOfLines = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTerm_Privacy];
    shareInstance = [AccountBusiness sharedInstance];
    shareInstance.listener = self;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [SVProgressHUD dismiss];
    [self.view endEditing:true];
    
}
-(void)check {
    if (username.text.length == 0 || email.text.length == 0 || password.text != rePassword.text) {
        if (username.text.length == 0) {
            [AlertHelper showAlertWithMessage:@"Vui lòng nhập tên đăng nhập"];
        }
        if (email.text.length == 0) {
            [AlertHelper showAlertWithMessage:@"Vui lòng nhập Email"];
            [self clear:@"email"];
        }
        if (password.text != rePassword.text) {
            [AlertHelper showAlertWithMessage:@"Mật khẩu không trùng nhau"];
            [self clear:@"password"];
        }
    }
    
    else if (termPrivacy_checkbox_00.isCheck == false || termPrivacy_checkbox_01.isCheck == false)
        [AlertHelper showAlertWithMessage:@"Đồng ý các điều khoản để tiếp tục"];
    else
        if (password.text.length < 6) {
            [AlertHelper showAlertWithMessage:@"Mật khẩu bạn nhập ít hơn 6 kí tự"];
            [self clear:@"password"];
            [self uncheck_checkBox];
        }
}

- (void)uncheck_checkBox {
    termPrivacy_checkbox_01.isCheck = false;
    termPrivacy_checkbox_00.isCheck = false;
}

-(void)clear:(NSString*)type {
    if([type  isEqual: @"password"]) {
        password.text = @"";
        rePassword.text = @"";
    }
    
    else if([type  isEqual: @"email"]) {
        email.text = @"";
    }
    
    else if([type  isEqual: @"all"]) {
        username.text = @"";
        email.text = @"";
        password.text = @"";
        rePassword.text = @"";
    }
    [self uncheck_checkBox];
}

- (void)checkBoxValueDidChanged:(bool)value {    
    if (termPrivacy_checkbox_00.isCheck == true && termPrivacy_checkbox_01.isCheck == true) {
        [self check];
    }
    return;
}

- (IBAction)dismiss:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)AuthStatus:(int)status {
    if (!status && username.text.length != 0) {
        [AlertHelper showAlertWithMessage:@"Tài khoản đã tồn tại hoặc email sai cú pháp!"];
        [self clear:@"all"];
    } else if (status){
        [self->activeBar startAnimating];
        self->signup.hidden = true;
        [shareInstance saveDataWithEmail: email.text name:username.text dob: @"Chưa chọn" gender: @"Chưa chọn" imgURL: @"https://firebasestorage.googleapis.com/v0/b/mymioto.appspot.com/o/UsersImg%2Fdefaultavatar.jpg?alt=media&token=d01ebb9c-bc62-469f-b709-db483bb0e284" phoneNumber: @"" fbLink:@"false" emailLink: @"true"];
        
        ProfileViewController *vc2 = [[ProfileViewController alloc] init];
        [self.navigationController pushViewController:vc2 animated:YES];
    }
}

- (IBAction)signupButton:(id)sender {
    [self check];
    [shareInstance signupWithEmail:email.text password:password.text];
}
@end
