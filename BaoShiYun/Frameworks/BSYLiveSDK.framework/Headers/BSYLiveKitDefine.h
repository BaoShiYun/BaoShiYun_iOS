//
//  BSYLiveKitDefine.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/18.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSYLiveChatMsgModel;
/// 成功通用回调
typedef void (^BSYLiveKitSuccess)(void);
/// 失败通用回调
typedef void (^BSYLiveKitFail)(NSInteger code, NSString * desc);

/// 成功通用回调
typedef void (^BSYLiveKitIMGetMsgSuccess)(NSArray<BSYLiveChatMsgModel *> *msgList);
