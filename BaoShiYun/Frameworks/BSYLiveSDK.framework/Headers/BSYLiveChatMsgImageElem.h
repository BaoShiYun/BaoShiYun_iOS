//
//  BSYLiveChatMsgImageElem.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/17.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 图片消息体
 */

@interface BSYLiveChatMsgImageElem : NSObject

/**
 *   @brief  图片格式 JPG=1, Gif=2, PNG=3, BMP=4, 其他=255
 */
@property (nonatomic, strong, readonly)NSString *imageFormat;

/**
 *   @brief  原图大小
 */
@property (nonatomic, assign, readonly)NSUInteger orgSize;

/**
 *   @brief  原图宽
 */
@property (nonatomic, assign, readonly)NSUInteger orgWidth;

/**
 *   @brief  原图高
 */
@property (nonatomic, assign, readonly)NSUInteger orgHeight;

/**
 *   @brief  原图URL
 */
@property (nonatomic, strong, readonly)NSString *orgURL;

/**
 *   @brief  缩略大小
 */
@property (nonatomic, assign, readonly)NSUInteger thumbSize;

/**
 *   @brief  缩略图宽
 */
@property (nonatomic, assign, readonly)NSUInteger thumbWidth;

/**
 *   @brief  缩略图高
 */
@property (nonatomic, assign, readonly)NSUInteger thumbHeight;

/**
 *   @brief  缩略图URL
 */
@property (nonatomic, strong, readonly)NSString *thumbURL;

@end

NS_ASSUME_NONNULL_END
