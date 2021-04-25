//
//  BSYDownloadProgressView.h
//  BaoShiYun
//
//  Created by zddMac on 2021/4/22.
//  Copyright © 2021 duanguangming@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYDownloadProgressView : UIView

+ (CGFloat)viewHeight;
- (void)setFileSize:(NSUInteger)fileSize;
- (void)updateState:(BSYDownloadState)state withSpeed:(NSUInteger)speed withUpdateProgress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
