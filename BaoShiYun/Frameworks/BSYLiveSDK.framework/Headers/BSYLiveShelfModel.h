//
//  BSYLiveShelfModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/18.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
  货架的呈现类型
 */
typedef NS_ENUM(NSUInteger, BSYLiveShelfEntranceType) {
    /**
     * 无商品信息
     */
    BSYLiveShelfEntranceType_None = 0,
    
    /**
     * 文字
     */
    BSYLiveShelfEntranceType_Text = 1,
    
    /**
     * 图片
     */
    BSYLiveShelfEntranceType_Pic = 2,
    
};


/**
  货架的呈现方式
 */
typedef NS_ENUM(NSUInteger, BSYLiveShelfShowWay) {
    
    /**
     * 不展示
     */
    BSYLiveShelfShowWay_None = 0,
    
    /**
     * 悬浮窗
     */
    BSYLiveShelfShowWay_Pop = 1,
    
    /**
     * 页面
     */
    BSYLiveShelfShowWay_Page = 2,
};




NS_ASSUME_NONNULL_BEGIN

/**
  直播货架内容
 */
@interface BSYLiveShelfModel : NSObject

/**
 *   @brief  货架所在群组id
 */
@property (nonatomic, assign, readonly)uint64_t groupId;

/**
 *   @brief  货架id
 */
@property (nonatomic, strong, readonly)NSString *shelfId;

/**
 *   @brief  货架名
 */
@property (nonatomic, strong, readonly)NSString *title;

/**
 *   @brief  货架链接地址
 */
@property (nonatomic, strong, readonly)NSString *actionUrl;

/**
 *   @brief  呈现方式
 *   @see BSYLiveShelfShowWay
 */
@property (nonatomic, assign, readonly)BSYLiveShelfShowWay showWay;

/**
 *   @brief  内容类型 图片或者文字
 *   @see BSYLiveShelfEntranceType
 */
@property (nonatomic, assign, readonly)BSYLiveShelfEntranceType entranceStyle;

/**
 *   @brief 文字内容或图片链接
 */
@property (nonatomic, strong, readonly)NSString *entranceContent;

@end

NS_ASSUME_NONNULL_END
