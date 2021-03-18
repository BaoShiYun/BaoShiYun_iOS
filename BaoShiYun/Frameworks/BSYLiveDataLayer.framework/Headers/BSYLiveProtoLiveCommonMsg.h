//
//  BSYLiveProtoLiveCommonMsg.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2021/3/4.
//  Copyright © 2021 zddMac. All rights reserved.
//

#import <BSYLiveDataLayer/BSYLiveDataLayer.h>

@class BSYLiveCommonMsgDetailModel;
NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveProtoLiveCommonMsg : BSYLiveProtoBaseModel
@property (nonatomic, strong)NSString *timGroupId;  //群id
@property (nonatomic, strong)NSString *accountId;  //群id
@property (nonatomic, strong)BSYLiveCommonMsgDetailModel *params; //相匹配的数据结构

@end

NS_ASSUME_NONNULL_END
