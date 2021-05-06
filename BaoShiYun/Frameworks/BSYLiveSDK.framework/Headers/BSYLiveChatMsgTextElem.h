//
//  BSYLiveChatMsgTextElem.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/17.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
  文本消息体
 */
@interface BSYLiveChatMsgTextElem : NSObject

/**
 *   @brief  文本消息内容
 */
@property (nonatomic, strong, readonly)NSString *message;

@end

NS_ASSUME_NONNULL_END
