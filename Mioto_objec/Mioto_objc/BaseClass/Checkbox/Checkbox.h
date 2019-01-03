//
//  CheckBox.h
//  Mioto_objc
//
//  Created by TT Nguyen on 11/28/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CheckBox;
@protocol CheckBoxListener

- (void)checkBoxValueDidChanged:(bool)value;

@end

@interface CheckBox : UIButton

@property (nonatomic, assign) bool isCheck;
@property (nonatomic, weak) id<CheckBoxListener> listener;

@end

NS_ASSUME_NONNULL_END
