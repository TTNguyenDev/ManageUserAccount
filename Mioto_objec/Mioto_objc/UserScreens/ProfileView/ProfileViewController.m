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
    IBOutlet BlackLabel *fbStatus_text;
    IBOutlet UIImageView *ggStatus_img;
    IBOutlet BlackLabel *ggStatus_text;
}
- (IBAction)logoutButton:(id)sender;
- (IBAction)fbLinking:(id)sender;
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
    
    if (user.mUserPhone.length == 0) {
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
    
    //Default value
    fbStatus_img.image = [UIImage imageNamed: @"WarningToSocial"];
    fbStatus_text.text = @"Chưa xác thực";
    
    ggStatus_img.image = [UIImage imageNamed: @"WarningToSocial"];
    ggStatus_text.text = @"Chưa xác thực";
}

- (void)AuthStatus:(int)status {
    if (!status) {
        [AlertHelper showAlertWithMessage:@"Đăng xuất đăng gặp vấn đề"];
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

- (IBAction)editProfileButton:(id)sender {
    EditProfileViewViewController *vc2 = [[EditProfileViewViewController alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
}
@end
