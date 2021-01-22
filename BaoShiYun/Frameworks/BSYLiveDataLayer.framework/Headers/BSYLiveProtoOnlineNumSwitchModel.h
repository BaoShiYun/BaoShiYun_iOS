//
//  BSYLiveProtoOnlineNumSwitchModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "BSYLiveProtoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveProtoOnlineNumSwitchModel : BSYLiveProtoBaseModel

@property (nonatomic, strong)NSString *switchStatus;   //OFF ON
@property (nonatomic, assign)NSInteger onlineNum; //switch值为Off情况下为0

@end

NS_ASSUME_NONNULL_END
