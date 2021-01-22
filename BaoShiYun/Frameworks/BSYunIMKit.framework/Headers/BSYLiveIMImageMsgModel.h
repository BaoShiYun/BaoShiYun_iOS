//
//  BSYLiveIMImageMsgModel.h
//  BSYunIMKit
//
//  Created by zddMac on 2020/11/6.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveImageInfoModel;
@interface BSYLiveIMImageMsgModel : NSObject
@property (nonatomic, strong)NSString *uid; //用户ID
@property (nonatomic, strong)NSString *nickName; //昵称
@property (nonatomic, strong)NSString *avatarUrl; //头像地址
@property (nonatomic, strong)BSYLiveImageInfoModel *image; //图片
@property (nonatomic, assign)uint64_t timestamp; //时间戳

@end

NS_ASSUME_NONNULL_END
