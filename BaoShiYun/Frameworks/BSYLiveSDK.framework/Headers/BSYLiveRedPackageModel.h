//
//  BSYLiveRedPackageModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveRedPackageExtModel;

/**
 口令红包内容
 */
@interface BSYLiveRedPackageModel : NSObject

/**
 *   @brief  活动id
 */
@property (nonatomic, assign) uint64_t activityId; // 22,

/**
 *   @brief  红包名称
 */
@property (nonatomic, strong) NSString *name; // "测试口令",

/**
 *   @brief  红包展示页面地址   请参考：BSYLiveRedPackageExtModel
 */
@property (nonatomic, strong) BSYLiveRedPackageExtModel *ext;

@end

/**
 口令红包页面地址
 */
@interface BSYLiveRedPackageExtModel : NSObject

/**
 *   @brief  PC端地址
 */
@property (nonatomic, strong) NSString *webUrl; // "https://www.baidu.com",

/**
 *   @brief  移动端地址
 */
@property (nonatomic, strong) NSString *mobileUrl; // "https://www.baoshiyun.com"

@end

NS_ASSUME_NONNULL_END
