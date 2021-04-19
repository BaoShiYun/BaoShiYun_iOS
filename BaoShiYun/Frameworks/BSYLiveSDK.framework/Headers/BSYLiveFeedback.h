//
//  BSYLiveFeedback.h
//  BSYLiveSDK
//
//  Created by zddMac on 2021/4/19.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveFeedback : NSObject

/**
 *   @brief   获取红包列表
 *   @param   content 反馈文本内容
 *   @param   userId  用户ID
 *   @param   liveId  直播id
 *   @param   liveName 直播名
 *   @param   succ 成功回调
 *   @param   fail 失败回调
 */
+ (void)sendLiveFeedbackWithContent:(NSString *)content withUserId:(NSString *)userId withLiveId:(NSString *)liveId withLiveName:(NSString *)liveName succ:(BSYLiveKitSuccess)succ fail:(BSYLiveKitFail __nullable)fail;

@end

NS_ASSUME_NONNULL_END
