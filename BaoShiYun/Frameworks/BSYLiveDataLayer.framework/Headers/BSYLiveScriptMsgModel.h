//
//  BSYLiveScriptMsgModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveScriptMsgModel : BSYMediaModel

@property (nonatomic, strong)NSString *uid; //用户ID
@property (nonatomic, strong)NSString *nickName; //昵称
@property (nonatomic, strong)NSString *avatarUrl; //头像地址
@property (nonatomic, strong)NSString *message; //文本消息
@property (nonatomic, assign)uint64_t timestamp; //时间戳

@property (nonatomic, assign)NSTimeInterval triggerTime; //触发时间 单位:毫秒
@property (nonatomic, assign)NSTimeInterval lastPlayedTime; //已播放时长, 单位:毫秒

@end

NS_ASSUME_NONNULL_END
