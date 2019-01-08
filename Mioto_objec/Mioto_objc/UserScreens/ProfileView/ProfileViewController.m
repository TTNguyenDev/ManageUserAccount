//
//  ProfileViewController.m
//  Mioto_objc
//
//  Created by TT Nguyen on 12/4/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController () <FireBaseListener> {
    AccountBusiness *shareInstance;
    IBOutlet UIImageView *profileImage;
    IBOutlet UILabel *username;
    IBOutlet BlackLabel *gender;
    IBOutlet BlackLabel *dob;
    IBOutlet UILabel *joinedDate;
    
    IBOutlet UIImageView *phoneStatus_img;
    IBOutlet BlackLabel *phoneStatus_text;
    IBOutlet UIImageView *emailStatus_img;
    IBOutlet BlackLabel *emailStatus_text;
    IBOutlet UIImageView *fbStatus_img;
    IBOutlet UIButton *fbStatus_text;
    IBOutlet UIImageView *ggStatus_img;
    IBOutlet UIButton *ggStatus_text;
    
}


- (IBAction)logoutButton:(id)sender;
- (IBAction)fbLinking:(id)sender;
- (IBAction)ggLinking:(id)sender;
- (IBAction)editProfileButton:(id)sender;
@end

@implementation ProfileViewController

- (void)setupBorderForProfileImage {
    profileImage.layer.borderColor = [UIColor blackColor].CGColor;
    profileImage.layer.borderWidth = 2.0;
}

- (void)setupNaviBar {
    self.navigationItem.hidesBackButton = YES;
    self.title = @"Hồ Sơ";
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButtonItem;
    self.navigationItem.backBarButtonItem.tintColor = UIColor.whiteColor;
}

- (void)setupBarButton {
    UIBarButtonItem *Friends = [[UIBarButtonItem alloc]initWithTitle:@"Friends" style:UIBarButtonItemStylePlain target:self action:@selector(toggleSearch)];
    Friends.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = Friends;

}

-(void)toggleSearch {
    DisplayAllFriends *vc2 = [[DisplayAllFriends alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    shareInstance = [AccountBusiness sharedInstance];
    shareInstance.listener = self;
    [shareInstance fetchData];
    [self setupBorderForProfileImage];
    [self setupNaviBar];
    
    [profileImage setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapping:)];
    [singleTap setNumberOfTapsRequired:1];
    [profileImage addGestureRecognizer:singleTap];
    [self setupBarButton];
}

-(void)singleTapping:(UIGestureRecognizer *)recognizer {
    ViewProfileViewController *vc2 = [[ViewProfileViewController alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
}

- (void)profileDataRecieved:(int)status {
    Profile* user = [shareInstance getData];
    if ([[shareInstance getData] mUserImgUrl] != nil) {
        [profileImage sd_setImageWithURL: [NSURL URLWithString:[[shareInstance getData] mUserImgUrl]]];
    }
    
    username.text = user.mUserName;
    dob.text = user.mUserDateOfBirth;
    gender.text = user.mUserGender;
    joinedDate.text = [@"Ngày tham gia: " stringByAppendingString:user.mUserJoinedDate];
    
    if ([user.mUserPhone  isEqual: @"Chưa chọn"]) {
        phoneStatus_img.image = [UIImage imageNamed: @"WarningToSocial"];
        phoneStatus_text.text = @"Chưa xác thực";
    } else {
        phoneStatus_img.image = [UIImage imageNamed: @"linkedToSocial"];
        phoneStatus_text.text = @"Đã xác thực";
    }
    
    if (user.mUserEmail.length == 0) {
        emailStatus_img.image = [UIImage imageNamed: @"WarningToSocial"];
        emailStatus_text.text = @"Chưa xác thực";
    } else {
        emailStatus_img.image = [UIImage imageNamed: @"linkedToSocial"];
        emailStatus_text.text = @"Đã xác thực";
    }
    
    if ([user.mFBLinking  isEqual: @"false"]) {
        fbStatus_img.image = [UIImage imageNamed: @"WarningToSocial"];
        [fbStatus_text setTitle:@"Chưa xác thực" forState:UIControlStateNormal];
    } else {
        fbStatus_img.image = [UIImage imageNamed: @"linkedToSocial"];
        [fbStatus_text setTitle:@"Đã xác thực" forState:UIControlStateNormal];
    }
    
    
    //Default value
    
    if ([user.mEmailLinking  isEqual:  @"false"]) {
        ggStatus_img.image = [UIImage imageNamed: @"WarningToSocial"];
        [ggStatus_text setTitle:@"Chưa xác thực" forState:UIControlStateNormal];
    } else {
        ggStatus_img.image = [UIImage imageNamed: @"linkedToSocial"];
        [ggStatus_text setTitle:@"Đã xác thực" forState:UIControlStateNormal];
    }
}

- (void)LogOutStatus:(int)status {
    if (!status) {
        [AlertHelper showAlertWithMessage:@"Đăng xuất đang gặp vấn đề"];
    } else {
        Menu_1_ViewController *vc2 = [[Menu_1_ViewController alloc] init];
        [self.navigationController pushViewController:vc2 animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    self .navigationController.navigationBarHidden = false;
    [super viewWillAppear:true];
}

- (IBAction)logoutButton:(id)sender {
    [shareInstance logout];
}

- (IBAction)fbLinking:(id)sender {
    [shareInstance fbLinking];
}

- (IBAction)ggLinking:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Liên kết với tài khoản email"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.keyboardType = UIKeyboardTypeAlphabet;
        textField.secureTextEntry = true;
        textField.placeholder = @"Nhập vào mật khẩu";
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Hoàn tất"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         UITextField *textField = [alert.textFields firstObject];
                                                         NSLog(@"password %@", textField.text);
                                                         if (textField.text.length != 0) {
                                                             [self->shareInstance emailLinking:textField.text];
                                                         }
                                                     }];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)LinkingGGStatus:(int)status {
    if (status) {
        [AlertHelper showAlertWithMessage:@"Liên kết thành công"];
        ggStatus_img.image = [UIImage imageNamed: @"linkedToSocial"];
        [ggStatus_text setTitle:@"Đã xác thực" forState:UIControlStateNormal];
    } else {
        [AlertHelper showAlertWithMessage:@"Liên kết đã xảy ra lỗi"];
    }
}

- (void)LinkingFBStatus:(int)status {
    if (status) {
        [AlertHelper showAlertWithMessage:@"Liên kết thành công"];
        fbStatus_img.image = [UIImage imageNamed: @"linkedToSocial"];
        [fbStatus_text setTitle:@"Đã xác thực" forState:UIControlStateNormal];
    } else {
        [AlertHelper showAlertWithMessage:@"Liên kết đã xảy ra lỗi"];
    }
}

- (IBAction)editProfileButton:(id)sender {
    EditProfileViewViewController *vc2 = [[EditProfileViewViewController alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
}
@end
