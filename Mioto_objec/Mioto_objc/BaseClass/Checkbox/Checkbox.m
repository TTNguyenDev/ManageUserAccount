//
//  CheckBox.m
//  Mioto_objc
//
//  Created by TT Nguyen on 11/28/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import "CheckBox.h"

@interface CheckBox() {
    bool mIsCheck;
    UIButton *mCheckButton;
}
@end

@implementation CheckBox

@synthesize isCheck = mIsCheck;

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self didInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self didInit];
    }
    return self;
}

- (void) didInit {
    mCheckButton = [UIButton new];
    [self addSubview:mCheckButton];
    self.backgroundColor = [UIColor clearColor];
    mCheckButton.translatesAutoresizingMaskIntoConstraints = false;
    
    [mCheckButton.topAnchor constraintEqualToAnchor:mCheckButton.superview.topAnchor].active = true;
    [mCheckButton.bottomAnchor constraintEqualToAnchor:mCheckButton.superview.bottomAnchor].active = true;
    [mCheckButton.leadingAnchor constraintEqualToAnchor:mCheckButton.superview.leadingAnchor].active = true;
    [mCheckButton.trailingAnchor constraintEqualToAnchor:mCheckButton.superview.trailingAnchor].active = true;
    
    [self setIsCheck:false];
    [mCheckButton addTarget:self action: @selector(handleTouchUpInside) forControlEvents: UIControlEventTouchUpInside];
}

- (void)handleTouchUpInside {
    [self setIsCheck: !mIsCheck];
}

- (void)setIsCheck:(bool)isCheck {
    mIsCheck = isCheck;
    if (isCheck) {
        [mCheckButton setImage: [UIImage imageNamed:@"checked"] forState: UIControlStateNormal];
    } else {
        [mCheckButton setImage: [UIImage imageNamed:@"uncheck"] forState: UIControlStateNormal];
    }
    
    if (self.listener) {
        [self.listener checkBoxValueDidChanged: mIsCheck];
    }
}
    @end
