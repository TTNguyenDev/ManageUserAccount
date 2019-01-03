//
//  PickerView.m
//  Mioto_objc
//
//  Created by TT Nguyen on 12/14/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import "PickerView.h"

@interface PickerView () {
    NSMutableArray *mArray;
}

@end
@implementation PickerView


- (void)pickerViewWithArray: (NSMutableArray*)array View:(UITextField*)textfield {
    
    UIPickerView* objPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, textfield.inputView.frame.size.height)];
    objPickerView.delegate = self;
    objPickerView.dataSource = self;
    
    textfield.inputView = objPickerView;    
    mArray = array;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component {
    return mArray.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return mArray[row];
}

- (void)pickerView:(UIPickerView *)thePickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    if (self.listener) {
        [self.listener didSelectedRowAtIndexpath:row];
    }
}
@end
