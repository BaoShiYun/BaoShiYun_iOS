//
//  BSYLiveRouteModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveCameraSeatModel;
@interface BSYLiveRouteModel : BSYMediaModel
@property (nonatomic, strong)NSString *routeId; //线路ID
@property (nonatomic, strong)NSString *routeName; //线路名字
@property (nonatomic, strong)NSArray<BSYLiveCameraSeatModel *> *cameraSeatList; //机位信息

@end

NS_ASSUME_NONNULL_END
