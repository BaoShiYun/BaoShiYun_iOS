//
//  BSYLiveCustomGroupMsgModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2021/11/2.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
  自定义消息体
 */

@interface BSYLiveCustomGroupMsgModel : NSObject


/**
 *   @brief  自定义信息内容
 */
@property (nonatomic, strong, readonly)NSString *content;

/**
 *   @brief  是否是系统通知  Yes:为群系统通知   NO:为自定义群消息
 */
@property (nonatomic, assign, readonly)BOOL isSystem;

@end

NS_ASSUME_NONNULL_END
