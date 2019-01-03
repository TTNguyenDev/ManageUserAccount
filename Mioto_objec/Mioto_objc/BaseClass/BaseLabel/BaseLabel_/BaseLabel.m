//
//  BaseLabel.m
//  Mioto_objc
//
//  Created by TT Nguyen on 11/28/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

#import "BaseLabel.h"

@implementation BaseLabel

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self Initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self Initialize];
    }
    return self;
}

-(void)Initialize {
    self .font = [UIFont systemFontOfSize:20];
}

@end
