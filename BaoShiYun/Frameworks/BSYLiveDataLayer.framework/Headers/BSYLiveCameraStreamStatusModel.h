//
//  BSYLiveCameraStreamStatusModel.h
//  BSYLiveDataLayer
//
//  Created by zddMac on 2020/12/3.
//  Copyright © 2020 zddMac. All rights reserved.
//

#import <BSYSDK/BSYSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSYLiveCameraStreamStatusModel : BSYMediaModel

@property (nonatomic, strong)NSString *liveId;
@property (nonatomic, strong)NSString *streamName;
@property (nonatomic, strong)NSString *status;

@end

NS_ASSUME_NONNULL_END
