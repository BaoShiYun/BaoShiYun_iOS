//
//  BSYLiveParam.h
//  BSYLiveSDK
//
//  Created by zddMac on 2020/11/12.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveParam : NSObject

@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *nickName;
@property (nonatomic, copy)NSString *avatarUrl;
@property (nonatomic, copy)NSString *liveId;
@property (nonatomic, copy)NSString *enterCode;

@end

NS_ASSUME_NONNULL_END
