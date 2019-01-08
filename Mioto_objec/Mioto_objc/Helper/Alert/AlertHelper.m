//
//  AlertHelper.m
//  Mioto_objc
//
//  Created by TT Nguyen on 12/12/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import "AlertHelper.h"

@implementation AlertHelper

+ (void)showAlertWithMessage: (NSString*)mess {
    MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
    message.text = mess;
    [MDCSnackbarManager showMessage:message];
    MDCSnackbarManager.messageTextColor = UIColor.blackColor;
    MDCSnackbarManager.snackbarMessageViewBackgroundColor = UIColor.whiteColor;
    MDCSnackbarManager.messageFont = [UIFont systemFontOfSize:18];
}

@end
