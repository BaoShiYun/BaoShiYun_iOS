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
 - BSYLiveShelfEntranceType_None: 无
 - BSYLiveShelfEntranceType_Text: 文字
 - BSYLiveShelfEntranceType_Pic: 图片
 */
typedef NS_ENUM(NSUInteger, BSYLiveShelfEntranceType) {
    BSYLiveShelfEntranceType_None = 0, ///无商品信息
    BSYLiveShelfEntranceType_Text = 1, ///文字
    BSYLiveShelfEntranceType_Pic = 2, ///图片
    
};

/**
  货架的呈现类型
 - BSYLiveShelfShowWay_None: 无
 - BSYLiveShelfShowWay_Pop: 悬浮窗
 - BSYLiveShelfShowWay_Page: 页面
 */
typedef NS_ENUM(NSUInteger, BSYLiveShelfShowWay) {
    BSYLiveShelfShowWay_None = 0,
    BSYLiveShelfShowWay_Pop = 1,
    BSYLiveShelfShowWay_Page = 2,
};


NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveShelfModel : NSObject

@property (nonatomic, assign, readonly)uint64_t groupId; ///货架所在群组id
@property (nonatomic, strong, readonly)NSString *shelfId; ///货架id
@property (nonatomic, strong, readonly)NSString *title;   ///货架名
@property (nonatomic, strong, readonly)NSString *actionUrl; ///货架链接地址
@property (nonatomic, assign, readonly)BSYLiveShelfShowWay showWay;
@property (nonatomic, assign, readonly)BSYLiveShelfEntranceType entranceStyle; //文字/图片
@property (nonatomic, strong, readonly)NSString *entranceContent;  ///文字内容/或图片链接

@end

NS_ASSUME_NONNULL_END
