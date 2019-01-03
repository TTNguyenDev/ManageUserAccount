//
//  PickerView.h
//  Mioto_objc
//
//  Created by TT Nguyen on 12/14/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PickerView;

@protocol PickerViewListener
- (void)didSelectedRowAtIndexpath:(int)indexpath;
@end

@interface PickerView : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate> {
}

- (void)pickerViewWithArray: (NSMutableArray*)array View:(UITextField*)textfield;

@property (nonatomic, weak) id<PickerViewListener> listener;
@end

NS_ASSUME_NONNULL_END
