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
 *  @brief 请求完成回调
 */
@property(copy, nonatomic)BSPlayInfoFinishBlock finishBlock;

/*!
 * @method
 * @abstract 初始化方法
 * @discussion 初始化方法
 * @param mediaId 媒资ID
 * @result BSPlayInfo对象
 */
-(id)initWithMediaId:(NSString *)mediaId;

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
