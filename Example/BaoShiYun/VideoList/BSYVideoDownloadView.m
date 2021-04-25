//
//  BSYVideoDownloadView.m
//  BaoShiYun
//
//  Created by zddMac on 2021/4/25.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import "BSYVideoDownloadView.h"

@implementation BSYVideoDownloadView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    self.icon = [[UIImageView alloc] init];
    self.icon.contentMode = UIViewContentModeCenter;
    [self addSubview:self.icon];

    self.label = [[UILabel alloc] init];
    self.label.font = [UIFont boldSystemFontOfSize:8];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = HexColor(0xAAAAAA);
    [self addSubview:self.label];
}

- (void)updateConstraints {
    [super updateConstraints];
    
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.mas_equalTo(self);
        make.left.mas_greaterThanOrEqualTo(self);
        make.right.mas_lessThanOrEqualTo(self);
    }];
    [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.mas_equalTo(self);
        make.left.mas_greaterThanOrEqualTo(self);
        make.right.mas_lessThanOrEqualTo(self);
        make.top.mas_equalTo(self.icon.mas_top).mas_offset(self.icon.image.size.height+3);
    }];
}

- (void)showAnimation:(BOOL)animated {
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self);
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        [self layoutIfNeeded];
        [self.icon.layer removeAllAnimations];
        if (animated) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            animation.fromValue = @(0);
            animation.toValue = @(2*M_PI);
            animation.duration = 1;
            animation.repeatCount = UINT64_MAX;
            animation.removedOnCompletion = NO;
            [self.icon.layer addAnimation:animation forKey:@"rotationAnimation"];
        } else {
            self.icon.layer.transform = CATransform3DIdentity;
        }
    });
    
    
}

@end
