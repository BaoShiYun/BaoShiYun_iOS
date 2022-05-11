//
//  BSYPlayInfo.h
//  BSYunVod
//
//  Created by Duane on 2020/10/27.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BSYVodVideoModel;

typedef void (^BSPlayInfoErrorBlock)(NSError *error);
typedef void (^BSPlayInfoFinishBlock)(BSYVodVideoModel * vodVideo);

@interface BSYPlayInfo : NSObject

/**
 *  @brief 请求超时时间，默认10s
 */
@property(assign, nonatomic)NSTimeInterval timeoutSeconds;

/**
 *  @brief 请求失败回调
 */
@property(copy, nonatomic)BSPlayInfoErrorBlock errorBlock;

/**
 *  @brief 默认清晰度，默认值：lhd ( lsd-超清  lhd-高清  lud-清晰)
 */
@property(copy, nonatomic)NSString *resolution;

/**
 *  @brief 请求完成回调
 */
@property(copy, nonatomic)BSPlayInfoFinishBlock finishBlock;

/*!
 * @method
 * @abstract 初始化方法
 * @discussion 初始化方法
 * @param media 请求媒资输入
 * @result BSPlayInfo对象
 */
-(id)initWithMedia:(BSYVodMediaRequest *)media;

/*!
 * @method
 * @abstract 开始获取视频数据
 * @discussion 开始获取视频数据
 */
-(void)start;

/*!
 * @method
 * @abstract 取消获取视频数据
 * @discussion 取消之后，不会调用errorBlock或finishBlock
 */
-(void)cancel;

@end

NS_ASSUME_NONNULL_END
