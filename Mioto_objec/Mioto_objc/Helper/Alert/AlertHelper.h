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

NS_ASSUME_NONNULL_BEGIN

@class AlertHelper;

@interface AlertHelper : NSObject


+ (void)showAlertWithMessage: (NSString*)mess;
@end

NS_ASSUME_NONNULL_END
