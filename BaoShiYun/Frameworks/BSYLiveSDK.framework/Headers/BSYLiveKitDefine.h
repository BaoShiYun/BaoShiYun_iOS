//
//  BSYLiveKitDefine.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/18.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
  常用类型定义
 */

@class BSYLiveChatMsgModel;
@class BSYLiveQuestionModel;
@class BSYLiveRedPackageModel;


/**
 * @brief 成功通用回调
 */
typedef void (^BSYLiveKitSuccess)(void);

/**
 * @brief 失败通用回调，code：错误码   desc：错误描述
 */
typedef void (^BSYLiveKitFail)(NSInteger code, NSString * desc);

/**
 * @brief 聊天记录列表成功回调，请参考：BSYLiveChatMsgModel
 */
typedef void (^BSYLiveKitIMGetMsgSuccess)(NSArray<BSYLiveChatMsgModel *> *msgList);

/**
 * @brief 评测列表成功回调，请参考：BSYLiveQuestionModel
 */
typedef void (^BSYLiveKitQuestionListSuccess)(NSArray<BSYLiveQuestionModel *> *questionList);

/**
 * @brief 评测Token成功回调
 */
typedef void (^BSYLiveKitQuestionTokenSuccess)(NSString *token);

/**
 * @brief 活动列表成功回调，请参考：BSYLiveRedPackageModel
 */
typedef void (^BSYLiveKitActivityListSuccess)(NSArray<BSYLiveRedPackageModel *> *redPackageList);



/**
 互动直播类型
 */
typedef NS_ENUM(NSUInteger, BSYLiveInteractiveType) {
    /**
     * 不允许学生互动连麦
     */
    BSYLiveInteractiveType_None=1, //不允许学生互动连麦
    /**
     * 允许音视频连麦
     */
    BSYLiveInteractiveType_VideoAndAudio=2, //允许音视频连麦
    /**
     * 允许语音连麦
     */
    BSYLiveInteractiveType_Audio=3,//允许语音连麦
};


/**
 互动状态原因类型
 */
typedef NS_ENUM(NSUInteger, BSYLiveInteractiveStatusReasonType) {
    /**
     * 无原因
     */
    BSYLiveInteractiveStatusReasonType_None=0, //无原因
    /**
     * 当前用户自己确认
     */
    BSYLiveInteractiveStatusReasonType_SelfConfirm=1, //当前用户自己确认
    /**
     * 老师确认
     */
    BSYLiveInteractiveStatusReasonType_TeacherConfirm=2, //老师确认
    /**
     * 用户异常退出程序为下席位，从新连接上上麦
     */
    BSYLiveInteractiveStatusReasonType_Reconnect=1, //用户异常退出程序为下席位，从新连接上上麦
    /**
     * 当前用户主动取消
     */
    BSYLiveInteractiveStatusReasonType_SelfCancel=3, //当前用户主动取消
    /**
     * 老师移除
     */
    BSYLiveInteractiveStatusReasonType_TeacherCancel=4,//老师移除
};
