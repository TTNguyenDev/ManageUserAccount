//
//  AlertHelper.h
//  Mioto_objc
//
//  Created by TT Nguyen on 12/12/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MaterialSnackbar.h"
#import "SVProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@class AlertHelper;

@interface AlertHelper : NSObject

+ (void)showLoading;
+ (void)loadingFinished;
+ (void)showAlertWithMessage: (NSString*)mess;
@end

NS_ASSUME_NONNULL_END
