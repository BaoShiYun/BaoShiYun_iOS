//
//  FavorEmitterItem.h
//  BSYLive
//
//  Created by Duane on 2020/4/23.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface FavorEmitterItem : CALayer

/// 左右飘动的周期
@property (nonatomic, assign) CGFloat shiftCycle;
/// 到达顶部的时间
@property (nonatomic, assign) CGFloat risingDuration;
/// 元素上升的最小速度
@property (nonatomic, assign) CGFloat minRisingVelocity;
/// 到达顶部的时间差量
@property (nonatomic, assign) CGFloat risingShiftDuration;
/// 完全消失的时间
@property (nonatomic, assign) CGFloat fadeOutDuration;
/// 完全消失的时间差量
@property (nonatomic, assign) CGFloat fadeOutShiftDuration;

/**
 初始化发射元素

 @param frame     元素frame
 @param floatArea 飘浮范围
 @param image     元素图片

 @return 发射元素
 */
+ (instancetype)emitterWithFrame:(CGRect)frame floatArea:(CGRect)floatArea image:(UIImage *)image;

- (void)startAnimation;

@end

NS_ASSUME_NONNULL_END
