//
//  BSYLiveProtoMulitPushAddressChangedModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "BSYLiveProtoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveRouteModel;
@interface BSYLiveProtoMulitPushAddressChangedModel : BSYLiveProtoBaseModel

@property (nonatomic, strong)NSString *timGroupId;  // IMId
@property (nonatomic, assign)uint64_t teacherUid;
@property (nonatomic, strong)NSArray <BSYLiveRouteModel *> *routeList;

@end

NS_ASSUME_NONNULL_END
