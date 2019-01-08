//
//  EditProfileViewViewController.m
//  Mioto_objc
//
//  Created by TT Nguyen on 12/14/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import "EditProfileViewViewController.h"

@interface EditProfileViewViewController () <FireBaseListener> {
    UIDatePicker *datePicker;
    PickerView *genderPicker;
    AccountBusiness *shareInstance;
    NSMutableArray *genderArray;
    IBOutlet UITextField *mName;
    IBOutlet UITextField *mDob;
    IBOutlet UITextField *mGender;
    IBOutlet UITextField *mPhoneNumber;
}
- (IBAction)updateData:(id)sender;


@end

@implementation EditProfileViewViewController


- (void)setupNavigationBar {
    self.title = @"Chỉnh Sửa Hồ Sơ";
}

- (void)setupDatePicker {
    datePicker = [UIDatePicker new];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action: @selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    
    mDob.inputView = datePicker;
}

- (void)setupGenderPicker {
    genderArray = [NSMutableArray new];
    [genderArray addObject:@"Nam"];
    [genderArray addObject:@"Nữ"];
    genderPicker = [PickerView new];
    genderPicker.listener = self;
    [genderPicker pickerViewWithArray:genderArray View:mGender];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    shareInstance = [AccountBusiness sharedInstance];
    shareInstance.listener = self;
    [shareInstance fetchData];
    
    [self setupNavigationBar];
    [self setupDatePicker];
    [self setupGenderPicker];
}

- (void)profileDataRecieved:(int)status {
    if (status) {
        Profile *userInfo = [shareInstance getData];
        mName.text = userInfo.mUserName;
        mPhoneNumber.text = userInfo.mUserPhone;
        mDob.text = userInfo.mUserDateOfBirth;
        mGender.text = userInfo.mUserGender;
    } else {
        printf("status");
    }
}

- (void)didSelectedRowAtIndexpath:(int)indexpath {
    mGender.text = genderArray[indexpath];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}

-(void)dateChanged {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    mDob.text = [dateFormatter stringFromDate:datePicker.date];
}

- (IBAction)updateData:(id)sender {
    [shareInstance updateDataWithName:mName.text dob:mDob.text gender:mGender.text imgURL: @"" phoneNumber: mPhoneNumber.text];
    ProfileViewController *vc2 = [[ProfileViewController alloc] init];
    [self.navigationController pushViewController:vc2 animated:YES];
}
@end


