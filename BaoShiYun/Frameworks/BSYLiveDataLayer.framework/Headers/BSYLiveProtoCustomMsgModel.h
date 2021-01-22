//
//  BSYLiveProtoCustomMsgModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "BSYLiveProtoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveImageInfoModel;
@interface BSYLiveProtoCustomMsgModel : BSYLiveProtoBaseModel

@property (nonatomic, strong)BSYLiveImageInfoModel *msgContent;//

@property (nonatomic, strong)NSString *msgType; //

@end

NS_ASSUME_NONNULL_END
