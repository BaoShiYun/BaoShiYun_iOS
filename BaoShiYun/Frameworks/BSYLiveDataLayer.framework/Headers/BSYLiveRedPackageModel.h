//
//  BSYLiveRedPackageModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@class BSYLiveRedPackageExtModel;
@interface BSYLiveRedPackageModel : BSYMediaModel

@property (nonatomic, assign) uint64_t activityId; // 22,
@property (nonatomic, strong) NSString *name; // "测试口令",
@property (nonatomic, strong) BSYLiveRedPackageExtModel *ext;

@end

@interface BSYLiveRedPackageExtModel : BSYMediaModel

@property (nonatomic, strong) NSString *webUrl; // "https://www.baidu.com",
@property (nonatomic, strong) NSString *mobileUrl; // "https://www.baoshiyun.com"

@end

NS_ASSUME_NONNULL_END
