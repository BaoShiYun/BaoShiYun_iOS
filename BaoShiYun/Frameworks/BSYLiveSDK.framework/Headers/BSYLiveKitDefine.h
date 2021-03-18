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


typedef NS_ENUM(NSUInteger, BSYLiveInteractiveType) {
    
    BSYLiveInteractiveType_None=1, //不允许学生互动连麦
    BSYLiveInteractiveType_VideoAndAudio=2, //允许音视频连麦
    BSYLiveInteractiveType_Audio=3,//允许语音连麦
};

typedef NS_ENUM(NSUInteger, BSYLiveInteractiveStatusReasonType) {
    
    BSYLiveInteractiveStatusReasonType_None=0, //无原因
    BSYLiveInteractiveStatusReasonType_SelfConfirm=1, //当前用户自己确认
    BSYLiveInteractiveStatusReasonType_TeacherConfirm=2, //老师确认
    BSYLiveInteractiveStatusReasonType_Reconnect=1, //用户异常退出程序为下席位，从新连接上上麦
    BSYLiveInteractiveStatusReasonType_SelfCancel=3, //当前用户主动取消
    BSYLiveInteractiveStatusReasonType_TeacherCancel=4,//老师移除
};
