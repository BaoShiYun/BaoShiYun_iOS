//
//  BSYLiveProtoMulitPullAddressChangedModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import "BSYLiveProtoBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveCameraSeatModel;
@interface BSYLiveProtoMulitPullAddressChangedModel : BSYLiveProtoBaseModel

@property (nonatomic, strong)NSString *timGroupId;  // timIMId
@property (nonatomic, strong)NSString *routeId;  //
@property (nonatomic, strong)NSString *routeName; //
@property (nonatomic, strong)NSArray<BSYLiveCameraSeatModel *> *cameraSeatList;

@end

NS_ASSUME_NONNULL_END
