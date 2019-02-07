//
//  ViewProfileViewController.m
//  Mioto_objc
//
//  Created by TT Nguyen on 12/22/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import "ViewProfileViewController.h"

@interface ViewProfileViewController () <FireBaseListener> {
    IBOutlet UIImageView *prorfileImage;
    AccountBusiness *shareInstance;
    
}
- (IBAction)changeProfileImageButton:(id)sender;

@end

@implementation ViewProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sửa ảnh đại diện";
    
    shareInstance = [AccountBusiness sharedInstance];
    shareInstance.listener = self;
    
    if ([[shareInstance getData] mUserImgUrl] != nil) {
        [prorfileImage sd_setImageWithURL: [NSURL URLWithString:[[shareInstance getData] mUserImgUrl]]];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [shareInstance UploadProfileImage:chosenImage];
    prorfileImage.image = chosenImage;
    [AlertHelper showLoading];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}

- (void)UploadProfileImageStatus:(int)status {
    if (status) {
        [AlertHelper loadingFinished];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [AlertHelper showAlertWithMessage: @"Chỉnh sửa hình thành công"];
        [UIView animateWithDuration:1 delay:0 options:(UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            double delayInSeconds = 1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                ProfileViewController *vc2 = [[ProfileViewController alloc] init];
                [self.navigationController pushViewController: vc2 animated:true];
            });
        }completion:^(BOOL finished){
        }];
    }
    else {
        [AlertHelper showAlertWithMessage: @"Đã có lỗi xảy ra, vui lòng thử lại sau"];
    }
}

- (IBAction)changeProfileImageButton:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}
@end
