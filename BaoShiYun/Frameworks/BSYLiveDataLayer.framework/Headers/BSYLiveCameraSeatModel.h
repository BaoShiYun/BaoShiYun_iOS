//
//  BSYLiveCameraSeatModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/11/10.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@class BSYLivePullStreamModel;
@interface BSYLiveCameraSeatModel : BSYMediaModel

@property (nonatomic, strong)NSString *cameraName;//机位名
@property (nonatomic, strong)NSString *cameraType;//机位类型（主/从机位）
@property (nonatomic, strong)NSString *streamName;//流名字
@property (nonatomic, strong)NSString *streamStatus;//流状态。running:推流中，stopped:没有流
@property (nonatomic, strong)NSString *pushUrl; //推流地址
@property (nonatomic, strong)NSArray<BSYLivePullStreamModel *> *pullUrls; //拉流地址列表

- (BOOL)isMasterCamera;
- (void)setMasterCamera:(BOOL)isMaster;
- (BOOL)isLiveStreaming;

@end

NS_ASSUME_NONNULL_END
