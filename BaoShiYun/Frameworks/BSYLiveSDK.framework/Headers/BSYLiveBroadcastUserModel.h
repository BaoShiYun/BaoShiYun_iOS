//
//  BSYLiveBroadcastUserModel.h
//  BSYLiveSDK
//
//  Created by zddMac on 2021/3/3.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveBroadcastUserModel : NSObject

@property (nonatomic, strong)NSString *userId; ///用户ID
@property (nonatomic, strong)NSString *nickName; ///昵称
@property (nonatomic, strong)NSString *avatarUrl; ///头像地址
@property (nonatomic, assign)BOOL videoMute; ///视频开启或关闭
@property (nonatomic, assign)BOOL audioMute; ///麦克风开启或关闭

@end

NS_ASSUME_NONNULL_END
