//
//  BSYLiveProtoLiveStatusChangedModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "BSYLiveProtoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveProtoLiveStatusChangedModel : BSYLiveProtoBaseModel

/******** 直播状态 ********/
@property (nonatomic, strong)NSString *status;

@end

NS_ASSUME_NONNULL_END
