//
//  FavorEmitter.h
//  BSYLive
//
//  Created by Duane on 2020/4/23.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef BOOL (^EmitterTapHandler) (void);

@interface FavorEmitter : UIView

/// 粒子发射器点击时的默认操作
@property (copy, nonatomic) EmitterTapHandler tapHandler;
/// 是否响应点击事件，默认为YES
@property (nonatomic, assign) BOOL interactEnabled;
/// 粒子展示的窗口
@property (nonatomic, weak) UIView *favorDisplayView;

#pragma mark - item property

/// 元素图片
@property (nonatomic, strong) NSArray<UIImage *> *itemImages;

/// 出生点位，在粒子发射器中点和顶点之间为0~1的小数，1为顶点，0为中点
@property (nonatomic, assign) CGFloat originRange;

/// 元素大小为0.2~1.5之间的数，默认为1
@property (nonatomic, assign) CGFloat scale;

/// 元素左右移动的追加范围为10~100之间的数，默认为10
@property (nonatomic, assign) CGFloat extraShift;

/// 在 favorDisplayView 中能上升到的y轴坐标值,默认为0
@property (nonatomic, assign) CGFloat risingY;

/// 元素上升的最小速度为20~100之间的数，默认为30
@property (nonatomic, assign) CGFloat minRisingVelocity;

/// 左右飘动的周期，1~8之间的数，默认为5
@property (nonatomic, assign) CGFloat shiftCycle;

/// 到达顶部的时间，1~12之间的数，默认为10
@property (nonatomic, assign) CGFloat risingDuration;

/// 到达顶部的时间差量，1~4之间的数，默认为2
@property (nonatomic, assign) CGFloat risingShiftDuration;

/// 完全消失的时间，1~10之间的数，默认为6
@property (nonatomic, assign) CGFloat fadeOutDuration;

/// 完全消失的时间差量，1~3之间的数，默认为2
@property (nonatomic, assign) CGFloat fadeOutShiftDuration;

/**
 初始化粒子发射器

 @param image           粒子发射器的图片
 @param hightlightImage 粒子发射器的高亮图片

 @return 粒子发射器
 */
+ (instancetype)emitterWithImage:(nullable UIImage *)image highlightImage:(nullable UIImage *)hightlightImage;

/**
 释放元素

 @param count 元素数量
 @param duration 发射总时间
 */
- (void)generateEmitterItemsForItemsCount:(int)count duration:(NSTimeInterval)duration;

/**
设置显示点赞总数量

@param likeCount 点赞总数量
*/
- (void)updateLikeLabelCount:(NSUInteger)likeCount;

@end

NS_ASSUME_NONNULL_END
