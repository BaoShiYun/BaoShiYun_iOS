//
//  BSYLiveKitDefine.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/18.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSYLiveChatMsgModel;
@class BSYLiveQuestionModel;
@class BSYLiveRedPackageModel;
/// 成功通用回调
typedef void (^BSYLiveKitSuccess)(void);
/// 失败通用回调
typedef void (^BSYLiveKitFail)(NSInteger code, NSString * desc);

/// 成功通用回调
typedef void (^BSYLiveKitIMGetMsgSuccess)(NSArray<BSYLiveChatMsgModel *> *msgList);

//成功回调评测列表
typedef void (^BSYLiveKitQuestionListSuccess)(NSArray<BSYLiveQuestionModel *> *questionList);

//评测Token回调
typedef void (^BSYLiveKitQuestionTokenSuccess)(NSString *token);


//成功回调活动列表
typedef void (^BSYLiveKitActivityListSuccess)(NSArray<BSYLiveRedPackageModel *> *redPackageList);
