//
//  InsetsLabel.h
//  EagleApp
//
//  Created by duane on 2017/8/26.
//  Copyright © 2017年 duane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsetsLabel : UILabel
@property(nonatomic) UIEdgeInsets insets;

- (id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets;
- (id)initWithInsets:(UIEdgeInsets)insets;

@end
