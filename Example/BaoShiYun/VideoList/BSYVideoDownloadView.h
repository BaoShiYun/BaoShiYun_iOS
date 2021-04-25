//
//  BSYVideoDownloadView.h
//  BaoShiYun
//
//  Created by zddMac on 2021/4/25.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYVideoDownloadView : UIButton

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *label;

- (void)showAnimation:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
